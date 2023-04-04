import '/exports/exports.dart';

class MainController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Map<String, dynamic>> _dashData = [];
  List<StudentModel> _students = [];
  List<DropOffModel> _drops = [];
  List<PickUpModel> _picks = [];
  List<Guardians> _guardians = [];
  List<StaffModel> _availableStaff = [];
  List<ClassModel> _classes = [];
  int _stepCount = 0;
  List<dynamic> _multiselect = [];
  List<OvertimeModel> _pendingOvertime = [];

// getters
  List<StudentModel> get students => _students;
  List<StaffModel> get staffData => _availableStaff;
  List<Guardians> get guardians => _guardians;
  List<DropOffModel> get dropOffData => _drops;
  int get stepCount => _stepCount;
  List<PickUpModel> get pickUpData => _picks;
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  List<Map<String, dynamic>> get dashboardData => _dashData;
  List<OvertimeModel> get pendingOvertime => _pendingOvertime;
  List<dynamic> get multiselect => _multiselect;
  List<ClassModel> get classes => _classes;
  // end of getters

  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
    // dispose off the scaffold key

    // _scaffoldKey.currentState!.dispose();
    // function to fetch updates for the dashboard

    // set dashData
  }
  void disposeKey() {
    _scaffoldKey.currentState!.dispose();
  }
  void fetchUpdates(BuildContext context) {
    fetchDashboardMetaData(context).then((v) {
      _dashData = v;
      notifyListeners();
    });
  }

  // getting available students
  void getAllStudents() {
    fetchStudents().then((v) {
      _students = v;
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
      _guardians = guardiansFromJson(value.body);
      notifyListeners();
    });
  }

  // available picks and drops
  availableDropOffs() {
    dropOffs().then((drops) {
      _drops = drops;
      notifyListeners();
    });
  }

  availablePickUps() {
    pickUps().then((picks) {
      _picks = picks;
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
// stepper text count
void setTextCount(int value){
    _stepCount = value;
    notifyListeners();
}
//
void newSelection(List<dynamic> selection){
    _multiselect = selection;
    notifyListeners();
}
// method to fetch available classes
void fetchClasses(){
  Client().get(Uri.parse(AppUrls.getClasses)).then((value) {
    if(value.statusCode == 200){
     _classes = classModelFromJson(value.body);
      notifyListeners();
    }
  });
}
  // functtion to search for staff members by  either first name or last nam

  void searchStaff(String value){
    Client().get(Uri.parse(AppUrls.staff)).then((value) {
      if(value.statusCode == 200){
        _availableStaff = staffModelFromJson(value.body).where((element) => element.staffFname == value || element.staffLname == value).toList();
        notifyListeners();
      }
    });
  }
}