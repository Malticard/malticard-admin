import '../../controllers/SidebarController.dart';
import '/exports/exports.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    BlocProvider.of<MalticardController>(context, listen: false)
        .getMalticardData();
    super.initState();
    BlocProvider.of<MalticardController>(context).getMalticardData();
    BlocProvider.of<WidgetController>(context).showCurrentPage();
    BlocProvider.of<SidebarController>(context).getCurrentView();
    BlocProvider.of<TitleController>(context).showTitle();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    BlocProvider.of<MalticardController>(context, listen: true)
        .getMalticardData();
    BlocProvider.of<WidgetController>(context).showCurrentPage();
    BlocProvider.of<SidebarController>(context).getCurrentView();
    BlocProvider.of<TitleController>(context).showTitle();

    return SafeArea(
      child: Container(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.grey[200]
            : Theme.of(context).scaffoldBackgroundColor,
        height: size.height,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //======= header section ========
              Responsive(
                mobile: Padding(
                  padding:
                      const EdgeInsets.only(right: 8.0, left: 8.0, top: 8.0),
                  child: const Header(),
                ),
                desktop: Padding(
                  padding: EdgeInsets.only(
                    top: size.width * 0.011,
                    left: size.width * 0.031,
                    right: size.width * 0.031,
                  ),
                  child: const Header(),
                ),
              ),
              const SizedBox(height: defaultPadding),
              // ====== end of header section ======
              // ======= body section =======
              Responsive(
                mobile: Container(
                  height: size.height / 1.12,
                  // ======= body section =======
                  child: BlocBuilder<WidgetController, Widget>(
                      builder: (context, child) {
                    return child;
                  }),
                ),
                // desktop view
                desktop: Container(
                  margin: EdgeInsets.only(
                    top: size.width * 0,
                    left: size.width * 0.031,
                    right: size.width * 0.031,
                  ),
                  child: BlocBuilder<WidgetController, Widget>(
                      builder: (context, child) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width / 2.16,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: size.width * 0.02),
                        child: child,
                      ),
                    );
                  }),
                ),
              ),
              // ====== end of body section ======
            ],
          ),
        ),
      ),
    );
  }
}
