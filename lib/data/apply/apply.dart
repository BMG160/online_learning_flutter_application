import 'dart:async';
import 'dart:io';
import 'package:myanmar_educational/data/vos/admin_vo/admin_vo.dart';
import 'package:myanmar_educational/data/vos/student_vo/student_vo.dart';
import 'package:myanmar_educational/data/vos/teacher_vo/teacher_vo.dart';

import '../vos/assignment_vo/assignment_vo.dart';
import '../vos/category_vo/category_vo.dart';
import '../vos/chat_room_vo/chat_room_vo.dart';
import '../vos/course_vo/course_vo.dart';
import '../vos/enrollment_vo/enrollment_vo.dart';
import '../vos/file_vo/file_vo.dart';
import '../vos/message_vo/message_vo.dart';
import '../vos/request_vo/request_vo.dart';
import '../vos/video_vo/video_vo.dart';

abstract class Apply{
  Future<void> createNewAdmin(AdminVO? adminVO, String? adminID, String? firstName, String? lastName, String? email, String? password, String? phoneNumber, File? profile, String? accountRegistrationDate, String? address, String? gender, String? role);

  Future<AdminVO?> getAdminByAdminID(String adminID);

  Stream<List<AdminVO>?> getAdminListStream();

  Stream<List<TeacherVO>?> getTeacherListStream();

  Future<void> createNewTeacher (TeacherVO? teacherVO, String? teacherID, String? firstName, String? lastName, String? email, String? password, String? phoneNumber, File? profile, String? accountRegistrationDate, String? address, String? gender, String? createdByAdminID, String? createdByAdminName, String? userRole);

  Future<TeacherVO?> getTeacherByTeacherID(String teacherID);

  Future registerNewAdmin(AdminVO newAdmin);

  Future registerNewTeacher(TeacherVO newTeacher);

  Future deleteUser();

  bool isLogin();

  String getLoggedInUser();

  Future logout();

  Future login(String email, String password);

  Future<void> createNewCategory(CategoryVO newCategory);

  Stream<List<CategoryVO>?> getCategoryListStream();

  Future<void> createNewTeacherCourse(CourseVO newCourse,String teacherID, String categoryID);

  Future<void> createNewCourse(CourseVO newCourse);

  Stream<List<CourseVO>?> getTeacherCourseListStream(String teacherID, String categoryID);

  Stream<List<CourseVO>?> getCourseListStream();

  Stream<List<CourseVO>?> getCourseListByTeacherIDStream(String teacherID);

  Future<CourseVO?> getTeacherCourseByCourseID(String teacherID, String categoryID, String courseID);

  Future<CourseVO?> getCourseByCourseID(String courseID);

  Future<void> uploadTeacherSampleVideo(String teacherID, String categoryID, String courseID, VideoVO newVideo);

  Future<void> uploadSampleVideo(String courseID, VideoVO newVideo);

  Stream<List<VideoVO>?> getTeacherSampleVideoListStream(String teacherID, String categoryID, String courseID);

  Stream<List<VideoVO>?> getSampleVideoStream(String courseID);

  Future<VideoVO?> getTeacherSampleVideoByVideoID(String teacherID, String categoryID, String courseID, String videoID);

  Future<VideoVO?> getSampleVideoByVideoID(String courseID, String videoID);

  Future<void> uploadTeacherPaidVideo(String teacherID, String categoryID, String courseID, VideoVO newVideo);

  Future<void> uploadPaidVideo(String courseID, VideoVO newVideo);

  Stream<List<VideoVO>?> getTeacherPaidVideoListStream(String teacherID, String categoryID, String courseID);

  Stream<List<VideoVO>?> getPaidVideoStream(String courseID);

  Future<VideoVO?> getTeacherPaidVideoByVideoID(String teacherID, String categoryID, String courseID, String videoID);

  Future<VideoVO?> getPaidVideoByVideoID(String courseID, String videoID);

  Future<void> uploadTeacherLectureFile(String teacherID, String categoryID, String courseID, FileVO newFile);

  Future<void> uploadLectureFile(String courseID, FileVO newFile);

  Stream<List<FileVO>?> getTeacherLectureFileStream(String teacherID, String categoryID, String courseID);

  Stream<List<FileVO>?> getLectureFileStream(String courseID);

  Future<FileVO?> getTeacherLectureFileByFileID(String teacherID, String categoryID, String courseID, String fileID);

  Future<FileVO?> getLectureFileByFileID(String courseID, String fileID);

  Future<void> uploadTeacherAssignmentFile(String teacherID, String categoryID, String courseID, FileVO newFile);

  Future<void> uploadAssignmentFile(String courseID, FileVO newFile);

  Stream<List<FileVO>?> getTeacherAssignmentFileStream(String teacherID, String categoryID, String courseID);

  Stream<List<FileVO>?> getAssignmentFileStream(String courseID);

  Future<FileVO?> getTeacherAssignmentFileByFileID(String teacherID, String categoryID, String courseID, String fileID);

  Future<FileVO?> getAssignmentFileByFileID(String courseID, String fileID);

  Stream<List<StudentVO>?> getStudentListStream();

  Future<void> createNewStudent (StudentVO? studentVO, String? studentID, String? firstName, String? lastName, String? email, String? password, String? phoneNumber, File? profile, String? accountRegistrationDate, String? userRole, String verificationID, String smsCode);

  Future<StudentVO?> getStudentByStudentID(String studentID);

  Future registerNewStudent(StudentVO newStudent, String verificationID, String smsCode);

  Stream<List<CourseVO>?> getCourseListByCategoryIDStream(String categoryID);

  Future<void> createEnrollment(EnrollmentVO newEnrollment);

  Stream<List<EnrollmentVO>?> getEnrollmentByStudentIDAndCourseID(String studentID, String courseID);

  Future<void> createStudentAssignment(AssignmentVO? assignment, AssignmentVO? newAssignment);

  Stream<List<AssignmentVO>?> getAssignmentByStudentIDAndCourseID(String studentID, String courseID);

  Stream<List<AssignmentVO>?> getAssignmentByCourseID(String courseID);

  Future<void> uploadMessage(String chatRoomID, MessageVO newMessage);

  Stream<List<MessageVO>?> getMessageByChatRoomID(String chatroomID);

  Stream<List<EnrollmentVO>?> getEnrollmentByCourseID(String courseID);

  Future<void> createChatRoom(String chatRoomID, ChatRoomVO chatRoomVO);

  Stream<List<EnrollmentVO>?> getAllEnrollmentStream();

  Stream<List<EnrollmentVO>?> getEnrollmentByStudentID(String studentID);

  Future<void> uploadEnrollRequest(RequestVO newRequest);

  Stream<List<RequestVO>?> getEnrollRequestListStream();

  Stream<List<RequestVO>?> getEnrollRequestListByCourseIDAndStudentID(String courseID, String studentID);

  Future<void> deleteEnrollRequestByRequestID(String requestID);

  Future<void> deleteTeacher(String teacherID);

  Future<void> deleteStudent(String studentID);

  Future<void> deleteCourseFromTeacher(String teacherID, String categoryID, String courseID);

  Future<void> deleteCourse(String courseID);

  Stream<List<EnrollmentVO>?> getEnrollmentByTeacherID(String teacherID);
}