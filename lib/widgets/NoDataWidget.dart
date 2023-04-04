import '/exports/exports.dart';

class NoDataWidget extends StatelessWidget {
  final String text;
  const NoDataWidget({super.key, this.text = "There's nothing here.."});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 6,
      height: MediaQuery.of(context).size.width / 7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(StaffIcons.empty),
          const Space(space: 0.06),
          Text(
            text,
            style: TextStyles(context)
                .getDescriptionStyle()
                .copyWith(fontSize: 20, fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
  }
}
