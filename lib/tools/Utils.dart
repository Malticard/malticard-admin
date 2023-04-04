import 'dart:convert';
import 'dart:ui';

import '/exports/exports.dart';

// login logic for the user
loginUser(BuildContext context, String email, String password) async {
  showProgress(context, msg: "Login in progress");

  Client().post(Uri.parse(AppUrls.login), body: {
    "staff_email": email,
    "staff_password": password,
  }).then((value) {
    if (value.statusCode == 200) {
      var data = jsonDecode(value.body);

      Routes.popPage(context);
      debugPrint("Login response ${data}");
      BlocProvider.of<SchoolController>(context).setSchoolData(data);
      Routes.namedRemovedUntilRoute(
        context, Routes.home);
      showMessage(
        context: context,
        msg: "Login successfully..",
        type: 'success',
      );
    } else {
      var data = jsonDecode(value.body);
      Routes.popPage(context);
      showMessage(
          context: context,
          msg: "${value.statusCode} => ${data['message']}",
          type: 'danger');
    }
  }).whenComplete(() {});
  // final prefs = await SharedPreferences.getInstance();
  // prefs.setString('role', "${context.read<SchoolController>().state['role']}");
}

// global functions
Future<String> assignRole(String role) async {
  var response = await Client().get(Uri.parse(AppUrls.roles));
  final roles = rolesFromJson(response.body);
  var result = roles.firstWhere((element) => element.roleType == role);
  return result.id;
}

// greetings
String greetUser() {
  String greet = '';
  var time = TimeOfDay.now();
  int t = time.hour;
  if (t > 20) {
    greet = "Good night";
  } else if (t < 20 && t > 15) {
    greet = "Good evening";
  } else if (t > -1 && t < 13) {
    greet = "Good morning";
  } else {
    greet = "Good afternoon";
  }

  return greet;
}

// dialog
void showAppDialog(BuildContext context,
    {String? title,
    String? denyText,
    String? confirmText,
    bool showCancel = false,
    String? successText,
    String? errorText}) async {
  ArtDialogResponse response = await ArtSweetAlert.show(
      barrierDismissible: false,
      context: context,
      artDialogArgs: ArtDialogArgs(
        showCancelBtn: true,
        denyButtonText: denyText ?? "Don't save",
        title: title ?? "Do you want to save the changes?",
        confirmButtonText: confirmText ?? "Save",
      ));

  if (response.isTapConfirmButton) {
    ArtSweetAlert.show(
        context: context,
        artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.success, title: successText ?? "Saved!"));
    return;
  }
  if (response.isTapCancelButton) {
    ArtSweetAlert.show(
      context: context,
      artDialogArgs: ArtDialogArgs(
          type: ArtSweetAlertType.success,
          title: successText ?? "Operation cancel...."),
    );
  }

  if (response.isTapDenyButton) {
    ArtSweetAlert.show(
        context: context,
        artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.info,
            title: errorText ?? "Changes are not saved!"));
    return;
  }
}

// return students
Future<List<StudentModel>> fetchStudents() async {
  var res = await Client().get(Uri.parse(AppUrls.students));
  return studentModelFromJson(res.body);
}

Future<StudentModel> getSpecificStudent(String n) async {
  var st = await fetchStudents();
  return st.firstWhere((element) => element.studentFname == n);
}

// show successDialog
void showSuccessDialog(String name, BuildContext context,
    {VoidCallback? onPressed}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        "$name added successfully",
        textAlign: TextAlign.center,
        // overflow: TextOverflow,
        style: TextStyles(context).getRegularStyle(),
      ),
      content: Icon(Icons.check_circle_outline_rounded,
          size: 75, color: Colors.green),
      actions: [
        TextButton(
          onPressed: onPressed ??
              () {
                Routes.popPage(context);
                // Routes.namedRoute(context, Routes.dashboard);
              },
          child: Text("Okay"),
        )
      ],
    ),
  );
}

// show content dialog
void showContentDialog(String name, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Text(
        name,
        overflow: TextOverflow.visible,
        style: TextStyles(context).getRegularStyle(),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Routes.popPage(context);
            // Routes.namedRoute(context, Routes.dashboard);
          },
          child: Text(
            "Okay",
            style: TextStyles(context).getRegularStyle(),
          ),
        )
      ],
    ),
  );
}

