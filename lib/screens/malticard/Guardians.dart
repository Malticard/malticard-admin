import 'package:malticard/screens/malticard/Schools.dart';
import 'package:malticard/screens/malticard/Students.dart';
import '../../controllers/DashbaordWidgetController.dart';
import '../../controllers/GuardianIdController.dart';
import '/screens/malticard/helpers/DataSource.dart';

import '/exports/exports.dart';

class SchoolGuardians extends StatefulWidget {
  final String schoolId;
  const SchoolGuardians({super.key, required this.schoolId});

  @override
  State<SchoolGuardians> createState() => _SchoolGuardiansState();
}

class _SchoolGuardiansState extends State<SchoolGuardians> {
  final _queryController = TextEditingController();
  List<GuardianModel> _filteredRows = [];
  int _currentPage = 1;
  int _rowsPerpage = 20;
  final _paginatorController = PaginatorController();
  // stream controller
  StreamController<Guardians> _guardianController =
      StreamController<Guardians>();
  String? _query;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    _fetchRealTimeData();
  }

  @override
  void dispose() {
    if (_guardianController.hasListener) {
      _guardianController.close();
    }
    timer?.cancel();
    super.dispose();
  }

  void _fetchRealTimeData() async {
    try {
      // Add a check to see if the widget is still mounted before updating the state
      if (mounted) {
        var guardians = await fetchGuardians(widget.schoolId,
            page: _currentPage, limit: _rowsPerpage);
        _guardianController.add(guardians);
      }
      // Listen to the stream and update the UI

      Timer.periodic(Duration(seconds: 1), (timer) async {
        this.timer = timer;
        // Add a check to see if the widget is still mounted before updating the state
        if (mounted) {
          if (_queryController.text.isNotEmpty) {
            // logic for searching available guardians
            var guardians = await searchGuardians(
                widget.schoolId, _queryController.text,
                page: _currentPage, limit: _rowsPerpage);
            _guardianController.add(guardians);
          } else {
            var guardians = await fetchGuardians(widget.schoolId,
                page: _currentPage, limit: _rowsPerpage);
            _guardianController.add(guardians);
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
        stream: _guardianController.stream,
        builder: (context, snapshot) {
          var guardians = snapshot.data;
          _filteredRows = snapshot.data?.results ?? [];
          return CustomDataTable(
                empty: !snapshot.hasData ?  Loader(
                  text: "Guardians...",
                ) : NoDataWidget(text: "No Guardians found",),
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
                          controller: _queryController,
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
                      // capture guardian id
                      BlocProvider.of<GuardianIdController>(context)
                          .setGuardianId(widget.schoolId.trim());
                    },
                    currentPage: _currentPage,
                    totalDocuments: guardians?.totalDocuments ?? 0,
                  ),
                  
                  header: Row(
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          BlocProvider.of<DashboardWidgetController>(context)
                              .changeWidget(
                            Schools(),
                          );
                        },
                        icon: Icon(Icons.arrow_back),
                        label: Text("Back to Schools"),
                      ),
                    ],
                  ),
                  columns: [
                    DataColumn(label: Text('#')),
                    DataColumn(label: Text('Guardian\'s Name')),
                    DataColumn(label: Text('Guardian\'s Email')),
                  ],
                  topWidget: SizedBox(),
                );
        });
  }
}
