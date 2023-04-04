import '/exports/exports.dart';

class Data_Table extends StatefulWidget {
  final List<DataColumn>? columns;
  final List<DataRow>? rows;
  final Widget? header;
  final Widget? empty;
  final String? title;
  const Data_Table({
    Key? key,
    this.columns,
    this.header,
    this.title,
    this.empty,
    this.rows,
  }) : super(key: key);

  @override
  State<Data_Table> createState() => _Data_TableState();
}

class _Data_TableState extends State<Data_Table> {
  final RestorableInt _rowIndex = RestorableInt(0);
  final RestorableInt _rowsPerPage =
  RestorableInt(PaginatedDataTable.defaultRowsPerPage);
  final RestorableBool _sortAscending = RestorableBool(true);
  final RestorableIntN _sortColumnIndex = RestorableIntN(null);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.width / 2,
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color:Theme.of(context).brightness == Brightness.light? Colors.white
            :Theme.of
          (context)
          .canvasColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.header ??
              Text(
                widget.title ?? "",
                style: Theme.of(context).textTheme.subtitle1,
              ),
          Expanded(
            child: SizedBox(
              width: size.width,
              height: size.width / 4,
              child: DataTable2(
                columnSpacing: defaultPadding,
                dividerThickness:
                    1, // this one will be ignored if [border] is set above
                bottomMargin: 10,
                minWidth: 900,
                sortColumnIndex: 2,
                sortAscending: false,
                sortArrowIcon: Icons.keyboard_arrow_up, // custom arrow
                sortArrowAnimationDuration: const Duration(milliseconds: 500),
                columns: widget.columns ?? [],
                empty: widget.empty ??
                    Center(
                        child: Text("There nothing here"),),
                rows: widget.rows ?? [],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