// validate email
bool validateEmail(String email, BuildContext context) {
  bool isValid = true;
  String error = '';
  if (email.trim().isEmpty) {
    error = "Email can't be empty";

    isValid = false;
  } else if (!Validator_.validateEmail(email.trim())) {
    error = "Provide a valid email";

    isValid = false;
  }
  if (error != '') {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error),
        // behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
      ),
    );
  }

  return isValid;
}

// action buttons
// build Action Buttons
Widget buildActionButtons(BuildContext context,VoidCallback
edit,VoidCallback delete) {
  return Row(
    children: [
      TextButton(
        onPressed: edit,
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
        style: TextButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
      ),
      SizedBox(
        width: 10,
      ),
      TextButton(
        onPressed: delete,
        //     () {
        //
        //   showAppDialog(context,
        //       title: "Are you sure you want to delete $text?");
        // },
        child: Icon(Icons.delete_outline_rounded, color: Colors.white),
        style: TextButton.styleFrom(
          backgroundColor: Colors.red,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
      ),
    ],
  );
}
// build dashboard cards
// Widget buildBody(BuildContext context) {
//   Size size = MediaQuery.of(context).size;
//   return SizedBox(
//     width: size.width,
//     child: FutureBuilder(
//         // future: fetchDashboardMetaData(),
//         builder: (context, snapshot) {
//           var data = snapshot.data ?? [];
//           return snapshot.connectionState == ConnectionState.waiting
//               ? const Center(child: Loader(text: "Dashboard"))
//               : snapshot.hasData
//                   ? Flex(
//                       direction: Axis.horizontal,
//                       children: List.generate(
//                         data.length,
//                         (index) => SizedBox(
//                           width: size.width * 0.123,
//                           height: size.width * 0.123,
//                           child: DashboardCard(
//                             label: data[index]['label'],
//                             value: data[index]['value'],
//                             icon: data[index]['icon'],
//                             color: data[index]['color'],
//                             last_updated: data[index]['last_updated'],
//                           ),
//                         ),
//                       ),
//                     )
//                   : const Center(
//                       child: Text("No Data"),
//                     );
//         }),
//   );
// }

// malticard views
List<Map<String, dynamic>> malticardViews = [
  {
    "icon": "assets/icons/menu_dashbord.svg",
    "title": "Dashboard",
    "page": const Dashboard()
  },
  {
    "title": "Add School",
    "page": const MalticardView(),
    'icon': "assets/icons/menu_store.svg"
  },
];
// valid text controllers
bool validateTextControllers(List<TextEditingController> controllers) {
  var ct = controllers.where((element) => element.text.isEmpty).toList();
  return ct.length < 1 ? true : false;
}

/// show snackbar message
/// @param type = 'danger' | 'info' | warning
///
///
void showMessage(
    {String type = 'info',
    String? msg,
    bool float = false,
    required BuildContext context,
    double opacity = 1,
    int duration = 5,
    Animation<double>? animation}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: float ? SnackBarBehavior.floating : SnackBarBehavior.fixed,
      content: Text(msg ?? ''),
      backgroundColor: type == 'info'
          ? Colors.lightBlue
          : type == 'warning'
              ? Colors.orange[800]!.withOpacity(opacity)
              : type == 'danger'
                  ? Colors.red[800]!.withOpacity(opacity)
                  : type == 'success'
                      ? Color.fromARGB(255, 2, 104, 7).withOpacity(opacity)
                      : Colors.grey[600]!.withOpacity(opacity),
      duration: Duration(seconds: duration),
    ),
  );
}

// show progress widget
void showProgress(BuildContext context, {String? msg}) {
  showModal(
    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
    context: context,
    builder: (context) => BottomSheet(
      enableDrag: false,
      backgroundColor: Colors.black12,
      onClosing: () {},
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SpinKitDualRing(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Theme.of(context).primaryColor),
          Space(
            space: 0.03,
          ),
          Text(
            msg ?? "Task in progress",
            style: TextStyles(context)
                .getRegularStyle()
                .copyWith(color: Colors.white),
          )
        ],
      ),
    ),
  );
}

// mark dates
String markDates(int date) {
  if (date == 1 || date == 21 || date == 31) {
    return "${date}st";
  } else if (date == 2 || date == 22) {
    return "${date}nd";
  } else if (date == 3 || date == 23) {
    return "${date}rd";
  }
  return "${date}th";
}

// configure am / pm
String amPm() {
  return time.hour > 0 && time.hour < 12 ? "am" : "pm";
}

