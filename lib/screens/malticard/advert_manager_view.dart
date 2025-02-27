// import 'dart:developer';

import 'package:malticard/controllers/advert_provider.dart';
// import 'package:malticard/models/advert_model.dart';
import 'package:malticard/screens/malticard/add_advert.dart';
// import 'package:malticard/tools/advert_service.dart';

import '../../exports/exports.dart';
import 'helpers/DataSource.dart';

class AdvertManagerView extends StatefulWidget {
  const AdvertManagerView({super.key});

  @override
  State<AdvertManagerView> createState() => _AdvertManagerViewState();
}

class _AdvertManagerViewState extends State<AdvertManagerView> {
  // final _queryController = TextEditingController();
  final _paginatorController = PaginatorController();
  int _currentPage = 1;
  int _rowsPerpage = 20;
  @override
  void initState() {
    super.initState();

    // Fetch ads when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final adProvider = Provider.of<AdvertProvider>(context, listen: false);
      adProvider.fetchActiveAds(_currentPage, _rowsPerpage);

      // Refresh ads every 15 minutes
      adProvider.startPeriodicRefresh(
        const Duration(minutes: 15),
        _currentPage,
        _rowsPerpage,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdvertProvider>(builder: (context, advert, child) {
      if (mounted) {
        advert.fetchActiveAds(_currentPage, _rowsPerpage);
      }
      return CustomDataTable(
        columns: [
          // DataColumn(label: Text('#')),
          DataColumn(label: Text('Image')),
          DataColumn(label: Text('Title')),
          DataColumn(label: Text('TargetURl')),
          DataColumn(label: Text('Advert Status')),
          DataColumn(label: Text('Actions')),
        ],
        source: AdvertDataSource(
          paginatorController: _paginatorController,
          totalDocuments: advert.ads?.totalDocuments ?? 0,
          currentPage: _currentPage,
          data: advert.ads?.data ?? [],
        ),
        header: Row(
          children: [
            SizedBox(
              width: Responsive.isDesktop(context) ? 170 : 150,
              height: Responsive.isDesktop(context) ? 40 : 40,
              child: ElevatedButton.icon(
                icon: Icon(Icons.add),
                label: Text(
                  "Create Ad",
                  style: TextStyles(context).getRegularStyle(),
                ),
                onPressed: () {
                  showAdaptiveDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) {
                        return AddAdvert();
                      });
                },
              ),
            ),
          ],
        ),
        actions: [
          // SizedBox(
          //   width: MediaQuery.of(context).size.width / 4,
          //   height: 100,
          //   child: TextFormField(
          //       controller: _queryController,
          //       decoration: InputDecoration(
          //         labelText: "Search",
          //       )),
          // )
        ],
        topWidget: SizedBox(),
        rowsPerPage: _rowsPerpage,
        onRowsPerPageChange: (rows) {
          setState(() {
            _rowsPerpage = rows ?? 0;
          });
        },
        onPageChanged: (value) {
          setState(() {
            _currentPage = (value ~/ _rowsPerpage);
          });
        },
        paginatorController: _paginatorController,
        title: "Adverts",
        empty: advert.loading && advert.ads == null
            ? Loader(
                text: "Adverts...",
              )
            : NoDataWidget(
                text: "No adverts found",
              ),
      );
    });
  }
}
