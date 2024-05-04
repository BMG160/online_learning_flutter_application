
import 'dart:io';

import 'package:myanmar_educational/constant/strings.dart';
import 'package:myanmar_educational/data/apply/apply.dart';
import 'package:myanmar_educational/data/vos/admin_vo/admin_vo.dart';
import 'package:myanmar_educational/data/vos/assignment_vo/assignment_vo.dart';
import 'package:myanmar_educational/data/vos/category_vo/category_vo.dart';
import 'package:myanmar_educational/data/vos/course_vo/course_vo.dart';
import 'package:myanmar_educational/data/vos/enrollment_vo/enrollment_vo.dart';
import 'package:myanmar_educational/data/vos/file_vo/file_vo.dart';
import 'package:myanmar_educational/data/vos/message_vo/message_vo.dart';
import 'package:myanmar_educational/data/vos/request_vo/request_vo.dart';
import 'package:myanmar_educational/data/vos/student_vo/student_vo.dart';
import 'package:myanmar_educational/data/vos/teacher_vo/teacher_vo.dart';
import 'package:myanmar_educational/data/vos/video_vo/video_vo.dart';
import 'package:myanmar_educational/network/data_agent/cloud_fire_store_database_impl.dart';
import 'package:myanmar_educational/network/data_agent/data_agent.dart';
import 'package:myanmar_educational/network/data_agent/firebase_auth_abst.dart';
import 'package:myanmar_educational/network/data_agent/firebase_auth_impl.dart';
import 'package:myanmar_educational/network/data_agent/firebase_storage_store.dart';
import 'package:myanmar_educational/network/data_agent/firebase_storage_store_impl.dart';
import 'package:video_compress/video_compress.dart';

class ApplyImpl extends Apply{
  ApplyImpl._();

  static final ApplyImpl _singleton = ApplyImpl._();

  factory ApplyImpl() => _singleton;

  final DataAgent _agent = CloudFireStoreDatabaseImpl();
  final FirebaseStorageStore _store = FirebaseStorageStoreImpl();
  final FirebaseAuthAbst _auth = FirebaseAuthImpl();

  @override
  Future<void> createNewAdmin(AdminVO? adminVO, String? adminID, String? firstName, String? lastName, String? email, String? password, String? phoneNumber, File? profile, String? accountRegistrationDate, String? address, String? gender, String? role) async{
    if(adminVO == null){
      if(profile != null){
        String imageURL = await _store.uploadUserImagesToFireStorage(profile);
        return _auth.registerNewAdmin(AdminVO(adminID, firstName, lastName, email, password, phoneNumber, imageURL, accountRegistrationDate, address, gender, role));
      }
      return _auth.registerNewAdmin(AdminVO(adminID, firstName, lastName, email, password, phoneNumber, kDefaultProfileImage, accountRegistrationDate, address, gender, role));
    }
    return _agent.createNewAdmin(adminVO);
  }

  @override
  Future<void> createNewTeacher(TeacherVO? teacherVO, String? teacherID, String? firstName, String? lastName, String? email, String? password, String? phoneNumber, File? profile, String? accountRegistrationDate, String? address, String? gender, String? createdByAdminID, String? createdByAdminName, String? userRole) async{
    return _agent.createNewTeacher(teacherVO!);
  }

  @override
  Future<AdminVO?> getAdminByAdminID(String adminID) => _agent.getAdminByAdminID(adminID);

  @override
  String getLoggedInUser() => _auth.getLoggedInUser();

  @override
  Future<TeacherVO?> getTeacherByTeacherID(String teacherID) => _agent.getTeacherByTeacherID(teacherID);

  @override
  Stream<List<TeacherVO>?> getTeacherListStream() => _agent.getTeacherListStream();

  @override
  bool isLogin() => _auth.isLogin();

  @override
  Future login(String email, String password) => _auth.userLogin(email, password);

  @override
  Future logout() => _auth.logout();

  @override
  Future registerNewAdmin(AdminVO newAdmin) async{
    if(newAdmin.profile != null){
      String imageURL = await _store.uploadUserImagesToFireStorage(File(newAdmin.profile ?? kDefaultProfileImage));
      return _auth.registerNewAdmin(AdminVO('', newAdmin.firstName, newAdmin.lastName, newAdmin.email, newAdmin.password, newAdmin.phoneNumber, imageURL, newAdmin.accountRegistrationDate, newAdmin.address, newAdmin.gender, newAdmin.role));
    }
  }

