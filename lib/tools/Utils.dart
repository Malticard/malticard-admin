import 'dart:convert';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:file_saver/file_saver.dart';
import 'package:flutter/rendering.dart';
import 'package:malticard/screens/malticard/SchoolsView.dart';

import '../models/StudentModel.dart';
import '../models/Taps.dart';
import '/exports/exports.dart';

// login logic for the user
loginUser(BuildContext context, String email, String password) async {
  showProgress(context, msg: "Login in progress");
  try {
    Client()
        .post(
      Uri.parse(AppUrls.login),
      headers: {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': '*/*'
      },
      body: json.encode(
        {
          "email": email,
          "password": password,
        },
      ),
    )
        .then(
      (value) {
        Routes.popPage(context);
        if (value.statusCode == 200) {
          var data = jsonDecode(value.body);
          debugPrint("Login response ${data}");
          BlocProvider.of<SchoolController>(context).setSchoolData(data);
          if (data['message'] == 'Password not found!!') {
            showMessage(context: context, msg: data['message'], type: 'danger');
          } else {
            Routes.namedRemovedUntilRoute(context, Routes.home);
            showMessage(
              context: context,
              msg: "Login successfully..",
              type: 'success',
            );
          }
        } else {
          var data = jsonDecode(value.body);

          showMessage(
              context: context,
              msg: "${value.statusCode} => ${data['message']}",
              type: 'danger');
        }
      },
    );
  } on ClientException catch (_) {
    Routes.popPage(context);
    showMessage(context: context, msg: "${_.message}", type: 'danger');
  } on HandshakeException catch (_) {
    Routes.popPage(context);
    showMessage(context: context, msg: "${_.message}", type: 'danger');
  } on FormatException catch (_) {
    Routes.popPage(context);
    showMessage(context: context, msg: "${_.message}", type: 'danger');
  }
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
Widget buildActionButtons(
    BuildContext context, VoidCallback edit, VoidCallback delete) {
return Row(
    children: [
      const SizedBox(
        width: 30,
      ),
      CommonButton(
        onTap: edit,
        width: 50, height: 50,
        // padding: const EdgeInsets.only(top: 15, bottom: 15),
        buttonTextWidget: const Icon(
          Icons.edit,
          color: Colors.white,
          size: 20,
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      CommonButton(
        width: 50,
        height: 50,
        onTap: delete,
        backgroundColor: Colors.red,
        buttonTextWidget:
            const Icon(Icons.delete_outline_rounded, color: Colors.white),
      ),
    ],
  );
}

Future<String?> fetchAndDisplayImage(String imageURL) async {
  // Uint8List? processedImageBytes;
  // final response =
  //     await Client().get(Uri.parse(AppUrls.liveImages + imageURL));
  // if (response.statusCode == 200) {
  //   final imageBytes = response.bodyBytes;
  //   final imageBase64 = base64Encode(imageBytes);
  //   // Display the image
  //   processedImageBytes = base64Decode(imageBase64);
  // }
  return AppUrls.liveImages + imageURL;
}

// malticard views
List<Map<String, dynamic>> malticardViews = [
  {
    "icon": "assets/icons/menu_dashbord.svg",
    "title": "Dashboard",
    "page": const Dashboard()
  },
  {
    "title": "Schools",
    "page": const SchoolsView(),
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
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      child: Card(
        child: SizedBox(
          width: MediaQuery.of(context).size.width /5,
          height: MediaQuery.of(context).size.width /5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Space(space: 0.02,),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: SpinKitDualRing(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Theme.of(context).primaryColor),
              ),
              Space(space: 0.05,),
              Text(
                "$msg..",
                textAlign: TextAlign.center,
                style: TextStyles(context).getRegularStyle().copyWith(fontSize: 17),
              ),
            ],
          ),
        ),
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

Future<SchoolModel> fetchSchools({int page = 1, int limit = 10}) async {
  var response = await Client()
      .get(Uri.parse(AppUrls.schools + "?page=$page&pageSize=$limit"));
  SchoolModel schoolModel = schoolModelFromJson(response.body);
  return schoolModel;
}

Future<List<StudentModel>> fetchGuardianStudents(String schoolId) async {
  var response =
      await Client().get(Uri.parse(AppUrls.guardianStudents + schoolId));
  return response.statusCode == 200 ? studentModelFromJson(response.body) : [];
}
// fetch all taps made
Future<int> fetchTaps() async {
   Response response = await Client().get(Uri.parse(AppUrls.getTaps));
    var data = tapsFromJson(response.body);
    Map<int, int> monthCounts = {}; // Map to store counts for each month

    // Initialize the monthCounts map with default values (0 counts) for all months
    for (int month = 1; month <= 12; month++) {
      monthCounts[month] = 0;
    }

    data.forEach((element) {
      int month = element.createdAt.month;
      int count = element.count;
      monthCounts[month] = count; // Update the count for the specific month
    });

    int totalTapsInYear = monthCounts.values.reduce((sum, count) => sum + count);
    // print("Total Taps in the Year: $totalTapsInYear");
    return totalTapsInYear;
}
// function handling scan intervals
Future<Guardians> fetchGuardians(String schoolId,
    {int page = 1, int limit = 10}) async {
  var response = await Client().get(Uri.parse(
      AppUrls.getGuardians + "/" + schoolId + "?page=$page&pageSize=$limit"));
  return guardiansFromJson(response.body);
}

DateTime time = DateTime.now();
String handSanIntervals() {
  return time.hour > 6 && time.hour < 12
      ? "DropOffs"
      : time.hour > 12 && time.hour < 18
          ? "PickUps"
          : "Nothing taking place currently";
}
// function to search for schools
Future<SchoolModel> searchSchools(String schoolName,{int page = 1,int limit = 20}) async {
  var response = await Client()
      .get(Uri.parse(AppUrls.searchSchool + "?query=$schoolName&page=$page&pageSize=$limit"));
  SchoolModel schoolModel = schoolModelFromJson(response.body);
  return schoolModel;
}
// function to search for guardians
Future<Guardians> searchGuardians(String schoolId, String guardianName,{int page = 1,int limit = 20}) async {
  var response = await Client().get(Uri.parse(
      AppUrls.searchGuardians +
          schoolId +
          "?query=$guardianName&page=$page&pageSize=$limit"));
  return guardiansFromJson(response.body);
}
// function to search for students
Future<List<StudentModel>> searchStudents(String schoolId, String studentName,{int page = 1,int limit = 20}) async {
  var response = await Client().get(Uri.parse(
      AppUrls.searchStudents + schoolId + "?query=$studentName&page=$page&pageSize=$limit"));
  return studentModelFromJson(response.body);
}
// function save QR code 
Future<void> saveQRCode(BuildContext context,GlobalKey key,String name) async {
    RenderRepaintBoundary boundary = key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();
    final result = await FileSaver.instance.saveFile(name:name, bytes: pngBytes, ext: 'png', mimeType: MimeType.apng);
    if (result.isNotEmpty) {
      showMessage(context: context, msg:"QR Code saved to gallery! ${result}",type: 'success');
    } else {
      showMessage(context: context, msg:"Failed to save QR Code: ${result}",type: 'success');
    }
  }
// fetch dashboard meta data
Future<List<Map<String, dynamic>>> fetchDashboardMetaData(
    BuildContext context) async {
  // get students tot
  var schools = await fetchSchools();
  var taps = await fetchTaps();
  List<Map<String, dynamic>> malticardData = [
    {
      "label": "SCHOOLS",
      "value": schools.totalDocuments,
      "icon": "assets/icons/005-overtime.svg",
      'color': Color.fromARGB(255, 50, 66, 95),
      "last_updated": "14:45"
    },
    {
      "label": "TAPS",
      "value": taps,
      "icon": "assets/icons/menu_task.svg",
      'color': Color.fromARGB(255, 11, 148, 61),
      "last_updated": "14:45"
    }
  ];
  return malticardData;
}

// handle online and offline sessions
void handleNetworkSession(BuildContext context) {
  var checker = InternetConnectionChecker.createInstance();
  //
  checker.hasConnection.then((online) {
    context.read<OnlineCheckerController>().updateChecker(online);
  });
}
