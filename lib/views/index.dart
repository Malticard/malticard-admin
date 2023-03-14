// ignore_for_file: invalid_return_type_for_catch_error

import 'dart:convert';

import '/exports/exports.dart';

class SuperAdminView extends StatefulWidget {
  const SuperAdminView({super.key});

  @override
  State<SuperAdminView> createState() => _SuperAdminViewState();
}

class _SuperAdminViewState extends State<SuperAdminView>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      value: 0,
      duration: Duration(milliseconds: 1200),
    );
    _controller!.forward();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  // addd admin form
  static List<Map<String, dynamic>> _form = [
    {
      "title": "Full Name *",
      "hint": "e.g John",
      "password": false,
      'icon': Icons.person_2_outlined
    },
    {
      "title": "Email*",
      "hint": "e.g example@gmail.com",
      "password": false,
      'icon': Icons.email_outlined
    },
    {
      "title": "Phone*",
      "hint": "e.g 07xxxx-xx",
      "password": false,
      'icon': Icons.phone_outlined
    },
    {
      "title": "Gender*",
      "hint": "Select gender",
      "data": [
        "Select gender",
        "Male",
        "Female",
      ]
    },
    {
      "title": "Assign Role*",
      "hint": "Select role",
      "data": [
        "Select a role",
        "Admin",
        "Teacher",
        "Finance",
      ]
    },
    {
      "title": "Password*",
      "hint": "e.g *********",
      "password": true,
      'icon': Icons.lock_outline,
      'enableSuffix': true,
      'suffix': Icons.visibility_off,
    },
  ];

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
    {'title': 'School Badge', 'profile': 5},
    {
      "title": "School about*",
      "hint": "e.g about here",
      "password": false,
      'icon': Icons.info_outline_rounded
    },
    {
      "title": "School motto*",
      "hint": "e.g motto here",
      "password": false,
      'icon': Icons.masks_outlined
    },
  ];

  final List<TextEditingController> _formControllers =
      List.generate(_form.length, (index) => TextEditingController());
  // school controllers
  final List<TextEditingController> _schoolControllers =
      List.generate(_school.length, (index) => TextEditingController());

  // overall form padding
  EdgeInsets padding =
      const EdgeInsets.only(left: 14, top: 5, right: 14, bottom: 5);
