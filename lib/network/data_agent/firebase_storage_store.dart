import 'dart:io';

abstract class FirebaseStorageStore{
  Future<String> uploadUserImagesToFireStorage(File userProfile);

  Future<String> uploadThumbnailsToFireStorage(File thumbnail);

  Future<String> uploadCourseVideoToFireStorage(File courseVideo);

  Future<String> uploadCourseImageToFireStorage(File courseImage);

  Future<String> uploadFileToFireStorage(File newFile);
}