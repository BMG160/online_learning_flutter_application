
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myanmar_educational/constant/strings.dart';
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
import 'package:myanmar_educational/network/data_agent/data_agent.dart';

class CloudFireStoreDatabaseImpl extends DataAgent {
  CloudFireStoreDatabaseImpl._();

  static final CloudFireStoreDatabaseImpl _singleton = CloudFireStoreDatabaseImpl
      ._();

  factory CloudFireStoreDatabaseImpl() => _singleton;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> createNewAdmin(AdminVO newAdmin) =>
      _firestore
          .collection(kRootNodeForAdmin)
          .doc(newAdmin.adminID)
          .set(newAdmin.toJson());

  @override
  Future<void> createNewTeacher(TeacherVO newTeacher) =>
      _firestore
          .collection(kRootNodeForTeacher)
          .doc(newTeacher.teacherID)
          .set(newTeacher.toJson());

  @override
  Future<AdminVO?> getAdminByAdminID(String adminID) =>
      _firestore
          .collection(kRootNodeForAdmin)
          .doc(adminID)
          .get()
          .asStream()
          .map((documentSnapShot) =>
          AdminVO.fromJson(documentSnapShot.data() ?? {}))
          .first;

  @override
  Stream<List<AdminVO>?> getAdminListStream() => _firestore
      .collection(kRootNodeForAdmin)
      .snapshots()
      .map((querySnapShot){
        return querySnapShot.docs.map((document){
          return AdminVO.fromJson(document.data());
        }).toList();
  });

  @override
  Future<TeacherVO?> getTeacherByTeacherID(String teacherID) =>
      _firestore
          .collection(kRootNodeForTeacher)
          .doc(teacherID)
          .get()
          .asStream()
          .map((documentSnapShot) =>
          TeacherVO.fromJson(documentSnapShot.data() ?? {}))
          .first;

  @override
  Stream<List<TeacherVO>?> getTeacherListStream() =>
      _firestore
          .collection(kRootNodeForTeacher)
          .snapshots()
          .map((querySnapShot) {
        return querySnapShot.docs.map((document) {
          return TeacherVO.fromJson(document.data());
        }).toList();
      });

  @override
  Future<void> createNewCategory(CategoryVO newCategory) =>
      _firestore
          .collection(kRootNodeForCategory)
          .doc(newCategory.categoryID)
          .set(newCategory.toJson());

  @override
  Stream<List<CategoryVO>?> getCategoryListStream() =>
      _firestore
          .collection(kRootNodeForCategory)
          .snapshots()
          .map((querySnapShot) {
        return querySnapShot.docs.map((document) {
          return CategoryVO.fromJson(document.data());
        }).toList();
      });

  @override
  Future<void> createNewCourse(CourseVO newCourse) =>
      _firestore
          .collection(kRootNodeForCourse)
          .doc(newCourse.courseID)
          .set(newCourse.toJson());

  @override
  Future<void> createNewTeacherCourse(CourseVO newCourse, String teacherID,
      String categoryID) =>
      _firestore
          .collection(kRootNodeForTeacher)
          .doc(teacherID)
          .collection(kRootNodeForCourse)
          .doc(categoryID)
          .collection(kRootNodeForCourseInformation)
          .doc(newCourse.courseID)
          .set(newCourse.toJson());

  @override
  Future<CourseVO?> getCourseByCourseID(String courseID) =>
      _firestore
          .collection(kRootNodeForCourse)
          .doc(courseID)
          .get()
          .asStream()
          .map((documentSnapShot) =>
          CourseVO.fromJson(documentSnapShot.data() ?? {}))
          .first;

  @override
  Stream<List<CourseVO>?> getCourseListStream() =>
      _firestore
          .collection(kRootNodeForCourse)
          .snapshots()
          .map((querySnap) {
        return querySnap.docs.map((document) {
          return CourseVO.fromJson(document.data());
        }).toList();
      });


