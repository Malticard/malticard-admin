// import '/controllers/SidebarController.dart';
import '/exports/exports.dart';

class DashboardTiles extends StatefulWidget {
  const DashboardTiles({
    Key? key,
  }) : super(key: key);

  @override
  State<DashboardTiles> createState() => _DashboardTilesState();
}

class _DashboardTilesState extends State<DashboardTiles> {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: defaultPadding),
        Responsive(
          mobile: FileInfoCardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
          ),
          tablet: const FileInfoCardGridView(),
          desktop: FileInfoCardGridView(
            childAspectRatio: _size.width < 1400 ? 1.5 : 2.1,
          ),
        ),
      ],
    );
  }
}

class FileInfoCardGridView extends StatefulWidget {
  const FileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  State<FileInfoCardGridView> createState() => _FileInfoCardGridViewState();
}

class _FileInfoCardGridViewState extends State<FileInfoCardGridView> {
  StreamController<List<Map<String, dynamic>>> _dashboardController =
      StreamController<List<Map<String, dynamic>>>();
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    liveDashboardUpdates();
  }

  void liveDashboardUpdates() async {
    // initial data loaded
    var _dashData = await fetchDashboardMetaData(context);
    _dashboardController.add(_dashData);

    // check new events for every 4 seconds
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      this._timer = timer;
      if (mounted) {
        var _dashData = await fetchDashboardMetaData(context);
        _dashboardController.add(_dashData);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    if (_dashboardController.hasListener) {
      _dashboardController.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _dashboardController.stream,
      builder: (context, snapshot) {
        var dash = snapshot.data;
        return snapshot.hasData
            ? GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: dash?.length ?? 0,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: widget.crossAxisCount,
                  crossAxisSpacing: defaultPadding,
                  mainAxisSpacing: defaultPadding,
                  childAspectRatio: widget.childAspectRatio,
                ),
                itemBuilder: (context, index) => TapEffect(
                  onClick: () {
                    if (index == 0) {
                      // update page title
                      context
                          .read<TitleController>()
                          .setTitle(malticardViews[1]['title']);
                      // update rendered page
                      context.read<WidgetController>().pushWidget(1);
                      context.read<SidebarController>().changeView(1);
                    }
                  },
                  child: FileInfoCard(
                    label: dash![index]['label'],
                    value: dash[index]['value'],
                    icon: dash[index]['icon'],
                    color: dash[index]['color'],
                    last_updated: dash[index]['last_updated'],
                  ),
                ),
              )
            : Loader(
                text: "Updates..",
              );
      },
    );
  }
}
