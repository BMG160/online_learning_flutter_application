
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:myanmar_educational/constant/strings.dart';
import 'package:myanmar_educational/network/data_agent/firebase_storage_store.dart';

class FirebaseStorageStoreImpl extends FirebaseStorageStore{
  FirebaseStorageStoreImpl._();

  static final FirebaseStorageStoreImpl _singleton = FirebaseStorageStoreImpl._();

  factory FirebaseStorageStoreImpl() => _singleton;

  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  Future<String> uploadCourseVideoToFireStorage(File courseVideo) => _storage
      .ref(kRootNodeForVideoUploadPath)
      .child('${DateTime.now().millisecondsSinceEpoch}')
      .putFile(courseVideo)
      .then((takeSnapShot) => takeSnapShot.ref.getDownloadURL());

  @override
  Future<String> uploadThumbnailsToFireStorage(File thumbnail) => _storage
      .ref(kRootNodeForThumbnailUploadPath)
      .child('${DateTime.now().millisecondsSinceEpoch}')
      .putFile(thumbnail)
      .then((takeSnapShot) => takeSnapShot.ref.getDownloadURL());

  @override
  Future<String> uploadUserImagesToFireStorage(File userProfile) => _storage
      .ref(kRootNodeForUserProfileUploadPath)
      .child('${DateTime.now().microsecondsSinceEpoch}')
      .putFile(userProfile)
      .then((takeSnapShot) => takeSnapShot.ref.getDownloadURL());

  @override
  Future<String> uploadCourseImageToFireStorage(File courseImage) => _storage
      .ref(kRootNodeForCourseImageUploadPath)
      .child('${DateTime.now().microsecondsSinceEpoch}')
      .putFile(courseImage)
      .then((takeSnapShot) => takeSnapShot.ref.getDownloadURL());

  @override
  Future<String> uploadFileToFireStorage(File newFile) => _storage
      .ref(kRootNodeForFileUploadPath)
      .child('${DateTime.now().millisecondsSinceEpoch}')
      .putFile(newFile)
      .then((takeSnapShot) => takeSnapShot.ref.getDownloadURL());


}