  @override
  Future<CourseVO?> getTeacherCourseByCourseID(String teacherID,
      String categoryID, String courseID) =>
      _firestore
          .collection(kRootNodeForTeacher)
          .doc(teacherID)
          .collection(kRootNodeForCourse)
          .doc(categoryID)
          .collection(kRootNodeForCourseInformation)
          .doc(courseID)
          .get()
          .asStream()
          .map((documentSnapShot) =>
          CourseVO.fromJson(documentSnapShot.data() ?? {}))
          .first;

  @override
  Stream<List<CourseVO>?> getTeacherCourseListStream(String teacherID,
      String categoryID) =>
      _firestore
          .collection(kRootNodeForTeacher)
          .doc(teacherID)
          .collection(kRootNodeForCourse)
          .doc(categoryID)
          .collection(kRootNodeForCourseInformation)
          .snapshots()
          .map((querySnapShot) {
        return querySnapShot.docs.map((document) {
          return CourseVO.fromJson(document.data());
        }).toList();
      });

  @override
  Future<VideoVO?> getSampleVideoByVideoID(String courseID, String videoID) =>
      _firestore
          .collection(kRootNodeForVideo)
          .doc(courseID)
          .collection(kRootNodeForSampleVideo)
          .doc(videoID)
          .get()
          .asStream()
          .map((documentSnapShot) =>
          VideoVO.fromJson(documentSnapShot.data() ?? {}))
          .first;

  @override
  Stream<List<VideoVO>?> getSampleVideoStream(String courseID) =>
      _firestore
          .collection(kRootNodeForVideo)
          .doc(courseID)
          .collection(kRootNodeForSampleVideo)
          .snapshots()
          .map((querySnapShot) {
        return querySnapShot.docs.map((document) {
          return VideoVO.fromJson(document.data());
        }).toList();
      });

  @override
  Future<VideoVO?> getTeacherSampleVideoByVideoID(String teacherID,
      String categoryID, String courseID, String videoID) =>
      _firestore
          .collection(kRootNodeForTeacher)
          .doc(teacherID)
          .collection(kRootNodeForCourse)
          .doc(categoryID)
          .collection(kRootNodeForCourseInformation)
          .doc(courseID)
          .collection(kRootNodeForSampleVideo)
          .doc(videoID)
          .get()
          .asStream()
          .map((documentSnapShot) =>
          VideoVO.fromJson(documentSnapShot.data() ?? {}))
          .first;

  @override
  Stream<List<VideoVO>?> getTeacherSampleVideoListStream(String teacherID,
      String categoryID, String courseID) =>
      _firestore
          .collection(kRootNodeForTeacher)
          .doc(teacherID)
          .collection(kRootNodeForCourse)
          .doc(categoryID)
          .collection(kRootNodeForCourseInformation)
          .doc(courseID)
          .collection(kRootNodeForSampleVideo)
          .snapshots()
          .map((querySnapShot) {
        return querySnapShot.docs.map((document) {
          return VideoVO.fromJson(document.data());
        }).toList();
      });

  @override
  Future<void> uploadSampleVideo(String courseID, VideoVO newVideo) =>
      _firestore
          .collection(kRootNodeForVideo)
          .doc(courseID)
          .collection(kRootNodeForSampleVideo)
          .doc(newVideo.videoID)
          .set(newVideo.toJson());

  @override
  Future<void> uploadTeacherSampleVideo(String teacherID, String categoryID,
      String courseID, VideoVO newVideo) =>
      _firestore
          .collection(kRootNodeForTeacher)
          .doc(teacherID)
          .collection(kRootNodeForCourse)
          .doc(categoryID)
          .collection(kRootNodeForCourseInformation)
          .doc(courseID)
          .collection(kRootNodeForSampleVideo)
          .doc(newVideo.videoID)
          .set(newVideo.toJson());

  @override
  Future<VideoVO?> getPaidVideoByVideoID(String courseID, String videoID) =>
      _firestore
          .collection(kRootNodeForVideo)
          .doc(courseID)
          .collection(kRootNodeForPaidVideo)
          .doc(videoID)
          .get()
          .asStream()
          .map((document) => VideoVO.fromJson(document.data() ?? {}))
          .first;

