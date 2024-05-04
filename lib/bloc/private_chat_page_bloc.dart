import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myanmar_educational/data/apply/apply.dart';
import 'package:myanmar_educational/data/apply/apply_impl.dart';
import 'package:myanmar_educational/data/vos/message_vo/message_vo.dart';

class PrivateChatPageBloc extends ChangeNotifier{
  final Apply _apply = ApplyImpl();

  bool _dispose = false;

  List<MessageVO>? messageList;

  TextEditingController messageController = TextEditingController();

  bool get isDispose => _dispose;
  TextEditingController get getMessageController => messageController;
  List<MessageVO>? get getMessageList => messageList;

  PrivateChatPageBloc(String chatRoomID){
    _apply.getMessageByChatRoomID(chatRoomID).listen((event) {
      if(event?.isNotEmpty ?? false){
        messageList = event;
      } else {
        messageList = null;
      }
      notifyListeners();
    });
  }

  void sendMessage(String chatRoomID,) {
    String userID = _apply.getLoggedInUser();
    _apply.uploadMessage(chatRoomID, MessageVO(DateTime.now().millisecondsSinceEpoch.toString(), userID, messageController.text, null, null, FieldValue.serverTimestamp().toString()));
    messageController.clear();
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
    getMessageController.dispose();
  }
}