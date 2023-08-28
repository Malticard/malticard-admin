import '/exports/exports.dart';

class NoDataWidget extends StatelessWidget {
  final String text;
  const NoDataWidget({super.key, this.text = "There's nothing here.."});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Responsive.isMobile(context)
          ? MediaQuery.of(context).size.width / 2
          : MediaQuery.of(context).size.width / 6,
      height: MediaQuery.of(context).size.width / 7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(StaffIcons.empty),
          const Space(space: 0.06),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
          )
        ],
      ),
    );
  }
}