  @override
  Stream<List<VideoVO>?> getPaidVideoStream(String courseID) =>
      _firestore
          .collection(kRootNodeForVideo)
          .doc(courseID)
          .collection(kRootNodeForPaidVideo)
          .snapshots()
          .map((querySnapShot) {
        return querySnapShot.docs.map((document) {
          return VideoVO.fromJson(document.data());
        }).toList();
      });

  @override
  Future<VideoVO?> getTeacherPaidVideoByVideoID(String teacherID,
      String categoryID, String courseID, String videoID) =>
      _firestore
          .collection(kRootNodeForTeacher)
          .doc(teacherID)
          .collection(kRootNodeForCourse)
          .doc(categoryID)
          .collection(kRootNodeForCourseInformation)
          .doc(courseID)
          .collection(kRootNodeForPaidVideo)
          .doc(videoID)
          .get()
          .asStream()
          .map((document) => VideoVO.fromJson(document.data() ?? {}))
          .first;


  @override
  Stream<List<VideoVO>?> getTeacherPaidVideoListStream(String teacherID,
      String categoryID, String courseID) =>
      _firestore
          .collection(kRootNodeForTeacher)
          .doc(teacherID)
          .collection(kRootNodeForCourse)
          .doc(categoryID)
          .collection(kRootNodeForCourseInformation)
          .doc(courseID)
          .collection(kRootNodeForPaidVideo)
          .snapshots()
          .map((querySnapShot) {
        return querySnapShot.docs.map((document) {
          return VideoVO.fromJson(document.data());
        }).toList();
      });

  @override
  Future<void> uploadPaidVideo(String courseID, VideoVO newVideo) =>
      _firestore
          .collection(kRootNodeForVideo)
          .doc(courseID)
          .collection(kRootNodeForPaidVideo)
          .doc(newVideo.videoID)
          .set(newVideo.toJson());


  @override
  Future<void> uploadTeacherPaidVideo(String teacherID, String categoryID,
      String courseID, VideoVO newVideo) =>
      _firestore
          .collection(kRootNodeForTeacher)
          .doc(teacherID)
          .collection(kRootNodeForCourse)
          .doc(categoryID)
          .collection(kRootNodeForCourseInformation)
          .doc(courseID)
          .collection(kRootNodeForPaidVideo)
          .doc(newVideo.videoID)
          .set(newVideo.toJson());

  @override
  Future<FileVO?> getLectureFileByFileID(String courseID, String fileID) =>
      _firestore
          .collection(kRootNodeForFiles)
          .doc(courseID)
          .collection(kRootNodeForLectureFolder)
          .doc(fileID)
          .get()
          .asStream()
          .map((document) => FileVO.fromJson(document.data() ?? {}))
          .first;

  @override
  Stream<List<FileVO>?> getLectureFileStream(String courseID) =>
      _firestore
          .collection(kRootNodeForFiles)
          .doc(courseID)
          .collection(kRootNodeForLectureFolder)
          .snapshots()
          .map((querySnapShot) {
        return querySnapShot.docs.map((document) {
          return FileVO.fromJson(document.data());
        }).toList();
      });

  @override
  Future<FileVO?> getTeacherLectureFileByFileID(String teacherID,
      String categoryID, String courseID, String fileID) =>
      _firestore
          .collection(kRootNodeForTeacher)
          .doc(teacherID)
          .collection(kRootNodeForCourse)
          .doc(categoryID)
          .collection(kRootNodeForCourseInformation)
          .doc(courseID)
          .collection(kRootNodeForLectureFolder)
          .doc(fileID)
          .get()
          .asStream()
          .map((document) => FileVO.fromJson(document.data() ?? {}))
          .first;

