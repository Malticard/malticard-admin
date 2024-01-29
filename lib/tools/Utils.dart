import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'dart:ui' as ui;
import 'package:uuid/uuid.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/rendering.dart';
import 'package:malticard/controllers/LoaderController.dart';
import 'package:malticard/controllers/SidebarController.dart';
import 'package:malticard/global/SessionManager.dart';
import 'package:malticard/screens/malticard/SchoolsView.dart';

import '../models/StudentModel.dart';
import '../models/Taps.dart';
import '/exports/exports.dart';

// login logic for the user
loginUser(BuildContext context, String email, String password) async {
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
        // Routes.popPage(context);
        if (value.statusCode == 200) {
          var data = jsonDecode(value.body);
          log("Login response ${data}");

          BlocProvider.of<MalticardController>(context, listen: false)
              .setMalticardData(data); //0754979966
          BlocProvider.of<TitleController>(context).setTitle("Dashboard");
          BlocProvider.of<SidebarController>(context).changeView(0);
          if (data['message'] == 'Password not found!!') {
            showMessage(
                context: context, msg: "Incorrect password", type: 'danger');
            Provider.of<LoaderController>(context, listen: false).hideLoader();
          } else {
            SessionManager().storeToken(data['data']["_token"]);
            Provider.of<LoaderController>(context, listen: false).hideLoader();
            Routes.namedRemovedUntilRoute(context, Routes.home);
            showMessage(
              context: context,
              msg: "Logged in successfully..",
              type: 'success',
            );
          }
        } else {
          Provider.of<LoaderController>(context, listen: false).hideLoader();
          var data = jsonDecode(value.body);

          showMessage(
              context: context,
              msg: "${value.statusCode} => ${data['message']}",
              type: 'danger');
        }
      },
    );
  } on ClientException catch (_) {
    // Routes.popPage(context);
    showMessage(context: context, msg: "${_.message}", type: 'danger');
  } on HandshakeException catch (_) {
    // Routes.popPage(context);
    showMessage(context: context, msg: "${_.message}", type: 'danger');
  } on FormatException catch (_) {
    // Routes.popPage(context);
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
void showContentDialog(
    String name, String title, BuildContext context, VoidCallback onPress) {
  showAdaptiveDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog.adaptive(
      title: Text(title),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          name,
          overflow: TextOverflow.visible,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
      actions: [
        TextButton(
          onPressed: onPress,
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
/// function to rename uplaoded file to a unique name
String renameFile(String fileName) {
  var uuid = Uuid();
  String fileExtension = fileName.split(".").last;
  return uuid.v4() + ".$fileExtension";
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
  return  imageURL;
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
    // barrierDismissible: false,
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      child: Card(
        color: Theme.of(context).canvasColor,
        child: SizedBox(
          width: Responsive.isDesktop(context)
              ? MediaQuery.of(context).size.width / 5
              : MediaQuery.of(context).size.width,
          height: Responsive.isDesktop(context)
              ? MediaQuery.of(context).size.width / 5
              : MediaQuery.of(context).size.width / 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Space(
                space: 0.02,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: SpinKitDualRing(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Theme.of(context).primaryColor),
              ),
              Space(
                space: 0.05,
              ),
              Text(
                "$msg..",
                textAlign: TextAlign.center,
                style: TextStyles(context)
                    .getRegularStyle()
                    .copyWith(fontSize: 17),
              ),
            ],
          ),
        ),
      ),
    ),
  );
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
if(data.isNotEmpty){
  data.forEach((element) {
    int month = element.createdAt.month;
    int count = element.count;
    monthCounts[month] = count; // Update the count for the specific month
  });
  // int totalTapsInYear = monthCounts.values.reduce((sum, count) => sum + count);
  // print("Total Taps in the Year: $totalTapsInYear");
  return data.first.count;
}
  
  return 0;
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
Future<SchoolModel> searchSchools(String schoolName,
    {int page = 1, int limit = 20}) async {
  var response = await Client().get(Uri.parse(
      AppUrls.searchSchool + "?query=$schoolName&page=$page&pageSize=$limit"));
  SchoolModel schoolModel = schoolModelFromJson(response.body);
  return schoolModel;
}

// function to search for guardians
Future<Guardians> searchGuardians(String schoolId, String guardianName,
    {int page = 1, int limit = 20}) async {
  var response = await Client().get(Uri.parse(AppUrls.searchGuardians +
      schoolId +
      "?query=$guardianName&page=$page&pageSize=$limit"));
  return guardiansFromJson(response.body);
}

// function to search for students
Future<List<StudentModel>> searchStudents(String schoolId, String studentName,
    {int page = 1, int limit = 20}) async {
  var response = await Client().get(Uri.parse(AppUrls.searchStudents +
      schoolId +
      "?query=$studentName&page=$page&pageSize=$limit"));
  return studentModelFromJson(response.body);
}

// function save QR code
Future<void> saveQRCode(
    BuildContext context, GlobalKey key, String name) async {
  RenderRepaintBoundary boundary =
      key.currentContext!.findRenderObject() as RenderRepaintBoundary;
  ui.Image image = await boundary.toImage(pixelRatio: 3.0);
  ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  Uint8List pngBytes = byteData!.buffer.asUint8List();
  final result = await FileSaver.instance.saveFile(
      name: name, bytes: pngBytes, ext: 'png', mimeType: MimeType.png);
  if (result.isNotEmpty) {
    showMessage(
        context: context,
        msg: "QR Code saved to gallery! ${result}",
        type: 'success');
  } else {
    showMessage(
        context: context,
        msg: "Failed to save QR Code: ${result}",
        type: 'success');
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
