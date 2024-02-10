# image_picker_cropper

[![pub package](https://img.shields.io/pub/v/image_cropper.svg)](https://pub.dartlang.org/packages/image_cropper)
This Flutter plugin, compatible with Android, iOS, and Web, facilitates image selection from the library and capturing new photos via the camera. Additionally, it provides image cropping functionality, leveraging distinct native libraries, thereby offering varied user interfaces across these platforms..
## Introduction

This Flutter plugin,image_picker_cropper, compatible with Android, iOS, and Web, facilitates image selection from the library and capturing new photos via the camera. Additionally, it provides image cropping functionality, leveraging distinct native libraries, thereby offering varied user interfaces across these platforms.

## How to install

### Android

Starting with version 0.8.1 the Android implementation support to pick (multiple) images on Android 4.3 or higher.

No configuration required - the plugin should work out of the box. It is however highly recommended to prepare for Android killing the application when low on memory. How to prepare for this is discussed in the Handling MainActivity destruction on Android section.

It is no longer required to add android:requestLegacyExternalStorage="true" as an attribute to the <application> tag in AndroidManifest.xml, as image_picker has been updated to make use of scoped storage.

- Add UCropActivity into your AndroidManifest.xml

````xml
<activity
    android:name="com.yalantis.ucrop.UCropActivity"
    android:screenOrientation="portrait"
    android:theme="@style/Theme.AppCompat.Light.NoActionBar"/>
````

#### Note:
From v1.2.0, you need to migrate your android project to v2 embedding ([detail](https://github.com/flutter/flutter/wiki/Upgrading-pre-1.12-Android-projects))

### iOS
Starting with version 0.8.1 the iOS implementation uses PHPicker to pick (multiple) images on iOS 14 or higher. As a result of implementing PHPicker it becomes impossible to pick HEIC images on the iOS simulator in iOS 14+. This is a known issue. Please test this on a real device, or test with non-HEIC images until Apple solves this issue. 63426347 - Apple known issue

Add the following keys to your Info.plist file, located in <project root>/ios/Runner/Info.plist:

NSPhotoLibraryUsageDescription - describe why your app needs permission for the photo library. This is called Privacy - Photo Library Usage Description in the visual editor.
This permission will not be requested if you always pass false for requestFullMetadata, but App Store policy requires including the plist entry.
NSCameraUsageDescription - describe why your app needs access to the camera. This is called Privacy - Camera Usage Description in the visual editor.
NSMicrophoneUsageDescription - describe why your app needs access to the microphone, if you intend to record videos. This is called Privacy - Microphone Usage Description in the visual editor.
- No configuration required

### Web
- Add following codes inside `<head>` tag in file `web/index.html`:

```html
<head>
  ....

  <!-- Croppie -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/croppie/2.6.5/croppie.css" />
  <script defer src="https://cdnjs.cloudflare.com/ajax/libs/exif-js/2.3.0/exif.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/croppie/2.6.5/croppie.min.js"></script>

  ....
</head>
```

## Usage

### Required parameters

* **sourcePath**: the absolute path of an image file.

### Optional parameters

* **maxWidth**: maximum cropped image width. Note: this field is ignored on Web.

* **maxHeight**: maximum cropped image height. Note: this field is ignored on Web.

* **aspectRatio**: controls the aspect ratio of crop bounds. If this values is set, the cropper is locked and user can't change the aspect ratio of crop bounds. Note: this field is ignored on Web.

* **aspectRatioPresets**: controls the list of aspect ratios in the crop menu view. In Android, you can set the initialized aspect ratio when starting the cropper by setting the value of `AndroidUiSettings.initAspectRatio`. Note: this field is ignored on Web.

* **cropStyle**: controls the style of crop bounds, it can be rectangle or circle style (default is `CropStyle.rectangle`). Note: this field can be overrided by `WebUiSettings.viewPort.type` on Web

* **compressFormat**: the format of result image, png or jpg (default is ImageCompressFormat.jpg).

* **compressQuality**: number between 0 and 100 to control the quality of image compression.

* **uiSettings**: controls UI customization on specific platform (android, ios, web,...)

  * Android: see [Android customization](#android-1).

  * iOS: see [iOS customization](#ios-1).

  * Web: see [Web customization](#web-1).

### Note

* The result file is saved in `NSTemporaryDirectory` on iOS and application Cache directory on Android, so it can be lost later, you are responsible for storing it somewhere permanent (if needed).

* The implementation on Web is much different compared to the implementation on mobile app. It causes some configuration fields not working (`maxWidth`, `maxHeight`, `aspectRatio`, `aspectRatioPresets`) on Web.

* `WebUiSettings` is required for Web.

## Customization

</details>

## Example

````dart


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _pickedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              ImagePickerCropperManager pickerCropperManager =
                  ImagePickerCropperManager();
              var pickedImage = await pickerCropperManager.pickAndCropImage();
              if (pickedImage != null) {
                setState(() {
                  _pickedImage = File(pickedImage.path);
                });
              }
            },
            child: const Text('Pick Image'),
          ),
          const SizedBox(height: 20),
          if (_pickedImage != null)
            Expanded(
              child: Image.file(
                _pickedImage!,
                fit: BoxFit.cover, // This makes the image take full width
              ),
            ),
        ],
      ),
    );
  }
}
    
````

</details>
