import '../exports/exports.dart';

class FutureImage extends StatelessWidget {
  final Future<String?>? future;
  const FutureImage({super.key, this.future});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ClipRRect(
                  child: Image.network(snapshot.data!, width: 50, height: 50),
                  borderRadius: BorderRadius.circular(50),
                )
              : CircularProgressIndicator.adaptive();
        });
  }
}