// Days of the week
List<String> days = <String>["Mon", "Tue", "Wed", "Thur", "Fri", "Sat", "Sun"];
// months of the year
List<String> months = <String>[
  "Jan",
  "Feb",
  "Marc",
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec",
];
// compute students total
Future<int> computeStudentsTotal() async {
  int students = 0;
  var response = await fetchStudents();
  students = response.length;
  // debugPrint("Total => $students");
  return students;
}

// fetch overtimes
// fetch pickups
Future<List<PickUpModel>> fetchPickups(String id) async {
  var response = await Client().get(Uri.parse(AppUrls.pickUps + id));
  return response.statusCode == 201 || response.statusCode == 200
      ? pickUpModelFromJson(response.body)
      : [];
  // return;
  // return response;
}

// fetch pickups
Future<List<PickUpModel>> pickUps() async {
  var response = await Client().get(Uri.parse(AppUrls.getPickUps));
  return response.statusCode == 201 || response.statusCode == 200
      ? pickUpModelFromJson(response.body)
      : [];
  // return;
  // return response;
}

// drop offs
Future<List<DropOffModel>> fetchDropOffs(String id) async {
  var response = await Client().get(Uri.parse(AppUrls.dropOffs + id));
  return dropOffModelFromJson(response.body);
  // return response;
}

// drop offs
Future<List<DropOffModel>> dropOffs() async {
  var response = await Client().get(Uri.parse(AppUrls.getDropOffs));
  return dropOffModelFromJson(response.body);
  // return response;
}

/// *
/// Dashboard cards

// fetch overtimes
Future<List<OvertimeModel>> fetchOvertimeData(String status) async {
  var response = await Client().get(Uri.parse(AppUrls.overtime));
  return overtimeModelFromJson(response.body).where((element) => element.status == status).toList();
  // return response;
}

// function handling scan intervals

DateTime time = DateTime.now();
String handSanIntervals() {
  return time.hour > 6 && time.hour < 12
      ? "DropOffs"
      : time.hour > 12 && time.hour < 18
          ? "PickUps"
          : "Nothing taking place currently";
}

// fetch dashboard meta data
Future<List<Map<String, dynamic>>> fetchDashboardMetaData(
    BuildContext context) async {
  // get students total
  // int students = await computeStudentsTotal();
  // // var drops = await dropOffs();
  // var picks = await pickUps();
  // var clearedOvertimes = await fetchOvertimeData("Cleared");
  // var pendingOvertimes = await fetchOvertimeData("Pending");

  List<Map<String, dynamic>> dashboardData = [
    {
      "label": "DROP OFFS",
      "value": 0,//drops.length,
      "icon": "assets/icons/004-playtime.svg",
      'color': Color.fromARGB(255, 106, 108, 235),
      "last_updated": "14:45"
    },
    {
      "label": "PICK UPS",
      "value": 0,
      "icon": "assets/icons/009-student.svg",
      'color': Color.fromARGB(255, 181, 150, 253),
      "last_updated": "14:45"
    },
    {
      "label": "CLEARED OVERTIME",
      "value": 0,
      "icon": "assets/icons/002-all.svg",
      'color': Color.fromARGB(255, 77, 154, 255),
      "last_updated": "14:45"
    },
    {
      "label": "PENDING OVERTIME",
      "value": 0,//pendingOvertimes.length,
      "icon": "assets/icons/005-overtime.svg",
      'color': Color.fromARGB(255, 50, 66, 95),
      "last_updated": "14:45"
    },
  ];
  List<Map<String, dynamic>> financeData = [
    {
      "label": "CLEARED OVERTIME",
      "value": 0,//clearedOvertimes.length,
      "icon": "assets/icons/005-overtime.svg",
      'color': Color.fromARGB(255, 50, 66, 95),
      "last_updated": "14:45"
    },
    {
      "label": "PENDING OVERTIME",
      "value": 0,//pendingOvertimes.length,
      "icon": "assets/icons/005-overtime.svg",
      'color': Color.fromARGB(255, 50, 66, 95),
      "last_updated": "14:45"
    },
  ];
  List<Map<String, dynamic>> malticardData = [
    {
      "label": "SCHOOLS",
      "value": 0,//pendingOvertimes.length,
      "icon": "assets/icons/005-overtime.svg",
      'color': Color.fromARGB(255, 50, 66, 95),
      "last_updated": "14:45"
    }
  ];
  return Provider.of<SchoolController>(context, listen: false).state['role'] ==
  'Admin' || Provider.of<SchoolController>(context, listen: false).state['role'] == 'SuperAdmin'
      ? dashboardData
      : Provider.of<SchoolController>(context, listen: false).state['role'] ==
  'Finance'? financeData : malticardData;
}

