import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePhoto extends StatefulWidget {
  const ProfilePhoto(
      {Key? key, required Locale locale, required BuildContext context})
      : super(key: key);

  @override
  State<ProfilePhoto> createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<ProfilePhoto> {
  Future<void> refreshTranslations() async {
    await context.setLocale(context.locale);
  }

  File? imageFile;
  final picker = ImagePicker();
  SharedPreferences? prefs;

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs?.getString('profile_image');
    if (imagePath != null) {
      setState(() {
        imageFile = File(imagePath);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refreshTranslations,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 50,
              child: imageFile == null
                  ? const Icon(
                      Icons.person,
                      size: 25,
                      color: Colors.white,
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(150.0),
                      child: Image.file(
                        imageFile!,
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
          ),
          Positioned(
            right: -10,
            bottom: 0,
            child: Container(
              width: 40,
              height: 35,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                ),
                color: Colors.white,
              ),
              child: Center(
                child: IconButton(
                  icon: const Icon(
                    Icons.camera_alt,
                    color: Colors.black,
                  ),
                  iconSize: 15,
                  onPressed: () async {
                    Map<Permission, PermissionStatus> statuses = await [
                      Permission.storage,
                      Permission.camera,
                    ].request();
                    if (statuses[Permission.storage]!.isGranted &&
                        statuses[Permission.camera]!.isGranted) {
                      // ignore: use_build_context_synchronously
                      showImagePicker(context);
                    } else {
                      if (kDebugMode) {
                        print('no permission granted');
                      }
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Card(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 5.2,
                margin: const EdgeInsets.only(top: 8.0),
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: InkWell(
                      child: const Column(
                        children: [
                          Icon(
                            Icons.image,
                            size: 60.0,
                          ),
                          SizedBox(height: 12.0),
                          Text(
                            "Gallery",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          )
                        ],
                      ),
                      onTap: () {
                        imgFromGallery();
                        Navigator.pop(context);
                      },
                    )),
                    Expanded(
                        child: InkWell(
                      child: const SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 60.0,
                            ),
                            SizedBox(height: 12.0),
                            Text(
                              "Camera",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        imgFromCamera();
                        Navigator.pop(context);
                      },
                    ))
                  ],
                )),
          );
        });
  }

  Future<void> imgFromGallery() async {
    try {
      var value =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
      if (value != null) {
        cropImage(File(value.path));
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error in _imgFromGallery: $e");
      }
    }
  }

  Future<void> imgFromCamera() async {
    try {
      var value =
          await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
      if (value != null) {
        cropImage(File(value.path));
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error in _imgFromCamera: $e");
      }
    }
  }

  Future<void> cropImage(File imgFile) async {
    try {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: imgFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9,
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9,
              ],
      );
      if (croppedFile != null) {
        imageCache.clear();
        setState(() {
          imageFile = File(croppedFile.path);
        });

        if (prefs != null) {
          prefs?.setString('profile_image', croppedFile.path);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error in _cropImage: $e");
      }
    }
  }
}
