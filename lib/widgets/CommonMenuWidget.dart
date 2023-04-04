import '/exports/exports.dart';

class CommonMenuWidget extends StatefulWidget {
  final Color? fieldColor;
  final String fieldText;
  final bool enableBorder;
  final String hint;
  final EdgeInsets padding;
  final ValueChanged onChange;
  const CommonMenuWidget(
      {Key? key,
      this.fieldColor,
      this.fieldText = "",
      this.enableBorder = false,
      required this.onChange,
      required this.hint,
      required this.padding})
      : super(key: key);

  @override
  State<CommonMenuWidget> createState() => _CommonMenuWidgetState();
}

class _CommonMenuWidgetState extends State<CommonMenuWidget> {
  List<dynamic> selectedList = [];
  var selected;
  @override
  Widget build(BuildContext context) {
    context.watch<MainController>().getAllStudents();
    return Padding(
      padding: widget.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.fieldText ?? "",
            style: TextStyles(context).getDescriptionStyle(),
          ),
          Card(
            elevation: 0,
            color: widget.fieldColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
              side: widget.enableBorder
                  ? BorderSide(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white12
                          : Colors.black12,
                    )
                  : BorderSide.none,
            ),
            shadowColor: Colors.black26.withOpacity(
              Theme.of(context).brightness == Brightness.dark ? 0.6 : 0.5,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
              ),
              child: SizedBox(
                child: CustomSearchableDropDown(
                  items: context.watch<MainController>().students,
                  label: widget.hint,
                  multiSelectTag: 'Names',
                  multiSelectValuesAsWidget: true,
                  multiSelect: true,
                  menuMode: true,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Icon(Icons.search),
                  ),
                  dropDownMenuItems:
                      context.watch<MainController>().students.map((item) {
                    return "${item.studentFname} ${item.studentLname}";
                  }).toList(),
                  onChanged: widget.onChange, //(value){
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.white54)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
