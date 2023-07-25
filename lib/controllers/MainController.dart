import '../models/StudentModel.dart';
import '/exports/exports.dart';

class MainController with ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Map<String, dynamic>> _dashData = [];
  List<StudentModel> _students = [];

  List<GuardianModel> _guardians = [];
  List<StaffModel> _availableStaff = [];
 

  List<dynamic> _multiselect = [];
  List<OvertimeModel> _pendingOvertime = [];
  late PlatformFile _imageFile;

// getters
  List<StudentModel> get students => _students;
  List<StaffModel> get staffData => _availableStaff;
  List<GuardianModel> get guardians => _guardians;

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  List<Map<String, dynamic>> get dashboardData => _dashData;
  List<OvertimeModel> get pendingOvertime => _pendingOvertime;
  List<dynamic> get multiselect => _multiselect;
  PlatformFile get imageFile => _imageFile;
  // List<SchoolModel> get schools = _schools;

  // end of getters
  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
    // dispose off the scaffold key
    // set dashData
  }
  void disposeKey() {
    _scaffoldKey.currentState!.dispose();
  }
  void fetchUpdates(BuildContext context) {
    fetchDashboardMetaData(context).asStream().listen((v) {
      _dashData = v;
      notifyListeners();
    });
  }
// check for new entries of students
  void staffUpdate() {
    Client().get(Uri.parse(AppUrls.staff)).then((response) {
      _availableStaff = staffModelFromJson(response.body);
      notifyListeners();
    });
  }

  // check new guardians
  void newGuardians() {
    Client().get(Uri.parse(AppUrls.getGuardians)).then((value) {
      _guardians = guardiansFromJson(value.body).results;;
      notifyListeners();
    });
  }

//  fetch pending overtimes
void fetchPendingOvertime(String status){
  Client().get(Uri.parse(AppUrls.specficOvertime + status)).then((value) {
    _pendingOvertime = overtimeModelFromJson(value.body);
    notifyListeners();
  });
}
//
void newSelection(List<dynamic> selection){
    _multiselect = selection;
    notifyListeners();
}

  void searchStaff(String value){
    Client().get(Uri.parse(AppUrls.staff)).then((value) {
      if(value.statusCode == 200){
        _availableStaff = staffModelFromJson(value.body).where((element) => element.staffFname == value || element.staffLname == value).toList();
        notifyListeners();
      }
    });
  }
 void imageUpload(PlatformFile file) {
  _imageFile = file;
  debugPrint("${file.path}");
  notifyListeners();
 }

}