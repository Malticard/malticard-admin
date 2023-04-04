import '/exports/exports.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _errorEmail = '';
  final _emailController = TextEditingController();
  //
  // final _roleController = TextEditingController();
  String _errorPassword = '';
  //
  final _passwordController = TextEditingController();
  //
  EdgeInsets padding = const EdgeInsets.only(left: 24, right: 24, bottom: 5);
  bool showPassword = false;
  // login logic
  Client c = Client();
  @override
  void initState() {
    context.read<ThemeController>().getTheme();
    // context.watch<OnlineCheckerController>().checkOnline();
    super.initState();
    // // get saved appTheme
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Theme.of(context).scaffoldBackgroundColor
          : const Color.fromARGB(204, 9, 87, 139),
      body: RemoveFocuse(
        onClick: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 45.0, left: 50),
              child: Text(
                "Login",
                style: TextStyles(context).getTitleStyle().copyWith(
                      color: Colors.white,
                      fontSize: Responsive.isMobile(context) ? 30 : 40,
                    ),
              ),
            ),
            Expanded(
              child: Responsive(
                mobile: Padding(
                  padding: EdgeInsets.only(top: size.width * 0.180),
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.23),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50),
                              ),
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.black26
                                  : Colors.white),
                          child: _buildForm(),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.021,
                        left: MediaQuery.of(context).size.height * 0.031,
                        right: MediaQuery.of(context).size.height * 0.031,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 1.3,
                          height: MediaQuery.of(context).size.width * 0.5,
                          child: SvgPicture.asset(
                            "assets/images/back2Skool.svg",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                desktop: Padding(
                  padding: EdgeInsets.only(
                      top: size.width * 0.030, bottom: size.width * 0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Column(
                          children: [
                            if (context
                                    .read<SchoolController>()
                                    .state['fname'] !=
                                null)
                              Padding(
                                padding: EdgeInsets.only(
                                  top: size.width * 0.015,
                                ),
                                child: Text(
                                  "Welcome back ${context.read<SchoolController>().state['fname']}",
                                  style: TextStyles(context)
                                      .getTitleStyle()
                                      .copyWith(
                                        color: Colors.white,
                                        fontSize: Responsive.isMobile(context)
                                            ? 30
                                            : 40,
                                      ),
                                ),
                              ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: size.width * 0.0150,
                                left: 60,
                                right: 60,
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.43,
                                child: SvgPicture.asset(
                                  "assets/images/back2Skool.svg",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: size.width / 16,
                              left: size.width / 16,
                              bottom: size.width / 16,
                              top: size.width / 16),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50),
                                  bottomLeft: Radius.circular(50),
                                  bottomRight: Radius.circular(50),
                                ),
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.black26
                                    : Colors.white.withOpacity(1)),
                            child: _buildForm(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                tablet: Padding(
                  padding: EdgeInsets.only(top: size.width * 0.170),
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.13,
                          bottom: size.height * 0.13,
                          right: size.width / 17,
                          left: size.width / 17,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50),
                                bottomLeft: Radius.circular(50),
                                bottomRight: Radius.circular(50),
                              ),
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.black26
                                  : Colors.white.withOpacity(0.5)),
                          child: _buildForm(),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: SvgPicture.asset(
                          "assets/images/back2Skool.svg",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (!Responsive.isMobile(context))
              Padding(
                padding: EdgeInsets.only(
                  left: size.width * 0.030,
                  right: size.width * 0.030,
                ),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/malticard.png",
                      width: 80,
                      height: 80,
                    ),
                    Text(
                      "Powered by Malticard",
                      style: TextStyles(context).getBoldStyle().copyWith(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  // String currentValue = "Admin";
  final formKey = GlobalKey<FormState>();
  Widget _buildForm() {
    return Form(
      key: formKey,
      child: ListView(
        children: <Widget>[
          Space(
            space: Responsive.isDesktop(context) ? 0.085 : 0.07,
          ),
          CommonTextField(
            fieldColor: Theme.of(context).cardColor,
            icon: Icons.email_outlined,
            controller: _emailController,
            errorText: _errorEmail,
            titleText: "Email",
            padding: padding,
            enableSuffix: true,
            hintText: "example@gmail.com",
            keyboardType: TextInputType.emailAddress,
          ),
          const Space(space: 0.01),
          CommonTextField(
            fieldColor: Theme.of(context).cardColor,
            icon: Icons.lock_outline,
            enableSuffix: true,
            suffixIcon: showPassword
                ? Icons.remove_red_eye_rounded
                : Icons.visibility_off,
            titleText: "Password", //AppLocalizations(context).of("password"),
            padding: padding,
            hintText: "************",
            isObscureText: !showPassword,
            errorText: _errorPassword,
            onTapSuffix: () {
              setState(() {
                showPassword = !showPassword;
              });
            },
            controller: _passwordController,
          ),
          _forgotYourPasswordUI(),
          CommonButton(
            height: 55,
            padding: padding.copyWith(left: 30, right: 30),
            buttonText: "Sign in", //AppLocalizations(context).of("login"),
            onTap: () {
              // if (context.watch<OnlineCheckerController>().state == true) {
              if (_allValidation() && formKey.currentState!.validate()) {
                loginUser(
                    context, _emailController.text, _passwordController.text);
              }
              // } else {
              //   showMessage(
              //       context: context, msg: "Your offline..", type: 'warning');
              // }
            },
          ),
          Space(
            space: Responsive.isDesktop(context) ? 0.045 : 0.03,
          ),
        ],
      ),
    );
  }

  Widget _forgotYourPasswordUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, right: 16, bottom: 8, left: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            onTap: () => Routes.namedRoute(context, Routes.forgotPassword),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _allValidation() {
    bool isValid = true;
    if (_emailController.text.trim().isEmpty) {
      _errorEmail =
          "Email can't be empty"; //AppLocalizations(context).of('email_cannot_empty');
      isValid = false;
    } else if (!Validator_.validateEmail(_emailController.text.trim())) {
      _errorEmail =
          "Provide a valid email"; //AppLocalizations(context).of('enter_valid_email');
      isValid = false;
    }

    if (_passwordController.text.trim().isEmpty) {
      _errorPassword =
          "Password field can't be empty"; //AppLocalizations(context).of('password_cannot_empty');
      isValid = false;
    } else if (_passwordController.text.trim().length < 6) {
      _errorPassword =
          "A password must be of more than 6 characters"; //AppLocalizations(context).of('valid_password');
      isValid = false;
    } else {
      _errorPassword = '';
    }
    setState(() {});
    return isValid;
  }
}
