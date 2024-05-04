
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myanmar_educational/data/vos/admin_vo/admin_vo.dart';
import 'package:myanmar_educational/data/vos/student_vo/student_vo.dart';
import 'package:myanmar_educational/data/vos/teacher_vo/teacher_vo.dart';
import 'package:myanmar_educational/network/data_agent/cloud_fire_store_database_impl.dart';
import 'package:myanmar_educational/network/data_agent/data_agent.dart';
import 'package:myanmar_educational/network/data_agent/firebase_auth_abst.dart';

class FirebaseAuthImpl extends FirebaseAuthAbst{
  FirebaseAuthImpl._();

  static final FirebaseAuthImpl _singleton = FirebaseAuthImpl._();

  factory FirebaseAuthImpl() => _singleton;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DataAgent _dataAgent = CloudFireStoreDatabaseImpl();

  @override
  String getLoggedInUser() => _auth.currentUser?.uid ?? '';

  @override
  bool isLogin() => _auth.currentUser != null;

  @override
  Future logout() => _auth.signOut();

  @override
  Future registerNewAdmin(AdminVO newAdmin) => _auth
      .createUserWithEmailAndPassword(email: newAdmin.email ?? '', password: newAdmin.password ?? '')
      .then((credential){
        User? user = credential.user;
        if(user != null){
          user.updateDisplayName(newAdmin.firstName).then((_){
            final User? user = _auth.currentUser;
            newAdmin.adminID = user?.uid;
            _dataAgent.createNewAdmin(newAdmin);
          });
        }
  });

  @override
  Future registerNewTeacher(TeacherVO newTeacher) => _auth
      .createUserWithEmailAndPassword(email: newTeacher.email ?? '', password: newTeacher.password ?? '')
      .then((credential){
        User? user = credential.user;
        if(user != null){
          user.updateDisplayName(newTeacher.firstName).then((_){
            final User? user = _auth.currentUser;
            newTeacher.teacherID = user?.uid;
            _dataAgent.createNewTeacher(newTeacher);
          });
        }
  });

  @override
  Future userLogin(String email, String password) => _auth.signInWithEmailAndPassword(email: email, password: password);

  @override
  Future registerNewStudent(StudentVO newStudent, String verificationID, String smsCode) async{
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationID, smsCode: smsCode);
      return await _auth.signInWithCredential(credential).then((credential) async {
        User? u = credential.user;
        if(u != null){
          await _auth.createUserWithEmailAndPassword(email: newStudent.email ?? '', password: newStudent.password ?? '').then((value) {
            User? user = value.user;
            if(user != null){
              user.updateDisplayName(newStudent.firstName).then((_) {
                final User? user = _auth.currentUser;
                newStudent.studentID = user?.uid;
                _dataAgent.createNewStudent(newStudent);
              });
            }
          });
        }
      });
    } catch (e){
      print('wrong opt');
    }
  }

  @override
  Future deleteUser() async => await _auth.currentUser?.delete();

}