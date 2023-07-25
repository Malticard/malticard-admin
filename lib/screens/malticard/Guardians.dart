import 'package:malticard/screens/malticard/Schools.dart';
import 'package:malticard/screens/malticard/Students.dart';

import '../../controllers/BreadCrumbController.dart';
import '../../controllers/DashbaordWidgetController.dart';
import '/screens/malticard/helpers/DataSource.dart';

import '/exports/exports.dart';

class SchoolGuardians extends StatefulWidget {
  final String schoolId;
  const SchoolGuardians({super.key, required this.schoolId});

  @override
  State<SchoolGuardians> createState() => _SchoolGuardiansState();
}

class _SchoolGuardiansState extends State<SchoolGuardians> {
  List<GuardianModel> _filteredRows = [];
  int _currentPage = 1;
  int _rowsPerpage = 20;
  final _paginatorController = PaginatorController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: fetchGuardians(widget.schoolId,
                page: _currentPage, limit: _rowsPerpage)
            .asStream(),
        builder: (context, snapshot) {
          var guardians = snapshot.data;
          _filteredRows = snapshot.data?.results ?? [];
          return snapshot.hasData
              ? CustomDataTable(
                  rowsPerPage: _rowsPerpage,
                  onRowsPerPageChange: (rows) {
                    setState(() {
                      _rowsPerpage = rows ?? 0;
                    });
                  },
                  paginatorController: _paginatorController,
                  title: "Guardians",
                  onPageChanged: (value) {
                    setState(() {
                      _currentPage = (value ~/ _rowsPerpage);
                    });
                  },
                  actions: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      height: 100,
                      child: TextFormField(
                          decoration: InputDecoration(
                        labelText: "Search",
                      )),
                    )
                  ],
                  source: GuardiansDataSource(
                    paginatorController: _paginatorController,
                    data: _filteredRows,
                    onTap: (guardianId) {
                      BlocProvider.of<DashboardWidgetController>(context)
                          .changeWidget(StudentsView(guardianId: guardianId));
                    },
                    currentPage: _currentPage,
                    totalDocuments: guardians?.totalDocuments ?? 0,
                  ),
                  empty: NoDataWidget(),
                  header: Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          BlocProvider.of<DashboardWidgetController>(context)
                              .changeWidget(
                            Schools(),
                          );
                        },
                        child: Text("Back to Schools"),
                      ),
                    ],
                  ),
                  columns: [
                    DataColumn(label: Text('#')),
                    DataColumn(label: Text('Guardian\'s Name')),
                    DataColumn(label: Text('Guardian\'s Email')),
                  ],
                  topWidget: SizedBox(),
                )
              : Loader(
                  text: "Guardians...",
                );
        });
  }
}
