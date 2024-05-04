import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myanmar_educational/bloc/manage_enroll_request_page_bloc.dart';
import 'package:myanmar_educational/data/vos/request_vo/request_vo.dart';
import 'package:myanmar_educational/widgets/horizontal_spacing_widget.dart';
import 'package:myanmar_educational/widgets/vertical_spacing_widget.dart';
import 'package:provider/provider.dart';

import '../constant/colors.dart';
import '../constant/dimens.dart';
import '../constant/strings.dart';
import '../widgets/easy_text_widget.dart';

class ManageEnrollRequestPage extends StatelessWidget {
  const ManageEnrollRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ManageEnrollRequestPageBloc>(
      create: (_) => ManageEnrollRequestPageBloc(),
      child: Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: k25px,),
          ),
          centerTitle: true,
          title: EasyTextWidget(text: kAppName, textColor: kWhite, textSize: k20px, fontWeight: FontWeight.w900),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(k20px),
          child: Selector<ManageEnrollRequestPageBloc, List<RequestVO>?>(
            selector: (_, bloc) => bloc.getRequestList,
            builder: (_, requestList, child) => (requestList != null) ? ListView.separated(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => Card(
                  shadowColor: Colors.grey,
                  elevation: k20px,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(k20px)
                  ),
                  child: ListTile(
                    tileColor: kPrimaryColor,
                    contentPadding: const EdgeInsets.all(k20px),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(k20px)
                    ),
                    leading: ClipOval(
                      child: SizedBox.fromSize(
                          size: const Size.fromRadius(k25px),
                          child: Image.network(requestList[index].studentProfile ?? '', fit: BoxFit.cover, loadingBuilder: (context, child, loadingProgress){
                            if(loadingProgress == null){
                              return child;
                            } else {
                              return Center(
                                child: CircularProgressIndicator(color: kPrimaryColor),
                              );
                            }
                          },)
                      ),
                    ),
                    title: Text("Name - ${requestList[index].studentName}"),
                    titleTextStyle: GoogleFonts.lato(textStyle: TextStyle(color: kWhite, fontSize: k15px)),
                    subtitle: Text("Pending - ${requestList[index].courseName ?? ''}"),
                    subtitleTextStyle: GoogleFonts.lato(textStyle: TextStyle(color: kWhite, fontSize:12)),
                    trailing: ApproveButtonView(request: requestList[index]),
                  ),
                ),
                separatorBuilder: (context, index) => const VerticalSpacingWidget(h: k15px),
                itemCount: requestList.length
            ) : Center(child: EasyTextWidget(text: 'There is no enroll request', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),)
          )
        ),
      ),
    );
  }
}

class ApproveButtonView extends StatelessWidget {
  final RequestVO request;
  const ApproveButtonView({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: (){
          context.read<ManageEnrollRequestPageBloc>().approveRequest(request);
        },
        child: Text("APPROVE", style: GoogleFonts.gabriela(textStyle: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.normal)),)
    );
  }
}

