import '/exports/exports.dart';

class ImageUploadController extends Cubit<Map<String,dynamic>>{
  ImageUploadController() : super(picker);
 static Map<String,dynamic>  picker = {};

  void uploadImage(Map<String,dynamic> image) {
   emit(image);
  }
}