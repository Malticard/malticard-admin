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
  int _page = 1;
  int _rowsPerpage = 20;
  final PaginatorController _paginatorController = PaginatorController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: fetchSchools(page: _page, limit: _rowsPerpage).asStream(),
        builder: (context, snapshot) {
          var schoolData = snapshot.data;
          filteredRows = snapshot.data?.results ?? [];
          return snapshot.hasData
              ? CustomDataTable(
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
                          setState(() {
                            if (value.isEmpty) {
                              filteredRows = [];
                            } else {}
                          });
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
                      }, currentPage: _page),
                  columns: [
                    // DataColumn(label: Text('#')),
                    DataColumn(label: Text('School Badge')),
                    DataColumn(label: Text('School Name')),
                    DataColumn(label: Text('School Email')),
                  ],
                  topWidget: Container(),
                )
              : Loader(
                  text: "Schools...",
                );
        });
  }

  @override
  void dispose() {
    _paginatorController.dispose();
    super.dispose();
  }
}
