import 'dart:io';

import 'package:exif/exif.dart';

class FileValidator {
  static Future<int> getImageResolution(File file) async {
    try {
      List<int> bytes = await file.readAsBytes();

      // Get EXIF data
      Map<String, IfdTag> tags = await readExifFromBytes(bytes);

      // Print the details of all tags
      tags.forEach((tagName, tag) {
        print('$tagName: ${tag.printable}');
      });

      // Assuming that the tags for XResolution and YResolution are available
      IfdTag? xResolutionTag = tags['XResolution'];
      IfdTag? yResolutionTag = tags['YResolution'];

      if (xResolutionTag != null && yResolutionTag != null) {
        double xResolution = interpretResolutionTag(xResolutionTag);
        double yResolution = interpretResolutionTag(yResolutionTag);

        double dpi = xResolution / yResolution;

        // Check if DPI is greater than or equal to 150
        if (dpi >= 150) {
          return dpi.round(); // Return rounded DPI value
        } else {
          // Image resolution is below 150 DPI
          print('Image resolution is below 150 DPI');
          return -1;
        }
      } else {
        // XResolution or YResolution not found in EXIF data
        print('XResolution or YResolution not found in EXIF data');
        return -1;
      }
    } catch (e) {
      // Handle exceptions
      print('Error getting image resolution: $e');
      return -1;
    }
  }

  static double interpretResolutionTag(IfdTag tag) {
    // Use 'elementAt(0)' to get the first value of IfdValues
return tag.values.toList().first.toDouble();
  }

   static bool isFileExtensionValid(File file, List<String> allowedExtensions) {
    String fileExtension = getFileExtension(file);
    return allowedExtensions.contains(fileExtension);
  }

  static String getFileExtension(File file) {
    return file.path.split('.').last.toLowerCase();
  }

  
}
