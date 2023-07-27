import 'package:malticard/controllers/GuardianIdController.dart';

import '../../controllers/DashbaordWidgetController.dart';
import '../../exports/exports.dart';
import '../../models/StudentModel.dart';
import 'Guardians.dart';
import 'helpers/DataSource.dart';

class StudentsView extends StatefulWidget {
  final String guardianId;
  const StudentsView({super.key, required this.guardianId});

  @override
  State<StudentsView> createState() => _StudentsViewState();
}

class _StudentsViewState extends State<StudentsView> {
  List<StudentModel> _filteredRows = [];
  Timer? timer;
  int rowsPerPage = 20;
  final PaginatorController _controller = PaginatorController();
  // stream controller
  StreamController<List<StudentModel>> _studentController =
      StreamController<List<StudentModel>>();
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
        var students = await fetchGuardianStudents(widget.guardianId);
        _studentController.add(students);
      }
      // Listen to the stream and update the UI

      Timer.periodic(Duration(seconds: 3), (timer) async {
        this.timer = timer;
        // Add a check to see if the widget is still mounted before updating the state
        if (mounted) {
          var students = await fetchGuardianStudents(widget.guardianId);
          _studentController.add(students);
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
          _filteredRows = snapshot.data ?? [];
          return snapshot.hasData
              ? CustomDataTable(
                  paginatorController: _controller,
                  title: "Guardian's Students",
                  actions: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      height: 100,
                      child: TextFormField(
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
                  source: StudentsDataSource(
                    data: _filteredRows,
                    guardianId: widget.guardianId,
                    context: context,
                  ),
                  empty: NoDataWidget(),
                  header: BlocConsumer<GuardianIdController, String>(
                    listener: (context, state) {
                  
                    },
                    builder: (context, school_Id) {
                      return Row(
                        children: [
                          TextButton.icon(
                            onPressed: () {
                              BlocProvider.of<DashboardWidgetController>(
                                      context)
                                  .changeWidget(
                                 SchoolGuardians(
                          schoolId: school_Id,
                        ),
                              );
                              print("Back to => ${school_Id}");
                            },
                            label: Text("Back to Guardians"),
                            icon: Icon(Icons.arrow_back),
                          ),
                        ],
                      );
                    },
                  ),
                  columns: [
                    DataColumn(label: Text('Student\'s Profile')),
                    DataColumn(label: Text('Student\'s Name')),
                    DataColumn(label: Text('Student\'s Class')),
                    DataColumn(label: Text("Qr Code")),
                    DataColumn(label: Text("Copy Code")),
                  ],
                  topWidget: SizedBox(),
                )
              : Loader(
                  text: "Students...",
                );
        });
  }
}
