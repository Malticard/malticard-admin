import 'dart:developer';

import '/controllers/SidebarController.dart';
import '/exports/exports.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  var store;
  @override
  void initState() {
    store = malticardViews;
    BlocProvider.of<SidebarController>(context).getCurrentView();
    super.initState();
  }

  int? selected;
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SidebarController>(context).getCurrentView();

    return Drawer(
      key: context.read<MainController>().scaffoldKey,
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Color.fromRGBO(6, 109, 161, 1.0)
          : Theme.of(context).canvasColor,
      child: Column(
        children: [
          DrawerHeader(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Space(space: 0.01),
                    Image.asset(
                      "assets/images/malticard.png",
                      height: 100,
                      width: 110,
                    ),
                    // Space(),
                    Text(
                      "Malticard Admin",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles(context)
                          .getBoldStyle()
                          .copyWith(color: Colors.white, fontSize: 18),
                    )
                  ],
                ),
              ),
            ),
          ),
          BlocBuilder<SidebarController, int>(
            builder: (context, state) {
              return Expanded(
                child: ListView(
                  children: List.generate(
                    store.length,
                    (index) => DrawerListTile(
                      selected: index == state,
                      title: store[index]['title'],
                      svgSrc: store[index]['icon'],
                      press: () {
                        BlocProvider.of<SidebarController>(context)
                            .changeView(index);
                        // update page title
                        context
                            .read<TitleController>()
                            .setTitle(store[index]['title']);
                        // update rendered page
                        context.read<WidgetController>().pushWidget(index);
                        if (Responsive.isMobile(context)) {
                          Routes.popPage(context);
                        }
                      },
                    ),
                  ),
                ),
              );
            },
          ),
          // DrawerListTile(
          //   title: "Transaction",
          //   svgSrc: "assets/icons/menu_tran.svg",
          //   press: () {},
          // ),
          // DrawerListTile(
          //   title: "Task",
          //   svgSrc: "assets/icons/menu_task.svg",
          //   press: () {},
          // ),
          // DrawerListTile(
          //   title: "Documents",
          //   svgSrc: "assets/icons/menu_doc.svg",
          //   press: () {},
          // ),
          // DrawerListTile(
          //   title: "Store",
          //   svgSrc: "assets/icons/menu_store.svg",
          //   press: () {},
          // ),
          // DrawerListTile(
          //   title: "Notification",
          //   svgSrc: "assets/icons/menu_notification.svg",
          //   press: () {},
          // ),
          // DrawerListTile(
          //   title: "Profile",
          //   svgSrc: "assets/icons/menu_profile.svg",
          //   press: () {},
          // ),
          // DrawerListTile(
          //   title: "Settings",
          //   svgSrc: "assets/icons/menu_setting.svg",
          //   press: () {},
          // ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  DrawerListTile({
    this.selected = false,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  });
  final bool selected;
  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: selected,
      iconColor: selected ? Colors.blue : Colors.white54,
      textColor: selected ? Colors.blue : Colors.white54,
      // tileColor: selected ?Colors.grey[200]: const Color.fromRGBO(6, 109, 161, 1.0),
      selectedTileColor: Theme.of(context).brightness == Brightness.light
          ? Color.fromARGB(71, 46, 47, 47)
          : Color.fromARGB(70, 166, 172, 172),
      onTap: press,
      // shape: RoundedRectangleBorder(
      //   side: selected ? BorderSide(color: Colors.white60) : BorderSide.none,
      // ),
      horizontalTitleGap: 0.6,
      leading: SvgPicture.asset(
        svgSrc,
        // ignore: deprecated_member_use
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white54
            : Colors.white,
        height: 18,
      ),
      title: Text(
        title,
        style: TextStyles(context).getRegularStyle().copyWith(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : Colors.white54),
      ),
    );
  }
}
