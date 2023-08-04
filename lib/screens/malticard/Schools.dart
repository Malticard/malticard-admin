import 'package:malticard/controllers/DashbaordWidgetController.dart';
import 'package:malticard/screens/malticard/Guardians.dart';
import '/screens/malticard/helpers/DataSource.dart';

import '/exports/exports.dart';

class Schools extends StatefulWidget {
  const Schools({super.key});

  @override
  State<Schools> createState() => _SchoolsState();
}

class _SchoolsState extends State<Schools> {
  List<Result> filteredRows = [];
  String? _querySchool;
  int _page = 1;
  int _rowsPerpage = 20;
  final PaginatorController _paginatorController = PaginatorController();
  // stream controller
  StreamController<SchoolModel> _schoolController =
      StreamController<SchoolModel>();
  Timer? timer;
  @override
  void initState() {
    super.initState();
    fetchRealTimeData();
  }

  @override
  void dispose() {
    if (_schoolController.hasListener) {
      _schoolController.close();
    }
    _paginatorController.dispose();
    timer?.cancel();
    super.dispose();
  }

  void fetchRealTimeData() async {
    try {
      // Add a check to see if the widget is still mounted before updating the state
      if (mounted) {
        var school = await fetchSchools(page: _page, limit: _rowsPerpage);
        _schoolController.add(school);
      }
      // Listen to the stream and update the UI

      Timer.periodic(Duration(seconds: 3), (timer) async {
        this.timer = timer;
        // Add a check to see if the widget is still mounted before updating the state
        if (mounted) {
          if (_querySchool != null) {
            var school = await searchSchools(_querySchool ?? "");
            _schoolController.add(school);
          } else {
            var school = await fetchSchools(page: _page, limit: _rowsPerpage);
            _schoolController.add(school);
          }
        }
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _schoolController.stream,
        builder: (context, snapshot) {
          var schoolData = snapshot.data;
          filteredRows = snapshot.data?.results ?? [];
          return CustomDataTable(
                empty: !snapshot.hasData ?  Loader(
                  text: "Schools...",
                ) : NoDataWidget(text: "No Schools found",),
                  paginatorController: _paginatorController,
                  rowsPerPage: _rowsPerpage,
                  header: Row(
                    children: [
                      SizedBox(
                        width: 150,
                        height: 50,
                        child: ElevatedButton.icon(
                          icon: Icon(Icons.add),
                          label: Text("Add School"),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 50,
                                    height:
                                        MediaQuery.of(context).size.width / 50,
                                    child: AddSchoolView(),
                                  );
                                });
                          },
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      height: 100,
                      child: TextFormField(
                        onChanged: (value) {
                          // debugPrint(value);

                          if (value.isEmpty) {
                            setState(() {
                              _querySchool = null;
                            });
                          } else {
                            setState(() {
                              _querySchool = value;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Search",
                        ),
                      ),
                    )
                  ],
                  onPageChanged: (page) {
                    // print("Page: ${(page / _rowsPerpage) + 1}");
                    setState(() {
                      _page = ((page / _rowsPerpage) + 1).toInt();
                    });
                  },
                  onRowsPerPageChange: (value) {
                    setState(() {
                      _rowsPerpage = value!;
                    });
                  },
                  source: SchoolDataSource(
                    context,
                    paginatorController: _paginatorController,
                    totalDocuments: schoolData?.totalDocuments ?? 0,
                    data: filteredRows,
                    onTap: (value) {
                      BlocProvider.of<DashboardWidgetController>(context)
                          .changeWidget(
                        SchoolGuardians(
                          schoolId: value.trim(),
                        ),
                      );
                    },
                    currentPage: _page,
                  ),
                  columns: [
                    // DataColumn(label: Text('#')),
                    DataColumn(label: Text('School Badge')),
                    DataColumn(label: Text('School Name')),
                    DataColumn(label: Text('School Email')),
                    DataColumn(label: Text('Actions')),
                  ],
                  topWidget: Container(),
                )
              ;
        });
  }
}