  @override
  Future registerNewTeacher(TeacherVO newTeacher) async{
    if(newTeacher.profile != null){
      String imageURL = await _store.uploadUserImagesToFireStorage(File(newTeacher.profile ?? kDefaultProfileImage));
      return _auth.registerNewTeacher(TeacherVO('', newTeacher.firstName, newTeacher.lastName, newTeacher.email, newTeacher.password, newTeacher.phoneNumber, imageURL, newTeacher.accountRegistrationDate, newTeacher.address, newTeacher.gender, newTeacher.createdByAdminID, newTeacher.createdByAdminName, newTeacher.userRole));
    }
  }

  @override
  Future<void> createNewCategory(CategoryVO newCategory) => _agent.createNewCategory(newCategory);

  @override
  Stream<List<CategoryVO>?> getCategoryListStream() => _agent.getCategoryListStream();

  @override
  Future<void> createNewCourse(CourseVO newCourse) async{
    if(newCourse.photo != null){
      String imageURL = await _store.uploadCourseImageToFireStorage(File(newCourse.photo ?? kDefaultCourseImage));
      return _agent.createNewCourse(CourseVO(newCourse.courseID, newCourse.title, newCourse.description, newCourse.price, imageURL, newCourse.duration, newCourse.startDate, newCourse.categoryID, newCourse.teacherID, newCourse.teacherName));
    }
  }

  @override
  Future<void> createNewTeacherCourse(CourseVO newCourse, String teacherID, String categoryID) async{
    if(newCourse.photo!=null){
      String imageURL = await _store.uploadCourseImageToFireStorage(File(newCourse.photo ?? kDefaultProfileImage));
      return _agent.createNewTeacherCourse(CourseVO(newCourse.courseID, newCourse.title, newCourse.description, newCourse.price, imageURL, newCourse.duration, newCourse.startDate, newCourse.categoryID, newCourse.teacherID, newCourse.teacherName), teacherID, categoryID);
    }
  }

  @override
  Future<CourseVO?> getCourseByCourseID(String courseID) => _agent.getCourseByCourseID(courseID);

  @override
  Stream<List<CourseVO>?> getCourseListStream() => _agent.getCourseListStream();

  @override
  Future<CourseVO?> getTeacherCourseByCourseID(String teacherID, String categoryID, String courseID) => _agent.getTeacherCourseByCourseID(teacherID, categoryID, courseID);

  @override
  Stream<List<CourseVO>?> getTeacherCourseListStream(String teacherID, String categoryID) => _agent.getTeacherCourseListStream(teacherID, categoryID);

  @override
  Future<VideoVO?> getSampleVideoByVideoID(String courseID, String videoID) => _agent.getSampleVideoByVideoID(courseID, videoID);

  @override
  Stream<List<VideoVO>?> getSampleVideoStream(String courseID) => _agent.getSampleVideoStream(courseID);

  @override
  Future<VideoVO?> getTeacherSampleVideoByVideoID(String teacherID, String categoryID, String courseID, String videoID) => _agent.getTeacherSampleVideoByVideoID(teacherID, categoryID, courseID, videoID);

  @override
  Stream<List<VideoVO>?> getTeacherSampleVideoListStream(String teacherID, String categoryID, String courseID) => _agent.getTeacherSampleVideoListStream(teacherID, categoryID, courseID);

  @override
  Future<void> uploadSampleVideo(String courseID, VideoVO newVideo) async{
    if(newVideo.videoPath != null){
      MediaInfo? compressedVideoFilePath = await VideoCompress.compressVideo(newVideo.videoPath ?? '', quality: VideoQuality.MediumQuality, deleteOrigin: false);
      File thumbnail = await VideoCompress.getFileThumbnail(newVideo.videoPath ?? '');
      print('Thumb nail success');
      double duration = compressedVideoFilePath?.duration ?? 0.0;
      print('duration $duration');
      print('video p ${newVideo.videoPath}');
      String videoURL = await _store.uploadCourseVideoToFireStorage(File(newVideo.videoPath ?? ''));
      print('Upload Video Success');
      String thumbnailURL = await _store.uploadThumbnailsToFireStorage(thumbnail);
      print('Upload thumb nail success');
      return _agent.uploadSampleVideo(courseID, VideoVO(newVideo.videoID, newVideo.title, thumbnailURL, videoURL, duration.toString()));
    }
  }

