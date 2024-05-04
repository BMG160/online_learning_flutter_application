import 'package:flutter/material.dart';
import 'package:myanmar_educational/data/apply/apply.dart';
import 'package:myanmar_educational/data/apply/apply_impl.dart';
import 'package:myanmar_educational/data/vos/chat_room_vo/chat_room_vo.dart';
import 'package:myanmar_educational/data/vos/enrollment_vo/enrollment_vo.dart';
import 'package:myanmar_educational/data/vos/student_vo/student_vo.dart';
import 'package:myanmar_educational/pages/private_chat_page.dart';
import 'package:myanmar_educational/utils/extension.dart';

class TeacherChatPageBloc extends ChangeNotifier{
  final Apply _apply = ApplyImpl();

  bool _dispose = false;

  List<EnrollmentVO>? enrollList ;

  bool get isDispose => _dispose;
  List<EnrollmentVO>? get getEnrollList => enrollList;

  TeacherChatPageBloc(String courseID){
      _apply.getEnrollmentByCourseID(courseID).listen((event) {
        if(event?.isNotEmpty ?? false){
          enrollList = event;
        } else{
          enrollList = null;
        }
        notifyListeners();
      });
  }

  void createChatRoom(BuildContext context, String senderID, String receiverID, String name) async{
    String chatRoomID = '';
    if(senderID.substring(0,1).codeUnitAt(0) > receiverID.substring(0,1).codeUnitAt(0)){
      chatRoomID = "${receiverID}_$senderID";
    } else {
      chatRoomID = "${senderID}_$receiverID";
    }
    await _apply.createChatRoom(chatRoomID, ChatRoomVO(senderID, receiverID));
    if(!context.mounted) return;
    context.navigateToNextScreenReplace(context, PrivateChatPage(chatRoomID: chatRoomID, senderID: senderID, name: name,));
  }

  @override
  void notifyListeners() {
    if(!_dispose){
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _dispose = true;
  }
}