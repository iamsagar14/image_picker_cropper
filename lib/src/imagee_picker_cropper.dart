// // 📦 Package imports:
// import 'dart:io';

// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';

// class ImagePickerCropperManager {
//   final ImagePicker _imagePicker;
//   final ImageCropper _imageCropper;

//   ImagePickerCropperManager(
//       {required ImagePicker imagePicker, required ImageCropper imageCropper})
//       : _imagePicker = imagePicker,
//         _imageCropper = imageCropper;

//   Future<List<XFile>> pickMultipleImages() async {
//     try {
//       final pickedImages = await _imagePicker.pickMultiImage();
//       return pickedImages;
//     } catch (_) {
//       rethrow;
//     }
//   }

//   Future<XFile?> pickVideo() async {
//     try {
//       final pickedFile = await _imagePicker.pickVideo(
//           source: ImageSource.gallery,
//           maxDuration: const Duration(seconds: 20));
//       return pickedFile;
//     } catch (_) {
//       rethrow;
//     }
//   }

//   Future<CroppedFile?> pickAndCropImage({required ImageSource source}) async {
//     try {
//       final pickedImageX = await _imagePicker.pickImage(source: source);

//       if (pickedImageX == null) {
//         return null;
//       }

//       final pickedImage = File(pickedImageX.path);
//       final croppedImage = await cropImage(pickedFile: pickedImage);
//       if (croppedImage == null) {
//         return null;
//       }
//       return croppedImage;
//     } catch (_) {
//       rethrow;
//     }
//   }

//   Future<CroppedFile?> cropImage({
//     required File pickedFile,
//     CropAspectRatio aspectRatio = const CropAspectRatio(
//       ratioX: 1.0,
//       ratioY: 1.0,
//     ),
//   }) async {
//     CroppedFile? croppedFile = await _imageCropper.cropImage(
//       sourcePath: pickedFile.path,
//       maxWidth: 1080,
//       maxHeight: 1080,
//       aspectRatio: aspectRatio,
//     );
//     return croppedFile;
//   }
// }
