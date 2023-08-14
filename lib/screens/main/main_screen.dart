import 'package:malticard/controllers/SidebarController.dart';

import '../../controllers/MenuAppController.dart';
import '/exports/exports.dart';
import 'components/side_menu.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    // app theme state
    context.read<ThemeController>().getTheme();
    // retrieve session state
    context.read<MalticardController>().getMalticardData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<MalticardController>().getMalticardData();
    BlocProvider.of<WidgetController>(context).showCurrentPage();
    BlocProvider.of<TitleController>(context).showTitle();

    return Scaffold(
      key: context.read<MenuAppController>().scaffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              const Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            const Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: DashboardScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
