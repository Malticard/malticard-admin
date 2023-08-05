import '/exports/exports.dart';
class CommonDelete extends StatefulWidget {
  final String title;
   final String url;
  const CommonDelete({Key? key, required this.title, required this.url}) : super(key: key);

  @override
  State<CommonDelete> createState() => _CommonDeleteState();
}
class _CommonDeleteState extends State<CommonDelete> {
  @override
  Widget build(BuildContext context) {
    return  Dialog(
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 4,
        height: MediaQuery.of(context).size.width / 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Space(space: 0.02),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                      "Are you sure you want to delete ${widget.title}",textAlign: TextAlign.center,),
                ),
              ),
              Space(space: 0.032),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Routes.popPage(context);
                          showProgress(context,msg: "Removing ${widget.title}..");
                          Client().delete(Uri.parse(widget.url)).then((value) {
                           Routes.popPage(context);
                            if(value.statusCode == 200 || value.statusCode == 201){
                              showMessage(context: context,type: 'success',msg: '${widget.title} removed successfully..');
                            } else{
                              showMessage(context: context,msg: 'Error ${value.reasonPhrase}',type: 'danger');
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
                      TextButton(onPressed: () => Routes.popPage(context), child: Text("No")),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
