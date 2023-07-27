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

  // check new guardians
  void newGuardians() {
    Client().get(Uri.parse(AppUrls.getGuardians)).then((value) {
      _guardians = guardiansFromJson(value.body).results;;
      notifyListeners();
    });
  }

}