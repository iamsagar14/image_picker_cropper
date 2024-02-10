// 📦 Package imports:
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerCropperManager {
  final ImagePicker _imagePicker = ImagePicker();
  final ImageCropper _imageCropper = ImageCropper();

  Future<List<XFile>> pickMultipleImages() async {
    try {
      return await _imagePicker.pickMultiImage();
    } catch (e) {
      rethrow;
    }
  }

  Future<XFile?> pickVideo({required ImageSource source}) async {
    try {
      return await _imagePicker.pickVideo(
        source: source,
        maxDuration: const Duration(seconds: 20),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<CroppedFile?> pickAndCropImage() async {
    try {
      final pickedImageX =
          await _imagePicker.pickImage(source: ImageSource.gallery);

      if (pickedImageX == null) {
        return null;
      }

      final pickedImage = File(pickedImageX.path);
      return cropImage(pickedFile: pickedImage);
    } catch (e) {
      rethrow;
    }
  }

  Future<CroppedFile?> cropImage({
    required File pickedFile,
    CropAspectRatio aspectRatio =
        const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
  }) async {
    try {
      return await _imageCropper.cropImage(
        sourcePath: pickedFile.path,
        maxWidth: 1080,
        maxHeight: 1080,
        aspectRatio: aspectRatio,
      );
    } catch (e) {
      rethrow;
    }
  }
}