// form key
  final formKey = GlobalKey<FormState>();
  // error fields
  List<String> errorFields = List.generate(_form.length, (i) => '');
  // school error fields
  List<String> _schoolErrorFields = List.generate(_form.length, (i) => '');
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

  List<Widget> _forms() {
    return [
      formGen(_form, _formControllers, errorFields, "Admin Details"),
      formGen(_school, _schoolControllers, _schoolErrorFields, "School Details")
    ];
  }

  void saveSchoolDetail() {
    if (validateEmail(_formControllers[1].text, context) != false) {
      showProgress(context);
      _handleSchoolRegistration().then((value) {
        Routes.popPage(context);
        showSuccessDialog(_schoolControllers[0].text.trim(), context,
            onPressed: () => Routes.popPage(context));
      }).whenComplete(
        () => showMessage(
          context: context,
          type: 'success',
          msg: "Added new staff successfully",
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: BottomTopMoveAnimationView(
          animationController: _controller!,
          child: Form(
            key: formKey,
            child: Stack(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: size.width / 10,
                      right: size.width / 10,
                      top: size.width / 13,
                      bottom: size.height / 7),
                  child: Card(
                    elevation: 0,
                    color: Colors.white,
                    child: GridView.count(
                      crossAxisCount: Responsive.isMobile(context) ? 1 : 2,
                      children: _forms(),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: MediaQuery.of(context).size.height / 6.5,
                  child: CommonButton(
                    buttonText: "Submit school detils",
                    onTap: () {
                      if (formKey.currentState!.validate() == true) {
                        String uri = _schoolControllers[3].text.trim();
                        if (uri == '') {
                          showMessage(
                              context: context,
                              msg: 'Image upload required....!!',
                              type: 'danger');
                        } else if (_formControllers[0]
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
                    padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.21,
                        left: MediaQuery.of(context).size.width * 0.2),
                    height: 55,
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(
                      size.aspectRatio * -0.4, size.aspectRatio * 0.4),
                  child: CommonAppbarView(
                    fontWeight: FontWeight.w200,
                    titleTextSize: 30,
                    titleText: "Add new  School",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<StreamedResponse> _handleSchoolRegistration() async {
    String uri = _schoolControllers[3].text.trim();

    var request = MultipartRequest('POST', Uri.parse(AppUrls.addSchool));
    // ================================ school fields ====================
    /**
   *  school_name: req.body.school_name,
                    school_motto: req.body.school_motto,
                    school_badge: req.file.path,
                    school_address: req.body.school_address,
                    school_contact: req.body.school_contact,
                    school_email: req.body.school_email,
                    school_about: req.body.school_about,
                    school_key: req.body.school_key
   */
    request.fields['school_name'] = _schoolControllers[0].text.trim();
    request.fields['school_motto'] = _schoolControllers[5].text.trim();
    request.fields['school_address'] = "-";
    request.fields['school_contact'] = _schoolControllers[2].text.trim();
    request.fields['school_email'] = _schoolControllers[1].text.trim();
    request.fields['school_about'] = _schoolControllers[4].text.trim();
    // school badge upload
    request.files.add(
      MultipartFile(
          'school_badge',
          kIsWeb
              ? Stream.value(jsonDecode(uri))
              : File(uri).readAsBytes().asStream(),
          File(uri).lengthSync(),
          filename: uri.split("/").last),
    );
    // end of school badge upload
    request.fields['school_key[key]'] = "0";

    // ====================================================================

    // =============================== admin fields =======================

    request.fields['staff_fname'] =
        _formControllers[0].text.trim().split(" ")[0];
    request.fields['staff_lname'] =
        _formControllers[0].text.trim().split(" ")[1];
    //
    request.fields['staff_contact'] = _formControllers[2].text;
    request.fields['staff_email'] = _formControllers[1].text.trim();
    request.fields['staff_role'] =
        await assignRole(_formControllers[4].text.trim());
    request.fields['staff_gender'] = _formControllers[3].text.trim();

    request.fields['staff_password'] = _formControllers[5].text.trim();
    request.fields['staff_key[key]'] = "";
    // ===================================================================
    debugPrint("Ans => ${request.fields}");
    var response = request.send();
    //
    return response;
  }
}
/**
 * 


Bruno
Resize main navigation
BLACKPINK in your area, eh-oh
BLACKPINK in your area, eh-oh
컴백이 아냐, 떠난 적 없으니까
고개들이 돌아, 진정해, 목 꺾일라
분홍빛의 얼음 drip, drip, drip, freeze 'em on sight
Shut it down, what, what, what, what?
게임이 아냐, 진 적이 없으니까
짖어봐, 네 목에 목줄은 내 거니까
땅바닥에 닿은 pedal, we go two-zero-five
Shut it down, uh-uh-uh-uh
초록 비를 내려 머리 위로, don't trip, baby
겸손하게 그냥 앉아있어, just sit, baby
Praying for my downfall, many have tried, baby
Catch me when you hear my Lamborghini go vroom, vroom, vroom, vroom
When we pull up, you know it's a shut down
간판 내리고 문 잠가 shut down
Whip it, whip it, whip it, whip it, whip it, whip it, whip it, whip it
It's black and it's pink once the sun down
When we pull up, you know it's a shut down
간판 내리고 문 잠가 shut down
Whip it, whip it, whip it, whip it, whip it, whip it, whip it, whip it
Keep watchin' me shut it down
Nah, you don't wanna be on my bad side
That's right, I'm slidin' through
Bunch of wannabes that wanna be me
Me three if I was you
Been around the world, pearls on ya, girl
VVS's we invested, uh
Need a lesson, see the necklace, see these dresses
We don't buy it, we request it, uh
A rock star, a pop star, but rowdier
Say bye to the paparazzi
Get my good side, I'll smile for ya
Know it ain't fair to ya, it's scarin' ya like what now?
BLACKPINK in your area, the area been shut down
It's a shut down
네, 다음 답안지야, 똑바로 봐, don't sleep, baby
뒤집어봐, 이건 가격표야 ain't cheap, baby
Stay in your own lane 'cause I'm 'bout to swerve
Catch me when you hear my Lamborghini go vroom, vroom, vroom, vroom
When we pull up, you know it's a shut down
간판 내리고 문 잠가 shut down
Whip it, whip it, whip it, whip it, whip it, whip it, whip it, whip it
It's black and it's pink once the sun down
When we pull up, you know it's a shut down
간판 내리고 문 잠가 shut down
Whip it, whip it, whip it, whip it, whip it, whip it, whip it, whip it
Keep watchin' me shut it down
♪
Shut it down (eh-oh), BLACKPINK in your area
Shut it down (eh-oh), whoa, whoa, whoa, whoa
Shut it down (eh-oh), BLACKPINK in your area
Keep talkin', we shut you down
Lyrics provided by Musixmatch

Resize main navigation

 */
