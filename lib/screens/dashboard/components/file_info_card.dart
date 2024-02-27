// ignore_for_file: deprecated_member_use

import '/exports/exports.dart';

class FileInfoCard extends StatelessWidget {
  const FileInfoCard({
    Key? key,
    this.color,
    this.value,
    required this.icon,
    required this.label,
    required this.last_updated,
  }) : super(key: key);

  final Color? color;
  final int? value;
  final String icon;
  final String label;
  final String last_updated;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding / 2),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        border: Border.all(
          color: color!.withOpacity(0.15),
          width: 2,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "$label\n",
                    style: Theme.of(context).textTheme.bodyMedium!.apply(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                          fontWeightDelta: 1,
                          fontSizeFactor: 0.8,
                        ),
                  ),
                  TextSpan(
                    text: value?.toString(),
                    style: Theme.of(context).textTheme.bodyMedium!.apply(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                          fontWeightDelta: 6,
                          fontSizeFactor: 1.6,
                        ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(defaultPadding * 0.5),
            margin: EdgeInsets.all(18),
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: color!.withOpacity(0.1),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset(
              icon,
              color: color,
            ),
          ),
          // Icon(
          //   Icons.more_vert,
          //   color: Theme.of(context).backgroundColor,
          // )
        ],
      ),
    );
  }
}

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    Key? key,
    this.color = primaryColor,
    required this.percentage,
  }) : super(key: key);

  final Color? color;
  final int? percentage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 5,
          decoration: BoxDecoration(
            color: color!.withOpacity(0.1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth * (percentage! / 100),
            height: 5,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