// logic to fetch a specific guardian from the scanners
Future<Map<String, dynamic>> fetchSpecificGuardian(String id) async {
  var response = await Client().get(Uri.parse(AppUrls.getGuardian + id));
  debugPrint("Response ${response.body}");
  var guardianData = guardianModelFromJson(response.body);
// get the coresponding student for this guardian
  var student =
      await Client().get(Uri.parse(AppUrls.getStudent + guardianData.student));
  var studentData = studentModelFromJson(student.body)[0];
  //  fetch the corresponding guardians or other guardians
  var otherGuardians = await Client()
      .get(Uri.parse(AppUrls.getOtherGaurdians + guardianData.student));
  var otherGuardianData = guardiansFromJson(otherGuardians.body);
  // output resonse of data
  Map<String, dynamic> results = {
    "student_name": "${studentData.studentFname} ${studentData.studentLname}",
    "student_pic": studentData.studentProfilePic,
    "student_class": studentData.studentClass,
    "student_id": studentData.id,
    "picker_name":
        "${guardianData.guardianFname} ${guardianData.guardianLname}",
    "picker_id": guardianData.id,
    "relationship": guardianData.relationship,
    "picker_contact": guardianData.guardianContact,
    "others": otherGuardianData
  };
  return results;
}

registerDropOffOrPickUp(var data, BuildContext context) async {
  String msg = handSanIntervals();
  // save dropoff or pickup

  var response = await Client().post(
      Uri.parse(handSanIntervals() == "PickUps"
          ? AppUrls.addPickUp
          : AppUrls.addDropOff),
      body: data);
  if (response.statusCode == 201) {
    Routes.popPage(context);
    showMessage(
        context: context, msg: "$msg registered successfully", type: 'success');

    // showSuccessDialog("$msg registered successfully", context);
    Routes.namedRoute(context, Routes.home);
  } else {
    Routes.popPage(context);

    // showMessage(
    //     context: context,
    //     msg:
    //         "Error handling $handSanIntervals() ${response.statusCode} => ${response.reasonPhrase}",
    //     type: 'danger');
    showContentDialog(
        "Error handling $msg\n ${response.statusCode} => ${response.reasonPhrase}",
        context);
  }
}

// determine overtime
overtimes(BuildContext context) async {
  var checker = InternetConnectionChecker.createInstance();
  // String overtimeMsg = "";
  checker.hasConnection.then((online) {
    context.read<OnlineCheckerController>().updateChecker(online);
  });
  // check if the user is online
  if (context.read<OnlineCheckerController>().state) {
    // check if the user is online
    var response = await Client().get(Uri.parse(AppUrls.settings));
    if (response.statusCode == 201 || response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var overtime = data['overtime'];
      var overtimeStart = data['overtime_start'];
      var overtimeEnd = data['overtime_end'];
      var overtimeDuration = data['overtime_duration'];
      // var overtimeFee = data['overtime_fee'];
      // var overtimeMsg = data['overtime_msg'];
      // check if overtime is enabled
      if (overtime) {
        // check if the time is between the overtime start and end
        if (DateTime.now().isAfter(DateTime.parse(overtimeStart)) &&
            DateTime.now().isBefore(DateTime.parse(overtimeEnd))) {
          // check if the overtime duration is less than the overtime duration
          if (DateTime.now()
                  .difference(DateTime.parse(overtimeStart))
                  .inMinutes <
              int.parse(overtimeDuration)) {
            // show overtime dialog
            // showOvertimeDialog(
            //     context: context,
            //     overtimeFee: overtimeFee,
            //     overtimeMsg: overtimeMsg);
          }
        }
      }
    }
  } else {
    // show offline dialog
    showMessage(context: context, msg: "You are offline", type: "warning");
  }
}

// handle online and offline sessions
void handleNetworkSession(BuildContext context) {
  var checker = InternetConnectionChecker.createInstance();
  //
  checker.hasConnection.then((online) {
    context.read<OnlineCheckerController>().updateChecker(online);
  });
}
