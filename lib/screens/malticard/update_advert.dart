import '/models/advert_model.dart';
import '/tools/advert_service.dart';
import '/exports/exports.dart';

class UpdateAdvert extends StatefulWidget {
  final AdvertModel advertModel;
  const UpdateAdvert({super.key, required this.advertModel});

  @override
  State<UpdateAdvert> createState() => _UpdateAdvertState();
}

class _UpdateAdvertState extends State<UpdateAdvert> {
  List<TextEditingController> _advertControllers = [];
  @override
  void initState() {
    super.initState();
    // advert controllers
    _advertControllers = [
      TextEditingController(text: widget.advertModel.title),
      TextEditingController(text: widget.advertModel.targetUrl),
      TextEditingController(text: ""),
      TextEditingController(
        text: widget.advertModel.startDate.toString(),
      ),
      TextEditingController(
        text: widget.advertModel.endDate.toString(),
      ),
    ];
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
        currentProfile: widget.advertModel.imageUrl,
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
    showProgress(context, msg: "Updating school details");
    _handleAdvertUpdate().then((value) {
      Routes.popPage(context);
    }).whenComplete(() {
      Routes.popPage(context);
      showMessage(
        context: context,
        type: 'success',
        msg: "Updated ${widget.advertModel.title} successfully",
      );
    });
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
                    formGen(
                      _advert,
                      _advertControllers,
                      _schoolErrorFields,
                      "Advert Details",
                    ),
                    CommonButton(
                      buttonText: "Update Advert",
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

  Future<String> _handleAdvertUpdate() async {
    return AdvertService.updateAd(widget.advertModel.id, {
      'title': _advertControllers[0].text.trim(),
      'targetUrl': _advertControllers[1].text.trim(),
      'image': schoolData['image'],
      'name': schoolData['name'],
      'size': schoolData['size'],
      'type': schoolData['type'],
      'endDate': _advertControllers[2].text.trim(),
      'startDate': _advertControllers[3].text.trim()
    });
  }
}
