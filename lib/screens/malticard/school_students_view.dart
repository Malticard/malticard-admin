import 'dart:developer';
import '../../controllers/DashbaordWidgetController.dart';
import '../../exports/exports.dart';

import '../../models/school_student_model.dart';
import '../../models/school_student_model.dart' as st;
import 'Schools.dart';
import 'helpers/DataSource.dart';
import 'school_students.dart';

class StudentSchoolView extends StatefulWidget {
  final String schoolId;
  const StudentSchoolView({super.key, required this.schoolId});

  @override
  State<StudentSchoolView> createState() => _StudentSchoolViewState();
}

class _StudentSchoolViewState extends State<StudentSchoolView> {
  List<st.Result> _filteredRows = [];
  Timer? timer;
  int _page = 1;
  int _rowsPerpage = 20;
  final PaginatorController _controller = PaginatorController();
  // stream controller
  StreamController<SchoolStudentsModel> _studentController =
      StreamController<SchoolStudentsModel>();
  final _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    fetchStudentsRealTimeData();
  }

  @override
  void dispose() {
    if (_studentController.hasListener) {
      _studentController.close();
    }
    timer?.cancel();
    super.dispose();
  }

  void fetchStudentsRealTimeData() async {
    try {
      // Fetch the initial data from the server

      // Add a check to see if the widget is still mounted before updating the state
      if (mounted) {
        var students = await fetchSchoolStudents(widget.schoolId,
            page: _page, limit: _rowsPerpage);
        _studentController.add(students);
      }
      // Listen to the stream and update the UI

      Timer.periodic(Duration(seconds: 3), (timer) async {
        this.timer = timer;
        // Add a check to see if the widget is still mounted before updating the state
        if (mounted) {
          if (_searchController.text.isNotEmpty) {
            // var students = await searchStudents(
            //     widget.schoolId, _searchController.text,
            //     page: 1, limit: rowsPerPage);
            // _studentController.add(students);
          } else {
            try {
              var students = await fetchSchoolStudents(widget.schoolId,
                  page: _page, limit: _rowsPerpage);
              _studentController.add(students);
            } on ClientException catch (e, x) {
              log(e.toString());
            }
          }
        }
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  String schoolId = "";
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _studentController.stream,
        builder: (context, snapshot) {
          _filteredRows = snapshot.data?.results ?? [];
          return CustomDataTable(
            empty: !snapshot.hasData
                ? Loader(
                    text: "Students...",
                  )
                : NoDataWidget(
                    text: "No Students found",
                  ),
            paginatorController: _controller,
            rowsPerPage: _rowsPerpage,
            title: "Students",
            actions: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                height: 100,
                child: TextFormField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        if (value.isEmpty) {
                        } else {
                          _filteredRows = _filteredRows.where((row) {
                            return row.studentLname == value ||
                                row.studentFname == value;
                          }).toList();
                        }
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Search",
                    )),
              )
            ],
            source: SchoolStudentsDataSource(
              data: _filteredRows,
              schoolId: widget.schoolId,
              paginatorController: _controller,
              context: context,
              currentPage: _page,
              totalDocuments:
                  snapshot.hasData ? snapshot.data?.totalDocuments ?? 0 : 0,
            ),
            header: Row(
              children: [
                TextButton.icon(
                  onPressed: () {
                    BlocProvider.of<TitleController>(context)
                        .setTitle("Schools");
                    BlocProvider.of<DashboardWidgetController>(context)
                        .changeWidget(
                      SchoolStudents(),
                    );
                  },
                  label: Text("Back to Schools"),
                  icon: Icon(Icons.arrow_back),
                ),
              ],
            ),
            onPageChanged: (page) {
              setState(() {
                _page = ((page / _rowsPerpage) + 1).toInt();
              });
            },
            onRowsPerPageChange: (value) {
              setState(() {
                _rowsPerpage = value!;
              });
            },
            columns: [
              DataColumn(label: Text('Student\'s Profile')),
              DataColumn(label: Text('Student\'s Name')),
              DataColumn(label: Text('Student\'s Class')),
              DataColumn(label: Text("Qr Code")),
              DataColumn(label: Text("Copy Code")),
              DataColumn(label: Text("Download QrCode")),
            ],
            topWidget: SizedBox(),
          );
        });
  }
}
