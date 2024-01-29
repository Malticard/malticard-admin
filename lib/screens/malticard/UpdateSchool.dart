import 'dart:math';

import '../../exports/exports.dart';

class UpdateSchool extends StatefulWidget {
  final Result schoolModel;
  const UpdateSchool({super.key, required this.schoolModel});

  @override
  State<UpdateSchool> createState() => _UpdateSchoolState();
}

class _UpdateSchoolState extends State<UpdateSchool> {
  List<TextEditingController> _schoolControllers = [];
  @override
  void initState() {
    super.initState();
    // school controllers
    _schoolControllers = [
      TextEditingController(text: widget.schoolModel.schoolName),
      TextEditingController(text: widget.schoolModel.schoolEmail),
      TextEditingController(text: widget.schoolModel.schoolContact),
      TextEditingController(text: widget.schoolModel.schoolAddress),
      TextEditingController(text: ""),
      TextEditingController(text: widget.schoolModel.schoolType),
      TextEditingController(text: widget.schoolModel.schoolNature),
    ];
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
      "data": ["Select school type", "Single", "Mixed"]
    },
    {
      "title": "School Nature *",
      "hint": "e.g nursery",
      "password": false,
      'icon': Icons.masks_outlined,
      "data": [
        "Select school nature",
        "Kindergarten",
        "Kindergarten & Nursery",
        "Kindergarten, Nursery & Primary",
        "Nursery & Primary",
        "Secondary"
      ]
    },
  ];

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
        currentProfile: widget.schoolModel.schoolBadge,
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
  void saveSchoolDetail() {
    if (validateEmail(_schoolControllers[1].text, context) != false) {
      showProgress(context, msg: "Updating school details");
      _handleSchoolRegistration().then((value) {
        Routes.popPage(context);
        // showSuccessDialog(_schoolControllers[0].text.trim(), context,
        //     onPressed: () {
        //   Routes.popPage(context);
        //   context.read<WidgetController>().pushWidget(const Dashboard());
        //   context.read<TitleController>().setTitle("Dashboard");
        // });
        Routes.popPage(context);
      }).whenComplete(() {
        // Routes.popPage(context);
        showMessage(
          context: context,
          type: 'success',
          msg: "Updated ${widget.schoolModel.schoolName} successfully",
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
    return BlocConsumer<ImageUploadController, Map<String, dynamic>>(
      listener: (context, state) {
        setState(() {
          schoolData = state;
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
                  : size.width / 1.5,
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
        );
      },
    );
  }

  Future<StreamedResponse> _handleSchoolRegistration() async {
    String uri = _schoolControllers[4].text.trim();
    var request = MultipartRequest(
        'POST', Uri.parse(AppUrls.updateSchool + widget.schoolModel.id));
    // ================================ school fields ====================
    request.fields['name'] =
        _schoolControllers[0].text.trim().toLowerCase().replaceFirst(" ", "-");
    request.fields['school_name'] = _schoolControllers[0].text.trim();
    request.fields['school_nature'] = _schoolControllers[6].text.trim();
    request.fields['school_address'] = _schoolControllers[3].text.trim();
    ;
    request.fields['school_contact'] = _schoolControllers[2].text.trim();
    request.fields['school_email'] = _schoolControllers[1].text.trim();
    request.fields['school_type'] = _schoolControllers[5].text.trim();
    // school badge upload
    if (kIsWeb) {
      if (schoolData.isNotEmpty) {
        request.files.add(MultipartFile(
            "image", schoolData['image'], schoolData['size'],
            filename: schoolData['name']));
      }
    } else {
      if (uri.isNotEmpty) {
        request.files.add(MultipartFile(
            'image', File(uri).readAsBytes().asStream(), File(uri).lengthSync(),
            filename: uri.split("/").last));
      }
    }
    // if (kIsWeb) {
    //   request.files.add(MultipartFile(
    //       "image", schoolData['image'], schoolData['size'],
    //       filename: schoolData['name']));
    // } else {
    //   request.files.add(MultipartFile(
    //       'image', File(uri).readAsBytes().asStream(), File(uri).lengthSync(),
    //       filename: uri.split("/").last));
    // }

    // end of school badge upload
    request.fields['school_key[key]'] = "0";
    request.fields['username'] =
        "${_schoolControllers[0].text}_${Random.secure().nextInt(1000000)}";
    // end of school badge upload
    // ================================ school fields ====================
    var response = request.send();
    //
    return response;
  }
}
