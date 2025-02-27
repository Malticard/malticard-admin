// ignore_for_file: invalid_return_type_for_catch_error

// import 'dart:math';

import 'dart:developer';

import 'package:malticard/models/advert_model.dart';
import 'package:malticard/tools/advert_service.dart';

import '/exports/exports.dart';

class AddAdvert extends StatefulWidget {
  const AddAdvert({super.key});

  @override
  State<AddAdvert> createState() => _AddAdvertState();
}

class _AddAdvertState extends State<AddAdvert> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

// add school form
  static List<Map<String, dynamic>> _advert = [
    {
      "title": "Advert Title*",
      "hint": "e.g title",
      "password": false,
      'icon': Icons.text_fields
    },
    {
      "title": "Adert Link*",
      "hint": "e.g https://www.google.com",
      "password": false,
      'icon': Icons.link
    },
    {'title': 'Advert Image', 'profile': 5},
    {
      "title": "Start Date*",
      "hint": "e.g 01-01-1998",
      "password": false,
      "date": 0,
      'icon': Icons.date_range
    },
    {
      "title": "End Date*",
      "hint": "e.g 10-10-1999",
      "password": false,
      "date": 0,
      'icon': Icons.date_range
    },
  ];

  // school controllers
  final List<TextEditingController> _advertControllers =
      List.generate(_advert.length, (index) => TextEditingController());

  // overall form padding
  EdgeInsets padding =
      const EdgeInsets.only(left: 14, top: 5, right: 14, bottom: 5);
// form key
  final formKey = GlobalKey<FormState>();
  // school error fields
  // cater for responsiveness
  Widget formGen(
      List<Map<String, dynamic>> forms,
      List<TextEditingController> controllers,
      List<String> errors,
      String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: CommonFormFields(
        padding: padding,
        formFields: forms,
        formEnabled: false,
        formTitle: title,
        numberOfDropDowns: 2,
        formControllers: controllers,
        buttonText: "",
        submit: Container(),
        errorMsgs: errors,
      ),
    );
  }

  Map<String, dynamic> schoolData = {};
  void saveAdvertDetail() {
    // if (validateEmail(_advertControllers[1].text, context) != false) {
    showProgress(context, msg: "Adding advert..");
    _handleAdvertRegistration().then((value) {
      Routes.popPage(context);
      Routes.popPage(context);
      // if (value.statusCode == 200 || value.statusCode == 201) {
      _advertControllers.forEach((element) {
        element.clear();
      });
      showMessage(
          context: context, msg: "Advert added successfully", type: "success");
      // } else {
      //
      // }
    });
    // .catchError((x) {
    //   Routes.popPage(context);
    //   print(x);
    //   showMessage(
    //       context: context, msg: "Failed to add an advert", type: "warning");
    // });
    // }
  }

  @override
  Widget build(BuildContext context) {
    // school error fields
    List<String> _schoolErrorFields =
        List.generate(_advertControllers.length, (i) => '');

    Size size = MediaQuery.of(context).size;
    return BlocConsumer<ImageUploadController, Map<String, dynamic>>(
      listener: (context, state) {
        setState(() {
          schoolData = state;
          log("Image ${state.toString()}");
        });
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Dialog(
            backgroundColor: Theme.of(context).canvasColor,
            child: SizedBox(
              width:
                  Responsive.isDesktop(context) ? size.width / 3 : size.width,
              height: Responsive.isMobile(context)
                  ? size.height * 1.25
                  : size.width / 2.1,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    formGen(_advert, _advertControllers, _schoolErrorFields,
                        "Advert Details"),
                    CommonButton(
                      buttonText: "Submit",
                      onTap: () {
                        if (formKey.currentState!.validate() == true) {
                          saveAdvertDetail();
                        }
                      },
                      padding: EdgeInsets.all(30),
                      height: 55,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<AdvertModel> _handleAdvertRegistration() async {
    return AdvertService.createAd(
      title: _advertControllers[0].text,
      description: "",
      imageStream: schoolData['image'],
      filename: schoolData['name'],
      size: schoolData['size'],
      type: schoolData['type'],
      targetUrl: _advertControllers[1].text,
      startDate: DateTime.parse(_advertControllers[3].text),
      endDate: DateTime.parse(_advertControllers[4].text),
    );
  }
}