  @override
  Stream<List<FileVO>?> getTeacherLectureFileStream(String teacherID,
      String categoryID, String courseID) =>
      _firestore
          .collection(kRootNodeForTeacher)
          .doc(teacherID)
          .collection(kRootNodeForCourse)
          .doc(categoryID)
          .collection(kRootNodeForCourseInformation)
          .doc(courseID)
          .collection(kRootNodeForLectureFolder)
          .snapshots()
          .map((querySnapShot) {
        return querySnapShot.docs.map((document) {
          return FileVO.fromJson(document.data());
        }).toList();
      });

  @override
  Future<void> uploadLectureFile(String courseID, FileVO newFile) =>
      _firestore
          .collection(kRootNodeForFiles)
          .doc(courseID)
          .collection(kRootNodeForLectureFolder)
          .doc(newFile.fileID)
          .set(newFile.toJson());

  @override
  Future<void> uploadTeacherLectureFile(String teacherID, String categoryID,
      String courseID, FileVO newFile) =>
      _firestore
          .collection(kRootNodeForTeacher)
          .doc(teacherID)
          .collection(kRootNodeForCourse)
          .doc(categoryID)
          .collection(kRootNodeForCourseInformation)
          .doc(courseID)
          .collection(kRootNodeForLectureFolder)
          .doc(newFile.fileID)
          .set(newFile.toJson());

  @override
  Stream<List<FileVO>?> getAssignmentFileStream(String courseID) =>
      _firestore
          .collection(kRootNodeForFiles)
          .doc(courseID)
          .collection(kRootNodeForAssignmentFolder)
          .snapshots()
          .map((querySnapShot) {
        return querySnapShot.docs.map((document) {
          return FileVO.fromJson(document.data());
        }).toList();
      });

  @override
  Future<FileVO?> getAssignmentFileByFileID(String courseID, String fileID) =>
      _firestore
          .collection(kRootNodeForFiles)
          .doc(courseID)
          .collection(kRootNodeForAssignmentFolder)
          .doc(fileID)
          .get()
          .asStream()
          .map((document) => FileVO.fromJson(document.data() ?? {}))
          .first;

  @override
  Future<FileVO?> getTeacherAssignmentFileByFileID(String teacherID,
      String categoryID, String courseID, String fileID) =>
      _firestore
          .collection(kRootNodeForTeacher)
          .doc(teacherID)
          .collection(kRootNodeForCourse)
          .doc(categoryID)
          .collection(kRootNodeForCourseInformation)
          .doc(courseID)
          .collection(kRootNodeForAssignmentFolder)
          .doc(fileID)
          .get()
          .asStream()
          .map((document) => FileVO.fromJson(document.data() ?? {}))
          .first;

  @override
  Stream<List<FileVO>?> getTeacherAssignmentFileStream(String teacherID,
      String categoryID, String courseID) =>
      _firestore
          .collection(kRootNodeForTeacher)
          .doc(teacherID)
          .collection(kRootNodeForCourse)
          .doc(categoryID)
          .collection(kRootNodeForCourseInformation)
          .doc(courseID)
          .collection(kRootNodeForAssignmentFolder)
          .snapshots()
          .map((querySnapShot) {
        return querySnapShot.docs.map((document) {
          return FileVO.fromJson(document.data());
        }).toList();
      });

  @override
  Future<void> uploadAssignmentFile(String courseID, FileVO newFile) =>
      _firestore
          .collection(kRootNodeForFiles)
          .doc(courseID)
          .collection(kRootNodeForAssignmentFolder)
          .doc(newFile.fileID)
          .set(newFile.toJson());

  @override
  Future<void> uploadTeacherAssignmentFile(String teacherID, String categoryID,
      String courseID, FileVO newFile) =>
      _firestore
          .collection(kRootNodeForTeacher)
          .doc(teacherID)
          .collection(kRootNodeForCourse)
          .doc(categoryID)
          .collection(kRootNodeForCourseInformation)
          .doc(courseID)
          .collection(kRootNodeForAssignmentFolder)
          .doc(newFile.fileID)
          .set(newFile.toJson());

  @override
  Future<void> createNewStudent(StudentVO newStudent) =>
      _firestore
          .collection(kRootNodeForStudent)
          .doc(newStudent.studentID)
          .set(newStudent.toJson());

