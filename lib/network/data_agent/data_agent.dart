
import 'package:myanmar_educational/data/vos/admin_vo/admin_vo.dart';
import 'package:myanmar_educational/data/vos/assignment_vo/assignment_vo.dart';
import 'package:myanmar_educational/data/vos/category_vo/category_vo.dart';
import 'package:myanmar_educational/data/vos/chat_room_vo/chat_room_vo.dart';
import 'package:myanmar_educational/data/vos/course_vo/course_vo.dart';
import 'package:myanmar_educational/data/vos/enrollment_vo/enrollment_vo.dart';
import 'package:myanmar_educational/data/vos/file_vo/file_vo.dart';
import 'package:myanmar_educational/data/vos/message_vo/message_vo.dart';
import 'package:myanmar_educational/data/vos/request_vo/request_vo.dart';
import 'package:myanmar_educational/data/vos/student_vo/student_vo.dart';
import 'package:myanmar_educational/data/vos/teacher_vo/teacher_vo.dart';
import 'package:myanmar_educational/data/vos/video_vo/video_vo.dart';

abstract class DataAgent{
  Future<void> createNewAdmin(AdminVO newAdmin);

  Future<AdminVO?> getAdminByAdminID(String adminID);

  Stream<List<AdminVO>?> getAdminListStream();

  Stream<List<TeacherVO>?> getTeacherListStream();

  Future<void> createNewTeacher(TeacherVO newTeacher);

  Future<void> deleteTeacher(String teacherID);

  Future<TeacherVO?> getTeacherByTeacherID(String teacherID);

  Future<void> createNewCategory(CategoryVO newCategory);

  Stream<List<CategoryVO>?> getCategoryListStream();

  Future<void> createNewTeacherCourse(CourseVO newCourse,String teacherID, String categoryID);

  Future<void> createNewCourse(CourseVO newCourse);

  Stream<List<CourseVO>?> getCourseListByTeacherIDStream(String teacherID);

  Stream<List<CourseVO>?> getTeacherCourseListStream(String teacherID, String categoryID);

  Stream<List<CourseVO>?> getCourseListStream();


  Stream<List<CourseVO>?> getCourseListByCategoryIDStream(String categoryID);

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

  Future<void> createNewStudent(StudentVO newStudent);

  Future<void> deleteStudent(String studentID);

  Future<StudentVO?> getStudentByStudentID(String studentID);

  Future<void> createEnrollment(EnrollmentVO newEnrollment);

  Stream<List<EnrollmentVO>?> getEnrollmentByStudentIDAndCourseID(String studentID, String courseID);

  Stream<List<EnrollmentVO>?> getEnrollmentByCourseID(String courseID);

  Stream<List<EnrollmentVO>?> getEnrollmentByStudentID(String studentID);

  Stream<List<EnrollmentVO>?> getAllEnrollmentStream();

  Future<void> createStudentAssignment(AssignmentVO newAssignment);

  Stream<List<AssignmentVO>?> getAssignmentByStudentIDAndCourseID(String studentID, String courseID);

  Stream<List<AssignmentVO>?> getAssignmentByCourseID(String courseID);

  Future<void> createChatRoom(String chatRoomID, ChatRoomVO chatRoomVO);

  Future<void> uploadMessage(String chatRoomID, MessageVO newMessage);

  Stream<List<MessageVO>?> getMessageByChatRoomID(String chatroomID);

  Future<void> uploadEnrollRequest(RequestVO newRequest);

  Stream<List<RequestVO>?> getEnrollRequestListStream();

  Stream<List<RequestVO>?> getEnrollRequestListByCourseIDAndStudentID(String courseID, String studentID);

  Future<void> deleteEnrollRequestByRequestID(String requestID);

  Future<void> deleteCourseFromTeacher(String teacherID, String categoryID, String courseID);

  Future<void> deleteCourse(String courseID);

  Stream<List<EnrollmentVO>?> getEnrollmentByTeacherID(String teacherID);
}