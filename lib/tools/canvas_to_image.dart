import 'dart:html';
import 'dart:html' as html;

import 'package:qr_flutter/qr_flutter.dart';

class ImageExporterWeb {
  static void saveImage(String tex, info) {
    final qrCode = QrCode(4, QrErrorCorrectLevel.L);
    qrCode.addData(info);
    final qrImage = QrImage(qrCode);
    final link = html.AnchorElement();

    final canvas = html.CanvasElement(
      width: html.window.innerWidth,
      height: html.window.innerHeight,
    );
    final context = canvas.context2D;
    int w = canvas.width ?? 0;
    int h = canvas.height ?? 0;
    _drawWeb(qrImage, canvas);
    ImageData data = context.getImageData(0, 0, w, h);

    //store the current globalCompositeOperation
    String compositeOperation = context.globalCompositeOperation;

    //set to draw behind current content
    context.globalCompositeOperation = "destination-over";
    context.fillStyle = "white"; //set background color
    //draw background / rect on entire canvas
    context.fillRect(0, 0, w, h);

    //get the image data from the canvas
    var imageData = canvas.toDataUrl("image/png");

    //clear the canvas
    context.clearRect(0, 0, w, h);

    //restore it with original / cached ImageData
    context.putImageData(data, 0, 0);

    //reset the globalCompositeOperation to what it was
    context.globalCompositeOperation = compositeOperation;

    //return the Base64 encoded data url string
    link.download = "$tex-${DateTime.now().millisecondsSinceEpoch}.png";
    link.href = imageData;
    link.click();
  }

  static void _drawWeb(QrImage qrImage, CanvasElement canvas) {
    for (var x = 0; x < qrImage.moduleCount; x++) {
      for (var y = 0; y < qrImage.moduleCount; y++) {
        if (qrImage.isDark(y, x)) {
          canvas.context2D.fillRect(
              x * 10, y * 10, 10, 10); // render a dark square on the canvas
        }
      }
    }
  }
}
