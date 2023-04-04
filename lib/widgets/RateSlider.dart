import '/exports/exports.dart';

class RateSlider extends StatefulWidget {
  final void Function(dynamic)? onChange;
  double? currentValue;
  RateSlider({super.key, this.onChange, this.currentValue = 0.0});

  @override
  State<RateSlider> createState() => _RateSliderState();
}

class _RateSliderState extends State<RateSlider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OvertimeRateController, double>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Set Overtime rate",
                style: TextStyles(context).getTitleStyle(),
              ),
              const Space(space: 0.03),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 8.0, right: 26, left: 26),
                child: SfSlider(
                    min: 0,
                    max: 100000,
                    value: state,
                    stepSize: 100,
                    showTicks: true,
                    showLabels: true,
                    enableTooltip: true,
                    minorTicksPerInterval: 1,
                    onChanged: (v) {
                      context
                          .read<OvertimeRateController>()
                          .setOvertimeRate(v.toDouble());
                      // setState(() {
                      //   widget.currentValue = v.toDouble();
                      // });
                    }),
              ),
              const Space(space: 0.03),
              Text(
                "Rate ${state.floor()}",
                style: TextStyles(context).getBoldStyle().copyWith(fontSize:
                20),
              ),
              const Space(space: 0.03),
              CommonButton(
                buttonText: "Done",
                onTap: () => Routes.popPage(context),
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 8.0, right: 26, left: 26),
              )
            ],
          );
        },
      ),
    );
  }
}
