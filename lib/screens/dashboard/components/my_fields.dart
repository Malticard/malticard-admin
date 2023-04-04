import '/exports/exports.dart';

class MyFiles extends StatefulWidget {
  const MyFiles({
    Key? key,
  }) : super(key: key);

  @override
  State<MyFiles> createState() => _MyFilesState();
}

class _MyFilesState extends State<MyFiles> {
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
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
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
  @override
  void initState() {
    Provider.of<MainController>(context, listen: false).fetchUpdates(context);
    super.initState();
  }

  @override
  void didUpdateWidget(oldWidget) {
    context.watch<MainController>().fetchUpdates(context);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    var dash = context.watch<MainController>().dashboardData;
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: dash.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: widget.childAspectRatio,
      ),
      itemBuilder: (context, index) => DashboardCard(
        label: dash[index]['label'],
        value: dash[index]['value'],
        icon: dash[index]['icon'],
        color: dash[index]['color'],
        last_updated: dash[index]['last_updated'],
      ), //FileInfoCard(info: dash[index]),
    );
  }
}