  ////String twoDigits(int n) => n.toString().padLeft(2, "0");
  //     String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  //     String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  //     return "${duration.inHours}:$twoDigitMinutes:$twoDigitSeconds";

  @override
  Future<void> uploadTeacherSampleVideo(String teacherID, String categoryID, String courseID, VideoVO newVideo) async{
    if(newVideo.videoPath != null){
      MediaInfo? compressedVideoFilePath = await VideoCompress.compressVideo(newVideo.videoPath ?? '', quality: VideoQuality.MediumQuality, deleteOrigin: false);
      File thumbnail = await VideoCompress.getFileThumbnail(newVideo.videoPath ?? '');
      double duration = compressedVideoFilePath?.duration ?? 0.0;
      String videoURL = await _store.uploadCourseVideoToFireStorage(File(newVideo.videoPath ?? ''));
      String thumbnailURL = await _store.uploadThumbnailsToFireStorage(thumbnail);
      return _agent.uploadTeacherSampleVideo(teacherID, categoryID, courseID, VideoVO(newVideo.videoID, newVideo.title, thumbnailURL, videoURL, duration.toString()));
    }
  }

  @override
  Future<VideoVO?> getPaidVideoByVideoID(String courseID, String videoID) => _agent.getPaidVideoByVideoID(courseID, videoID);

  @override
  Stream<List<VideoVO>?> getPaidVideoStream(String courseID) => _agent.getPaidVideoStream(courseID);

  @override
  Future<VideoVO?> getTeacherPaidVideoByVideoID(String teacherID, String categoryID, String courseID, String videoID) => _agent.getTeacherPaidVideoByVideoID(teacherID, categoryID, courseID, videoID);

  @override
  Stream<List<VideoVO>?> getTeacherPaidVideoListStream(String teacherID, String categoryID, String courseID) => _agent.getTeacherPaidVideoListStream(teacherID, categoryID, courseID);

  @override
  Future<void> uploadPaidVideo(String courseID, VideoVO newVideo) async{
    if(newVideo.videoPath != null){
      MediaInfo? compressedVideoFilePath = await VideoCompress.compressVideo(newVideo.videoPath ?? '', quality: VideoQuality.MediumQuality, deleteOrigin: false);
      File thumbnail = await VideoCompress.getFileThumbnail(newVideo.videoPath ?? '');
      double duration = compressedVideoFilePath?.duration ?? 0.0;
      String videoURL = await _store.uploadCourseVideoToFireStorage(File(newVideo.videoPath ?? ''));
      String thumbnailURL = await _store.uploadThumbnailsToFireStorage(thumbnail);
      return _agent.uploadPaidVideo(courseID, VideoVO(newVideo.videoID, newVideo.title, thumbnailURL, videoURL, duration.toString()));
    }
  }

  @override
  Future<void> uploadTeacherPaidVideo(String teacherID, String categoryID, String courseID, VideoVO newVideo) async{
    if(newVideo.videoPath != null){
      MediaInfo? compressedVideoFilePath = await VideoCompress.compressVideo(newVideo.videoPath ?? '', quality: VideoQuality.MediumQuality, deleteOrigin: false);
      File thumbnail = await VideoCompress.getFileThumbnail(newVideo.videoPath ?? '');
      print('Thumbnail Success');
      double duration = compressedVideoFilePath?.duration ?? 0.0;
      String videoURL = await _store.uploadCourseVideoToFireStorage(File(newVideo.videoPath ?? ''));
      print('Video URL success');
      String thumbnailURL = await _store.uploadThumbnailsToFireStorage(thumbnail);
      return _agent.uploadTeacherPaidVideo(teacherID, categoryID, courseID, VideoVO(newVideo.videoID, newVideo.title, thumbnailURL, videoURL, duration.toString()));
    }
  }

  @override
  Future<FileVO?> getLectureFileByFileID(String courseID, String fileID) => _agent.getLectureFileByFileID(courseID, fileID);

  @override
  Stream<List<FileVO>?> getLectureFileStream(String courseID) => _agent.getLectureFileStream(courseID);

  @override
  Future<FileVO?> getTeacherLectureFileByFileID(String teacherID, String categoryID, String courseID, String fileID) => _agent.getTeacherLectureFileByFileID(teacherID, categoryID, courseID, fileID);

