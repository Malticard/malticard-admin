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
          const SizedBox(height: defaultPadding),
          // ====== end of header section ======
          Expanded(
            child: Padding(
                padding: EdgeInsets.only(
                    top: size.width * 0.011,
                    left: size.width * 0.061,
                    right: size.width * 0.061),
                // ======= body section =======
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<WidgetController, Widget>(
                        builder: (context, child) {
                      return Expanded(
                        flex: 5,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 1.5,
                          height: MediaQuery.of(context).size.width / 2,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom:16.0),
                            child: SingleChildScrollView(child: child),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
                // ====== end of body section ======
              ),
            ),
        ],
      ),
    );
  }
}
