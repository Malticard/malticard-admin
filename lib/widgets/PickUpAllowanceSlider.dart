import '/exports/exports.dart';

class PickUpAllowanceSlider extends StatefulWidget {
  final void Function(dynamic)? onChange;
  double? currentValue;
  PickUpAllowanceSlider({super.key, this.onChange, this.currentValue = 0.0});

  @override
  State<PickUpAllowanceSlider> createState() => _PickUpAllowanceSliderState();
}

class _PickUpAllowanceSliderState extends State<PickUpAllowanceSlider> {
  // double _currentValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PickUpController, double>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Set Pick allowance time",
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
                          .read<PickUpController>()
                          .setPickUpAllowanceTime(v.toDouble());
                      // setState(() {
                      //   widget.currentValue = v.toDouble();
                      // });
                    }),
              ),
              const Space(space: 0.03),
              Text("${state.floor()} (mins)",
                  style: TextStyles(context)
                      .getBoldStyle()
                      .copyWith(fontSize: 19)),
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
