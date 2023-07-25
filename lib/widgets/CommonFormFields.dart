// ignore_for_file: unnecessary_null_comparison

import '../models/StudentModel.dart';
import '/exports/exports.dart';

// import 'dart:html';
class CommonFormFields extends StatefulWidget {
  final EdgeInsets padding;
  final List<Map<String, dynamic>> formFields;
  final List<String> errorMsgs;
  final List<TextEditingController> formControllers;
  final List<StudentModel>? students;
  final int? numberOfDropDowns;
  final String buttonText;
  final VoidCallback? onSubmit;
  final Widget? submit;
  final String? formTitle;
  final bool formEnabled;
  const CommonFormFields(
      {super.key,
      required this.padding,
      required this.errorMsgs,
      required this.formFields,
      required this.formControllers,
      this.onSubmit,
      this.formTitle,
      this.submit,
      this.formEnabled = true,
      required this.buttonText,
      this.students,
      this.numberOfDropDowns});

  @override
  State<CommonFormFields> createState() => _CommonFormFieldsState();
}

class _CommonFormFieldsState extends State<CommonFormFields>
    with SingleTickerProviderStateMixin {
  // Error messages

  List<String?>? dropMsg;

  @override
  void initState() {
    // Error messages
    // _errorMsg = List.generate(widget.formFields.length, (index -1) => '');
    dropMsg = List.generate(widget.formFields.length, (index) => null);

    super.initState();
    // _controller = AnimationController(vsync: this,);
  }

  // var _cropController = CropController();
  var _imageBytes;
  // PlatformFile ? _imageFile;

  //  _startFilePicker() async {
  //   FileUploadInputElement uploadInput = FileUploadInputElement();
  //   uploadInput.click();

  //   uploadInput.onChange.listen((e) {
  //     // read file content as dataURL
  //     final files = uploadInput.files;
  //     if (files!.length == 1) {
  //       final file = files[0];
  //       FileReader reader =  FileReader();

  //       reader.onLoadEnd.listen((e) {
  //                   setState(() {
  //                     uploadedImage = reader.result;
  //                   });
  //       });

  //       reader.onError.listen((fileEvent) {
  //         setState(() {
  //           // option1Text = "Some Error occured while reading the file";
  //         });
  //       });

  //       reader.readAsArrayBuffer(file);
  //     }
  //   });
  //   }
  Uint8List fileStreamToUint8List(Stream<List<int>> fileStream) {
    final bytes = <int>[];
    fileStream.forEach((data) {
      bytes.addAll(data);
    });
    return (Uint8List.fromList(bytes));
  }

  _handleImageUpload(int a) async {
    FilePicker.platform.pickFiles(
      dialogTitle: "${widget.formFields[a]['title']}",
      type: FileType.custom,
      withReadStream: true,
      allowedExtensions: ['jpg', 'png,', 'jpeg'],
    ).then((value) {
      if (kIsWeb) {
        setState(() {
          _imageBytes = fileStreamToUint8List(value!.files.first.readStream!);
        });
        context.read<ImageUploadController>().uploadImage({
          "image": value!.files.first.readStream,
          "byte":Uint8List.fromList(value.files.first.readStream!.toList() as List<int>),
          "name": value.files.first.name,
          "size": value.files.first.size
        });
        
      } else {
        setState(() {
          _imageBytes = File(value!.files.first.path!).readAsBytesSync();
          widget.formControllers[a].text = value.files.first.path!;
        });
      }
    });
    // widget.formControllers[a].text = = file!.files.first.pat
  }

  ImageProvider<Object>? drawImage(var url) {
    if (url == null) {
      return const AssetImage("assets/icons/001-profile.png");
    }
    return MemoryImage(url);
  }

  String drop = '';
  Widget buildProfile(int ind) {
    return Padding(
      padding: widget.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Text(widget.formFields[ind]['title'],
                style: TextStyles(context).getDescriptionStyle()),
          ),
          SizedBox(
            child: BlocConsumer<ImageUploadController , Map<String,dynamic>>(
              builder: (context,x) {
                return CircleAvatar(
                  radius: 35,
                  backgroundImage: drawImage(x['byte']),
                );
              }, listener: ( context,state) {  },
            ),
          ),
          // code for uploading profile picture  using file picker
          OutlinedButtonTheme(
            data: OutlinedButtonThemeData(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28)),
                fixedSize: Size(150, 50),
                foregroundColor: Colors.black45,
                // backgroundColor: Colors.blue,
              ),
            ),
            child: OutlinedButton(
              onPressed: () => _handleImageUpload(ind),
              child: Text(
                "Upload",
                style: TextStyles(context).getRegularStyle(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool showPassword = false;
  // global form key
  final formKey = GlobalKey<FormState>();
  List<Widget> buildForm() {
    return List.generate(
      widget.formFields.length + 2,
      (index) => index != (widget.formFields.length + 1)
          ? index == 0
              ? Padding(
                  padding: widget.padding,
                  child: Text(
                    widget.formTitle ?? "",
                    style: TextStyles(context).getBoldStyle().copyWith(
                          fontSize: 20,
                        ),
                  ),
                )
              :
              // form fields for drop downs (gender and relationship)
              (widget.formFields[index - 1]['profile'] != null)
                  ? buildProfile(index - 1)
                  : (widget.formFields[index - 1]['data'] != null)
                      ? DropDownWidget(
                          padding: widget.padding,
                          displayText: dropMsg![index - 1] ??
                              widget.formFields[index - 1]['data'][0],
                          titleText: widget.formFields[index - 1]['title'],
                          // controller: widget.formControllers[index -1],
                          elements: widget.formFields[index - 1]['data'],
                          selectedValue: (value) {
                            setState(() {
                              dropMsg![index - 1] = value;
                              widget.formControllers[index - 1].text = value!;
                            });
                          },
                        )
                      : (widget.formFields[index - 1]['date'] != null)
                          ?
                          // date of entry
                          CommonTextField(
                              icon: widget.formFields[index - 1]['icon'],
                              enableSuffix: widget.formFields[index - 1]
                                      ['enableSuffix'] ??
                                  showPassword,
                              enableBorder: true,
                              suffixIcon: widget.formFields[index - 1]
                                  ['suffix'],
                              fieldColor: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.white
                                  : Color.fromARGB(66, 75, 74, 74),
                              errorText: widget.errorMsgs[index - 1],
                              padding: widget.padding,
                              onChanged: (v) {
                                DateTime initialDate = DateTime.now();
                                DateTime firstDate = DateTime(1990);
                                DateTime lastDate = DateTime(2050);
                                showDatePicker(
                                        context: context,
                                        initialDate: initialDate,
                                        firstDate: firstDate,
                                        lastDate: lastDate)
                                    .then((value) {
                                  setState(() {
                                    widget.formControllers[index - 1].text =
                                        "${days[value!.weekday - 1]}, ${months[(value.month) - 1]} ${markDates(value.day)}";
                                    ;
                                  });
                                });
                              },
                              isObscureText: widget.formFields[index - 1]
                                  ['password'],
                              controller: widget.formControllers[index - 1],
                              hintText: widget.formFields[index - 1]['hint'],
                              titleText: widget.formFields[index - 1]['title'],
                            )
                          :
                          // dropdown menu
                          (widget.formFields[index - 1]['menu'] != null)
                              ? CommonMenuWidget(
                                  fieldColor: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.white
                                      : Color.fromARGB(66, 75, 74, 74),
                                  // controller: widget.formControllers[index - 1],
                                  fieldText: widget.formFields[index - 1]
                                      ['title'],
                                  hint: widget.formFields[index - 1]['hint'],
                                  padding: widget.padding,
                                  onChange: (v) {
                                    debugPrint("data => $v");
                                    if (v != null) {
                                      Provider.of<MainController>(context,
                                              listen: false)
                                          .newSelection(v);
                                    }
                                  },
                                )
                              :
                              // other fields
                              CommonTextField(
                                  icon: widget.formFields[index - 1]['icon'],
                                  enableSuffix: widget.formFields[index - 1]
                                          ['enableSuffix'] ??
                                      showPassword,
                                  enableBorder: true,
                                  suffixIcon: widget.formFields[index - 1]
                                      ['suffix'],
                                  fieldColor: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.white
                                      : Color.fromARGB(66, 75, 74, 74),
                                  errorText: widget.errorMsgs[index - 1],
                                  padding: widget.padding,
                                  isObscureText: widget.formFields[index - 1]
                                      ['password'],
                                  controller: widget.formControllers[index - 1],
                                  hintText: widget.formFields[index - 1]
                                      ['hint'],
                                  titleText: widget.formFields[index - 1]
                                      ['title'],
                                  onTapSuffix: () {
                                    setState(() {
                                      showPassword = !showPassword;
                                      widget.formFields[index - 1]['password'] =
                                          showPassword;
                                    });
                                  },
                                  validate: (v) {
                                    setState(() {
                                      widget.errorMsgs[index - 1] = v!.isEmpty
                                          ? "This field is required"
                                          : "";
                                    });

                                    return null;
                                  },
                                )
          : widget.submit ??
              CommonButton(
                buttonText: widget.buttonText,
                onTap: () {
                  if (formKey.currentState!.validate() == true) {
                    List<String> e = widget.errorMsgs
                        .where((element) => element.isEmpty)
                        .toList();
                    //  this checks if the provided fields are empty hence no errors raised for empty fields
                    // if (e.isEmpty) {
                    widget.onSubmit!();
                    // }
                  }
                },
                padding: widget.padding,
                height: 55,
              ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.formEnabled
        ? Form(
            key: formKey,
            child: Column(
              children: buildForm(),
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: buildForm(),
          );
  }
}
