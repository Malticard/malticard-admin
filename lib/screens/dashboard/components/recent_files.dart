import '../../../widgets/CustomPager.dart';
import '/exports/exports.dart';

class CustomDataTable extends StatefulWidget {
  final List<DataColumn>? columns;
  final DataTableSource source;
  final List<Widget> actions;
  final Widget topWidget;
  final PaginatorController? paginatorController;
  final Widget? header;
  final Widget? empty;
  final int rowsPerPage;
  final ValueChanged<int>? onPageChanged;
  final ValueChanged<int?>? onRowsPerPageChange;
  final String? title;
  const CustomDataTable({
    Key? key,
    this.columns,
    this.header,
    this.title,
    this.empty,
    required this.source,
    required this.actions,
    required this.topWidget,
    this.onPageChanged,
    this.paginatorController,
    this.rowsPerPage=20,
    this.onRowsPerPageChange,
  }) : super(key: key);

  @override
  State<CustomDataTable> createState() => _CustomDataTableState();
}

class _CustomDataTableState extends State<CustomDataTable> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // widget.topWidget,
        SizedBox(
          width: size.width,
          height: size.width / 2.2,
          child: PaginatedDataTable2(
            header: widget.header ?? Container(),
            columnSpacing: defaultPadding,
            showCheckboxColumn: false,
            dividerThickness: 1,
            minWidth: 900,
            sortColumnIndex: 1,
            sortArrowIcon: Icons.keyboard_arrow_up, // custom arrow
            sortArrowAnimationDuration: const Duration(milliseconds: 500),
            onRowsPerPageChanged: widget.onRowsPerPageChange,
            actions: [...widget.actions],
            rowsPerPage:
                widget.rowsPerPage, // Number of rows to display per page
            controller: widget.paginatorController,
            source: widget.source,
            columns: widget.columns ?? [],
            empty: widget.empty,
            onPageChanged: widget.onPageChanged,
          ),
        ),
        Positioned(
          bottom: 20,
          right: MediaQuery.of(context).size.width / 3,
          child: PageNumber(controller: widget.paginatorController!),
        )
      ],
    );
  }
}
