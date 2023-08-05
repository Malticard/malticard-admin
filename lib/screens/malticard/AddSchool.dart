// ignore_for_file: invalid_return_type_for_catch_error

import 'dart:math';

import '/exports/exports.dart';

class AddSchoolView extends StatefulWidget {
  const AddSchoolView({super.key});

  @override
  State<AddSchoolView> createState() => _AddSchoolViewState();
}

class _AddSchoolViewState extends State<AddSchoolView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

// add school form
  static List<Map<String, dynamic>> _school = [
    {
      "title": "School name *",
      "hint": "e.g John",
      "password": false,
      'icon': Icons.school_rounded
    },
    {
      "title": "School email*",
      "hint": "e.g example@gmail.com",
      "password": false,
      'icon': Icons.email_outlined
    },
    {
      "title": "School Contact*",
      "hint": "e.g 07xxxx-xx",
      "password": false,
      'icon': Icons.phone_outlined
    },
    {
      "title": "School address *",
      "hint": "e.g about here",
      "password": false,
      'icon': Icons.info_outline_rounded
    },
    {'title': 'School Badge', 'profile': 5},
    {
      "title": "School Type *",
      "hint": "e.g single",
      "password": false,
      'icon': Icons.info_outline_rounded,
      "data":["Select school type","Single","Mixed"]
    },
    {
      "title": "School Nature *",
      "hint": "e.g nursery",
      "password": false,
      'icon': Icons.masks_outlined, 
      "data":["Select school nature","Kindergarten", "Kindergarten & Nursery", "Kindergarten, Nursery & Primary","Nursery & Primary", "Secondary"]
    },
  ];

  // school controllers
  final List<TextEditingController> _schoolControllers =
      List.generate(_school.length, (index) => TextEditingController());

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
Map<String,dynamic> schoolData = {};
  void saveSchoolDetail() {
    if (validateEmail(_schoolControllers[1].text, context) != false) {
     
      showProgress(context,msg:"Adding new school..");
      _handleSchoolRegistration().then((value) {
        Routes.popPage(context);
         Routes.popPage(context);
      }).whenComplete(() {
        // Routes.popPage(context);
        showMessage(
          context: context,
          type: 'success',
          msg: "Added new school successfully",
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // school error fields
    List<String> _schoolErrorFields =
        List.generate(_schoolControllers.length, (i) => '');

    Size size = MediaQuery.of(context).size;
    return BlocConsumer<ImageUploadController, Map<String,dynamic>>(
      listener: (context, state) {
        setState(() {
          schoolData  = state;
        });
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: Card(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Theme.of(context).canvasColor
                  : Colors.white,
              elevation: 0,
              margin: EdgeInsets.only(left: 20, right: 20),
              child: SizedBox(
                width: size.width / 3,
                height: size.width / 1.5,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      formGen(_school, _schoolControllers, _schoolErrorFields,
                          "School Details"),
                      CommonButton(
                        buttonText: "Submit school details",
                        onTap: () {
                          if (formKey.currentState!.validate() == true) {
                            if (_schoolControllers[0]
                                    .text
                                    .trim()
                                    .split(" ")
                                    .length <
                                2) {
                              showMessage(
                                  context: context,
                                  msg: 'Please provide both names',
                                  type: 'warning');
                            } else {
                              saveSchoolDetail();
                            }
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
          ),
        );
      },
    );
  }

  Future<StreamedResponse> _handleSchoolRegistration() async {
    String uri = _schoolControllers[4].text.trim();
    var request = MultipartRequest('POST', Uri.parse(AppUrls.addSchool));
    // ================================ school fields ====================
    request.fields['school_name'] = _schoolControllers[0].text.trim();
    request.fields['school_nature'] = _schoolControllers[6].text.trim();
    request.fields['school_address'] = _schoolControllers[3].text.trim();
    ;
    request.fields['school_contact'] = _schoolControllers[2].text.trim();
    request.fields['school_email'] = _schoolControllers[1].text.trim();
    request.fields['school_type'] = _schoolControllers[5].text.trim();
    // school badge upload
    if (kIsWeb) {
      request.files.add(MultipartFile(
          "image",
          schoolData['image'],
          schoolData['size'],
          filename: schoolData['name']));
    } else {
      request.files.add(MultipartFile(
          'image', File(uri).readAsBytes().asStream(), File(uri).lengthSync(),
          filename: uri.split("/").last));
    }

    // end of school badge upload
    request.fields['school_key[key]'] = "0";
    request.fields['username'] = "${_schoolControllers[0].text}_${Random.secure().nextInt(1000000)}";
    // end of school badge upload
    // ================================ school fields ====================
    var response = request.send();
    //
    return response;
  }
}
