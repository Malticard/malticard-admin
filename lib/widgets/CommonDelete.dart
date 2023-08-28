import '/exports/exports.dart';

class CommonDelete extends StatefulWidget {
  final String title;
  final String url;
  const CommonDelete({Key? key, required this.title, required this.url})
      : super(key: key);

  @override
  State<CommonDelete> createState() => _CommonDeleteState();
}

class _CommonDeleteState extends State<CommonDelete> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Text(
        "Are you sure you want to delete ${widget.title}",
        textAlign: TextAlign.center,
      ),
      titleTextStyle: Theme.of(context).textTheme.bodySmall,
      contentTextStyle: Theme.of(context).textTheme.bodyMedium,
      actions: [
        TextButton(
          onPressed: () {
            showProgress(context, msg: "Removing ${widget.title}..");
            Client().delete(Uri.parse(widget.url)).then((value) {
              if (value.statusCode == 200 || value.statusCode == 201) {
                showMessage(
                    context: context,
                    type: 'success',
                    msg: '${widget.title} removed successfully..');
                Routes.popPage(context);
                Routes.popPage(context);
              } else {
                // Routes.popPage(context);
                showMessage(
                    context: context,
                    msg: 'Error ${value.reasonPhrase}',
                    type: 'danger');
              }
            });
          },
          child: Text(
            "Yes",
            style: TextStyles(context)
                .getRegularStyle()
                .copyWith(color: Colors.red),
          ),
        ),
        TextButton(
          onPressed: () => Routes.popPage(context),
          child: Text("No"),
        ),
      ],
    );
  }
}
