import '/exports/exports.dart';

class ImageUploadController extends Cubit<PlatformFile>{
  ImageUploadController() : super(picker);
 static PlatformFile  picker = PlatformFile.fromMap({});

  void uploadImage(PlatformFile image) {
   emit(image);
  }
}