import 'dart:io';
import 'package:image/image.dart' as img;

class ImageCompressionUtil {
  // Method to compress an image
  static Future<File?> compressImage(File file) async {
    try {
      // Read the image file as bytes
      final imageBytes = await file.readAsBytes();
      
      // Decode the image
      final image = img.decodeImage(imageBytes);
      
      if (image == null) {
        print('Error decoding image.');
        return null;
      }

      // Resize the image (optional, depending on your requirements)
      final resizedImage = img.copyResize(image, width: 800); // Resize to width of 800 pixels

      // Encode the image to JPEG format with a quality of 80
      final compressedImageBytes = img.encodeJpg(resizedImage, quality: 80);
      
      // Create a new file to store the compressed data
      final compressedFilePath = '${file.path}_compressed.jpg'; // Save as .jpg
      final compressedFile = File(compressedFilePath);
      await compressedFile.writeAsBytes(compressedImageBytes);

      return compressedFile;
    } catch (e) {
      print('Error compressing image: $e');
    }
    return null;
  }
}
