import '/exports/exports.dart';

class IntervalSlider extends StatefulWidget {
  final void Function(dynamic)? onChange;
  double? currentValue;
  IntervalSlider({super.key, this.onChange, this.currentValue = 0.0});

  @override
  State<IntervalSlider> createState() => _IntervalSliderState();
}

class _IntervalSliderState extends State<IntervalSlider> {
  double _currentValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<IntervalController, double>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Set interval in minutes",
                style: TextStyles(context).getRegularStyle(),
              ),
              const Space(space: 0.03),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 8.0, right: 26, left: 26),
                child: SfSlider(
                    min: 0.0,
                    max: 100.0,
                    value: state,
                    stepSize: 5,
                    // showTicks: true,
                    showLabels: true,
                    enableTooltip: true,
                    minorTicksPerInterval: 1,
                    onChanged: (v) {
                      context
                          .read<IntervalController>()
                          .computeInterval(v.toDouble());
                      // setState(() {
                      //   widget.currentValue = v.toDouble();
                      // });
                    }),
              ),
              const Space(space: 0.03),
              Text(
                "${state.floor()} (mins)",
                style: TextStyles(context).getTitleStyle(),
              ),
              const Space(space: 0.03),
              CommonButton(
                buttonText: "Done",
                onTap: () => Routes.popPage(context),
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 8.0, right: 36, left: 36),
              )
            ],
          );
        },
      ),
    );
  }
}
