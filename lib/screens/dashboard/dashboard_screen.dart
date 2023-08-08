import '/exports/exports.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.grey[200]
            : Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //======= header section ========
            if (Responsive.isDesktop(context))
              Padding(
                padding: EdgeInsets.only(
                  top: size.width * 0.011,
                  left: size.width * 0.031,
                  right: size.width * 0.031,
                ),
                child: const Header(),
              ),
            if (Responsive.isMobile(context)) const Header(),
            const SizedBox(height: defaultPadding),
            // ====== end of header section ======
        if(Responsive.isDesktop(context))
            Container(
              margin: EdgeInsets.only(
                  top: size.width * 0,
                    left: size.width * 0.031,
                  right: size.width * 0.031,),
              // ======= body section =======
              child: BlocBuilder<WidgetController, Widget>(
                  builder: (context, child) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width / 2,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: size.width * 0.02),
                    child: child,
                  ),
                );
              }),
              // ====== end of body section ======
            ),
         
          if (Responsive.isMobile(context))
            Container(
              height: size.height / 1.12,
              // padding: const EdgeInsets.all(defaultPadding / 2),
              // ======= body section =======
              child: BlocBuilder<WidgetController, Widget>(
                  builder: (context, child) {
                return child;
              }),
              // ====== end of body section ======
            ),
         
          ],
        ),
      ),
    );
  }
}
