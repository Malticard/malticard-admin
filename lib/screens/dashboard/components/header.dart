import '/exports/exports.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: context.read<MainController>().controlMenu,
          ),
        if (!Responsive.isMobile(context))
          BlocBuilder<TitleController, String>(builder: (context, title) {
            return Text(
              title,
              style: TextStyles(context).getTitleStyle(),
            );
          }),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),

        CommonButton(
          width: 50,
          buttonTextWidget: Icon(
            Theme.of(context).brightness == Brightness.light
                ? Icons.dark_mode
                : Icons.light_mode,
            color: Colors.white70,
          ),
          onTap: () => context.read<ThemeController>().toggleDarkLightTheme(),
        ),
        const ProfileCard()
      ],
    );
  }
}

class ProfileCard extends StatefulWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: defaultPadding),
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding,
          vertical: defaultPadding / 2,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.white10),
        ),
        child: Row(
          children: [
            Image.asset(
              "assets/images/profile_pic.png",
              height: 38,
            ),
            if (!Responsive.isMobile(context))
              Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                child: Text(
                    "${context.read<SchoolController>().state['fname']} ${context.read<SchoolController>().state['lname']}"),
              ),
            PopupMenuButton(
              icon: const Icon(Icons.keyboard_arrow_down),
              itemBuilder: (BuildContext context) {
                return List.generate(
                  StaffPopUpOptions.options.length,
                  (index) => PopupMenuItem(
                      child: ListTile(
                    leading: Icon(StaffPopUpOptions.options[index].icon),
                    title: Text(StaffPopUpOptions.options[index].title!),
                    onTap: () {
                      StaffPopUpOptions.options[index].title == 'Logout'
                          ? Routes.logout(context)
                          : context
                              .read<WidgetController>()
                              .pushWidget(AdminProfile());
                      Navigator.pop(context);
                    },
                  )),
                );
              },
            ),
          ],
        ));
  }
}

class SearchField extends StatefulWidget {
  final ValueChanged<String?>? onChanged;
  const SearchField({
    Key? key,  this.onChanged,
  }) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged:widget.onChanged ,
      decoration: InputDecoration(
        hintText: "Search",
        fillColor: Theme.of(context).canvasColor,
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(defaultPadding * 0.75),
            margin: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg"),
          ),
        ),
      ),
    );
  }
}