  @override
  Future<StudentVO?> getStudentByStudentID(String studentID) =>
      _firestore
          .collection(kRootNodeForStudent)
          .doc(studentID)
          .get()
          .asStream()
          .map((document) => StudentVO.fromJson(document.data() ?? {}))
          .first;

  @override
  Stream<List<StudentVO>?> getStudentListStream() =>
      _firestore
          .collection(kRootNodeForStudent)
          .snapshots()
          .map((querySnapShot) {
        return querySnapShot.docs.map((document) {
          return StudentVO.fromJson(document.data());
        }).toList();
      });

  @override
  Stream<List<CourseVO>?> getCourseListByCategoryIDStream(String categoryID) =>
      _firestore
          .collection(kRootNodeForCourse)
          .where('category_id', isEqualTo: categoryID)
          .snapshots()
          .map((querySnap) {
        return querySnap.docs.map((document) {
          return CourseVO.fromJson(document.data());
        }).toList();
      });

  @override
  Stream<List<CourseVO>?> getCourseListByTeacherIDStream(String teacherID) =>
      _firestore
          .collection(kRootNodeForCourse)
          .where('teacher_id', isEqualTo: teacherID)
          .snapshots()
          .map((querySnap) {
        return querySnap.docs.map((document) {
          return CourseVO.fromJson(document.data());
        }).toList();
      });

  @override
  Future<void> createEnrollment(EnrollmentVO newEnrollment) =>
      _firestore
          .collection(kRootNodeForEnrollment)
          .doc(newEnrollment.enrollmentID)
          .set(newEnrollment.toJson());

  @override
  Stream<List<EnrollmentVO>?> getEnrollmentByStudentIDAndCourseID(String studentID,
      String courseID) {
    return _firestore.collection(kRootNodeForEnrollment)
        .where('student_id', isEqualTo: studentID)
        .where('course_id', isEqualTo: courseID)
        .snapshots()
        .map((querySnapShot) {
      return querySnapShot.docs.map((document) {
        return EnrollmentVO.fromJson(document.data());
      }).toList();
    });
  }

  @override
  Future<void> createStudentAssignment(AssignmentVO newAssignment) => _firestore
      .collection(kRootNodeForAssignment)
      .doc(newAssignment.assignmentID)
      .set(newAssignment.toJson());

  @override
  Stream<List<AssignmentVO>?> getAssignmentByStudentIDAndCourseID(String studentID, String courseID) => _firestore
      .collection(kRootNodeForAssignment)
      .where('uploaded_by_id', isEqualTo: studentID)
      .where('course_id', isEqualTo: courseID)
      .snapshots()
      .map((querySnapShot){
        return querySnapShot.docs.map((document){
          return AssignmentVO.fromJson(document.data());
        }).toList();
  });

  @override
  Stream<List<AssignmentVO>?> getAssignmentByCourseID(String courseID) => _firestore
      .collection(kRootNodeForAssignment)
      .where('course_id', isEqualTo: courseID)
      .snapshots()
      .map((querySnapShot){
    return querySnapShot.docs.map((document){
      return AssignmentVO.fromJson(document.data());
    }).toList();
  });

  @override
  Stream<List<MessageVO>?> getMessageByChatRoomID(String chatroomID) => _firestore
      .collection(kRootNodeForChat)
      .doc(chatroomID)
      .collection(kRootNodeForMessage)
      .snapshots()
      .map((querySnapShot) {
        return querySnapShot.docs.map((document){
          return MessageVO.fromJson(document.data());
        }).toList();
  });

  @override
  Future<void> uploadMessage(String chatRoomID, MessageVO newMessage) => _firestore
      .collection(kRootNodeForChat)
      .doc(chatRoomID)
      .collection(kRootNodeForMessage)
      .doc(newMessage.messageID)
      .set(newMessage.toJson());

