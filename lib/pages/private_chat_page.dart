import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myanmar_educational/bloc/private_chat_page_bloc.dart';
import 'package:myanmar_educational/constant/colors.dart';
import 'package:myanmar_educational/constant/dimens.dart';
import 'package:myanmar_educational/constant/strings.dart';
import 'package:myanmar_educational/data/vos/message_vo/message_vo.dart';
import 'package:myanmar_educational/data/vos/teacher_vo/teacher_vo.dart';
import 'package:myanmar_educational/widgets/chatting_text_box.dart';
import 'package:myanmar_educational/widgets/easy_text_widget.dart';
import 'package:myanmar_educational/widgets/vertical_spacing_widget.dart';
import 'package:provider/provider.dart';

import '../data/vos/student_vo/student_vo.dart';

class PrivateChatPage extends StatelessWidget {
  final String name;
  final String chatRoomID;
  final String senderID;
  const PrivateChatPage({super.key, required this.chatRoomID, required this.senderID, required this.name, });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PrivateChatPageBloc>(
      create: (_) => PrivateChatPageBloc(chatRoomID),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: k25px,),
          ),
          centerTitle: true,
          title: EasyTextWidget(text: name, textColor: kWhite, textSize: k20px, fontWeight: FontWeight.w900),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(k20px),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Selector<PrivateChatPageBloc, List<MessageVO>?>(
                  selector: (_, bloc) => bloc.getMessageList,
                  builder: (_, messageList, child) => ListView.separated(
                    reverse: false,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return  Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: (senderID == (messageList?[index].senderID ?? '')) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                        children: [
                          Container(
                            // width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(vertical: k5px, horizontal: k10px),
                            decoration: BoxDecoration(
                                color: (senderID == (messageList?[index].senderID ?? '')) ? kWhite : kSecondaryColor,
                                borderRadius: const  BorderRadius.all(Radius.circular(k20px))
                            ),
                            child: EasyTextWidget(text: messageList?[index].message ?? '', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                          )
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => const VerticalSpacingWidget(h: k15px),
                    itemCount: messageList?.length ?? 0,
                  ),
                ),
              ),
              Selector<PrivateChatPageBloc, TextEditingController>(
                selector: (_, bloc) => bloc.getMessageController,
                builder: (_, messageController, child) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ChattingTextBox(controller: messageController, textInputType: TextInputType.text, textInputAction: TextInputAction.send, hintText: 'Enter message here...'),
                      ),
                      SendButton(chatRoomID: chatRoomID)
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}

class SendButton extends StatelessWidget {
  final String chatRoomID;
  const SendButton({super.key, required this.chatRoomID});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.send, color: kWhite,),
      onPressed: () async {
        context.read<PrivateChatPageBloc>().sendMessage(chatRoomID);
      },
    );
  }
}