  @override
  Stream<List<FileVO>?> getTeacherLectureFileStream(String teacherID, String categoryID, String courseID) => _agent.getTeacherLectureFileStream(teacherID, categoryID, courseID);

  @override
  Future<void> uploadLectureFile(String courseID, FileVO newFile) async{
    if(newFile.filePath != null){
      String fileURL = await _store.uploadFileToFireStorage(File(newFile.filePath ?? ''));
      return _agent.uploadLectureFile(courseID, FileVO(newFile.fileID, newFile.fileName, fileURL, newFile.uploadedDate, newFile.uploadedByID, newFile.uploadedByName));
    }
  }

  @override
  Future<void> uploadTeacherLectureFile(String teacherID, String categoryID, String courseID, FileVO newFile) async{
    if(newFile.filePath != null){
      String fileURL = await _store.uploadFileToFireStorage(File(newFile.filePath ?? ''));
      return _agent.uploadTeacherLectureFile(teacherID, categoryID, courseID, FileVO(newFile.fileID, newFile.fileName, fileURL, newFile.uploadedDate, newFile.uploadedByID, newFile.uploadedByName));
    }
  }

  @override
  Future<FileVO?> getAssignmentFileByFileID(String courseID, String fileID) => _agent.getAssignmentFileByFileID(courseID, fileID);

  @override
  Stream<List<FileVO>?> getAssignmentFileStream(String courseID) => _agent.getAssignmentFileStream(courseID);

  @override
  Future<FileVO?> getTeacherAssignmentFileByFileID(String teacherID, String categoryID, String courseID, String fileID) => _agent.getTeacherAssignmentFileByFileID(teacherID, categoryID, courseID, fileID);

  @override
  Stream<List<FileVO>?> getTeacherAssignmentFileStream(String teacherID, String categoryID, String courseID) => _agent.getTeacherAssignmentFileStream(teacherID, categoryID, courseID);

  @override
  Future<void> uploadAssignmentFile(String courseID, FileVO newFile) async{
    if(newFile.filePath != null){
      String fileURL = await _store.uploadFileToFireStorage(File(newFile.filePath ?? ''));
      return _agent.uploadAssignmentFile(courseID, FileVO(newFile.fileID, newFile.fileName, fileURL, newFile.uploadedDate, newFile.uploadedByID, newFile.uploadedByName));
    }
  }

  @override
  Future<void> uploadTeacherAssignmentFile(String teacherID, String categoryID, String courseID, FileVO newFile) async{
    if(newFile.filePath != null){
      String fileURL = await _store.uploadFileToFireStorage(File(newFile.filePath ?? ''));
      return _agent.uploadTeacherAssignmentFile(teacherID, categoryID, courseID, FileVO(newFile.fileID, newFile.fileName, fileURL, newFile.uploadedDate, newFile.uploadedByID, newFile.uploadedByName));
    }
  }

  @override
  Future<void> createNewStudent(StudentVO? studentVO, String? studentID, String? firstName, String? lastName, String? email, String? password, String? phoneNumber, File? profile, String? accountRegistrationDate, String? userRole, String verificationID, String smsCode) async{
    if(studentVO == null){
      if(profile != null){
        String imageURL = await _store.uploadUserImagesToFireStorage(profile);
        return _auth.registerNewStudent(StudentVO(studentID, firstName, lastName, email, password, phoneNumber, imageURL, accountRegistrationDate, userRole), verificationID, smsCode);
      }
      String imageURL = await _store.uploadUserImagesToFireStorage(File(kDefaultProfileImage));
      return _auth.registerNewStudent(StudentVO(studentID, firstName, lastName, email, password, phoneNumber, imageURL, accountRegistrationDate, userRole), verificationID, smsCode);
    }
    return _agent.createNewStudent(studentVO);
  }

  @override
  Future<StudentVO?> getStudentByStudentID(String studentID) => _agent.getStudentByStudentID(studentID);

  @override
  Stream<List<StudentVO>?> getStudentListStream() => _agent.getStudentListStream();

  @override
  Future registerNewStudent(StudentVO newStudent, String verificationID, String smsCode) async{
    if(newStudent.profile != null){
      String imageURL = await _store.uploadUserImagesToFireStorage(File(newStudent.profile ?? ''));
      return _auth.registerNewStudent(StudentVO('', newStudent.firstName, newStudent.lastName, newStudent.email, newStudent.password, newStudent.phoneNumber, imageURL, newStudent.accountRegistrationDate, newStudent.userRole), verificationID, smsCode);
    }
  }