  @override
  Stream<List<EnrollmentVO>?> getEnrollmentByCourseID(String courseID) {
    return _firestore.collection(kRootNodeForEnrollment)
        .where('course_id', isEqualTo: courseID)
        .snapshots()
        .map((querySnapShot) {
      return querySnapShot.docs.map((document) {
        return EnrollmentVO.fromJson(document.data());
      }).toList();
    });
  }

  @override
  Future<void> createChatRoom(String chatRoomID, ChatRoomVO chatRoomVO) => _firestore
      .collection(kRootNodeForChat)
      .doc(chatRoomID)
      .set(chatRoomVO.toJson());

  @override
  Stream<List<EnrollmentVO>?> getAllEnrollmentStream() => _firestore
      .collection(kRootNodeForEnrollment)
      .snapshots()
      .map ((querySnapShot) {
        return querySnapShot.docs.map ((document) {
          return EnrollmentVO.fromJson(document.data());
        }).toList();
  });

  @override
  Stream<List<EnrollmentVO>?> getEnrollmentByStudentID(String studentID) {
    return _firestore.collection(kRootNodeForEnrollment)
        .where('student_id', isEqualTo: studentID)
        .snapshots()
        .map((querySnapShot) {
      return querySnapShot.docs.map((document) {
        return EnrollmentVO.fromJson(document.data());
      }).toList();
    });
  }

  @override
  Future<void> deleteEnrollRequestByRequestID(String requestID) => _firestore
      .collection(kRootNodeForRequest)
      .doc(requestID)
      .delete();

  @override
  Stream<List<RequestVO>?> getEnrollRequestListByCourseIDAndStudentID(String courseID, String studentID) => _firestore
      .collection(kRootNodeForRequest)
      .where('course_id', isEqualTo: courseID)
      .where('student_id', isEqualTo: studentID)
      .snapshots()
      .map((querySnapShot) {
        return querySnapShot.docs.map((document){
          return RequestVO.fromJson(document.data());
        }).toList();
  });

  @override
  Stream<List<RequestVO>?> getEnrollRequestListStream() => _firestore
      .collection(kRootNodeForRequest)
      .snapshots()
      .map((querySnapShot) {
        return querySnapShot.docs.map((document){
          return RequestVO.fromJson(document.data());
        }).toList();
  });

  @override
  Future<void> uploadEnrollRequest(RequestVO newRequest) => _firestore
      .collection(kRootNodeForRequest)
      .doc(newRequest.requestID)
      .set(newRequest.toJson());

  @override
  Future<void> deleteTeacher(String teacherID) => _firestore
      .collection(kRootNodeForTeacher)
      .doc(teacherID)
      .delete();

  @override
  Future<void> deleteStudent(String studentID) => _firestore
      .collection(kRootNodeForStudent)
      .doc(studentID)
      .delete();

  @override
  Future<void> deleteCourse(String courseID) => _firestore
      .collection(kRootNodeForCourse)
      .doc(courseID)
      .delete();

  @override
  Future<void> deleteCourseFromTeacher(String teacherID, String categoryID, String courseID) => _firestore
      .collection(kRootNodeForTeacher)
      .doc(teacherID)
      .collection(kRootNodeForCourse)
      .doc(categoryID)
      .collection(kRootNodeForCourseInformation)
      .doc(courseID)
      .delete();

  @override
  Stream<List<EnrollmentVO>?> getEnrollmentByTeacherID(String teacherID) {
    return _firestore.collection(kRootNodeForEnrollment)
        .where('teacher_id', isEqualTo: teacherID)
        .snapshots()
        .map((querySnapShot) {
          return querySnapShot.docs.map((document) {
            return EnrollmentVO.fromJson(document.data());
          }).toList();
    });
  }





  // @override
  // Stream<List<EnrollmentVO>?> getEnrollmentByStudentID(String studentID) {
  //   return _firestore.collection(kRootNodeForEnrollment)
  //       .where('student_id', isEqualTo: studentID)
  //       .snapshots()
  //       .map((querySnapShot) {
  //     return querySnapShot.docs.map((document) {
  //       return EnrollmentVO.fromJson(document.data());
  //     }).toList();
  //   });
  // }
}