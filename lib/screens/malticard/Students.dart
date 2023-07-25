import '../../controllers/BreadCrumbController.dart';
import '../../controllers/DashbaordWidgetController.dart';
import '../../exports/exports.dart';
import '../../models/StudentModel.dart';
import 'Schools.dart';
import 'helpers/DataSource.dart';

class StudentsView extends StatefulWidget {
  final String guardianId;
  const StudentsView({super.key, required this.guardianId});

  @override
  State<StudentsView> createState() => _StudentsViewState();
}

class _StudentsViewState extends State<StudentsView> {
  List<StudentModel> _filteredRows = [];
  final _pageController = PaginatorController();
  @override
  Widget build(BuildContext context) {
        return StreamBuilder(
        stream: fetchGuardianStudents(widget.guardianId).asStream(),
        builder: (context, snapshot) {
          _filteredRows = snapshot.data ?? [];
          return snapshot.hasData
              ? CustomDataTable(
                paginatorController: _pageController,
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
                                  return row.studentLname == value || row.studentFname == value;
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
                      data: _filteredRows, guardianId:widget.guardianId, context: context,
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