  @override
  Stream<List<CourseVO>?> getCourseListByCategoryIDStream(String categoryID) => _agent.getCourseListByCategoryIDStream(categoryID);

  @override
  Stream<List<CourseVO>?> getCourseListByTeacherIDStream(String teacherID) => _agent.getCourseListByTeacherIDStream(teacherID);

  @override
  Future<void> createEnrollment(EnrollmentVO newEnrollment) => _agent.createEnrollment(newEnrollment);

  @override
  Stream<List<EnrollmentVO>?> getEnrollmentByStudentIDAndCourseID(String studentID, String courseID) => _agent.getEnrollmentByStudentIDAndCourseID(studentID, courseID);

  @override
  Future<void> createStudentAssignment(AssignmentVO? assignment, AssignmentVO? newAssignment) async{
    if(assignment == null){
      if(newAssignment?.filePath != null){
        String fileURL = await _store.uploadFileToFireStorage(File(newAssignment?.filePath ?? ''));
        return _agent.createStudentAssignment(AssignmentVO(newAssignment?.assignmentID, newAssignment?.fileName, fileURL, newAssignment?.uploadedDate, newAssignment?.uploadedByID, newAssignment?.uploadedByName, newAssignment?.courseID, newAssignment?.teacherComment, newAssignment?.studentMark));
      }
    } else {

      return _agent.createStudentAssignment(AssignmentVO(assignment.assignmentID, assignment.fileName, assignment.filePath, assignment.uploadedDate, assignment.uploadedByID, assignment.uploadedByName, assignment.courseID, assignment.teacherComment, assignment.studentMark));
    }
  }

  @override
  Stream<List<AssignmentVO>?> getAssignmentByStudentIDAndCourseID(String studentID, String courseID) => _agent.getAssignmentByStudentIDAndCourseID(studentID, courseID);

  @override
  Stream<List<AssignmentVO>?> getAssignmentByCourseID(String courseID) => _agent.getAssignmentByCourseID(courseID);

  @override
  Stream<List<MessageVO>?> getMessageByChatRoomID(String chatroomID) => _agent.getMessageByChatRoomID(chatroomID);

  @override
  Future<void> uploadMessage(String chatRoomID, newMessage) => _agent.uploadMessage(chatRoomID, newMessage);

  @override
  Stream<List<EnrollmentVO>?> getEnrollmentByCourseID(String courseID) => _agent.getEnrollmentByCourseID(courseID);

  @override
  Future<void> createChatRoom(String chatRoomID, chatRoomVO) => _agent.createChatRoom(chatRoomID, chatRoomVO);

  @override
  Stream<List<EnrollmentVO>?> getAllEnrollmentStream() => _agent.getAllEnrollmentStream();

  @override
  Stream<List<EnrollmentVO>?> getEnrollmentByStudentID(String studentID) => _agent.getEnrollmentByStudentID(studentID);

  @override
  Future<void> deleteEnrollRequestByRequestID(String requestID) => _agent.deleteEnrollRequestByRequestID(requestID);

  @override
  Stream<List<RequestVO>?> getEnrollRequestListByCourseIDAndStudentID(String courseID, String studentID) => _agent.getEnrollRequestListByCourseIDAndStudentID(courseID, studentID);

  @override
  Stream<List<RequestVO>?> getEnrollRequestListStream() => _agent.getEnrollRequestListStream();

  @override
  Future<void> uploadEnrollRequest(RequestVO newRequest) => _agent.uploadEnrollRequest(newRequest);

  @override
  Future deleteUser() => _auth.deleteUser();

  @override
  Future<void> deleteStudent(String studentID) => _agent.deleteStudent(studentID);

  @override
  Future<void> deleteTeacher(String teacherID) => _agent.deleteTeacher(teacherID);

  @override
  Future<void> deleteCourse(String courseID) => _agent.deleteCourse(courseID);

  @override
  Future<void> deleteCourseFromTeacher(String teacherID, String categoryID, String courseID) => _agent.deleteCourseFromTeacher(teacherID, categoryID, courseID);

  @override
  Stream<List<EnrollmentVO>?> getEnrollmentByTeacherID(String teacherID) => _agent.getEnrollmentByTeacherID(teacherID);

  @override
  Stream<List<AdminVO>?> getAdminListStream() => _agent.getAdminListStream();

}