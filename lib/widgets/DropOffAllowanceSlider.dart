import '/exports/exports.dart';

class DropOffAllowanceSlider extends StatefulWidget {
  final void Function(dynamic)? onChange;
  final double? currentValue;
  const DropOffAllowanceSlider(
      {super.key, this.onChange, this.currentValue = 0.0});

  @override
  State<DropOffAllowanceSlider> createState() => _DropOffAllowanceSliderState();
}

class _DropOffAllowanceSliderState extends State<DropOffAllowanceSlider> {
  // double _currentValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DropOffController, double>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Set drop off allowance",
                style: TextStyles(context).getTitleStyle(),
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
                          .read<DropOffController>()
                          .setDropOffAllowanceTime(v.toDouble());
                      // setState(() {
                      //   widget.currentValue = v.toDouble();
                      // });
                    }),
              ),
              const Space(space: 0.03),
              Text(
                "${state.floor()} (mins)",
                style:
                    TextStyles(context).getBoldStyle().copyWith(fontSize: 24),
              ),
              const Space(space: 0.03),
              CommonButton(
                buttonText: "Done",
                onTap: () => Routes.popPage(context),
                height: 55,
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
