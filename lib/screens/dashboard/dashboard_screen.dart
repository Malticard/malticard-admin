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
    return Container(
      color: Theme.of(context).brightness == Brightness.light?Colors
          .grey[200]:Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //======= header section ========
          Padding(
            padding: EdgeInsets.only(
              top: size.width * 0.011,
              left: size.width * 0.031,
              right: size.width * 0.031,
            ),
            child: const Header(),
          ),
          const SizedBox(height: defaultPadding / 2),
          // ====== end of header section ======
          Container(
              margin: EdgeInsets.only(
                  top: size.width * 0,
                  left: size.width * 0.081,
                  right: size.width * 0.081),
              // ======= body section =======
              child: BlocBuilder<WidgetController, Widget>(
                      builder: (context, child) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width / 1.5,
                      height: MediaQuery.of(context).size.width / 2,
                      child: Padding(
                        padding:  EdgeInsets.only(bottom:size.width * 0.02),
                        child: child,
                      ),
                    );
                  }),
              // ====== end of body section ======
            ),
        ],
      ),
    );
  }
}
