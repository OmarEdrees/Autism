import 'package:autism/logic/cubit/chat/chat_cubit.dart';
import 'package:autism/logic/models/chat_model.dart';
import 'package:autism/logic/services/colors_app.dart';
import 'package:autism/logic/services/sized_config.dart';
import 'package:autism/presentation/widgets/chat/chat_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.chatModel});
  final ChatModel chatModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(chatModel: chatModel),
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              foregroundColor: ColorsApp().primaryColor,
              backgroundColor: Colors.white,
              titleSpacing: 0,
              title: Row(
                children: [
                  CircleAvatar(
                      backgroundImage:
                          NetworkImage(chatModel.chatPartnerImage!)),
                  SizedBox(width: SizeConfig.width * 0.04),
                ],
              ),
            ),
            body: ChatScreenBody(chatModel: chatModel),
          );
        },
      ),
    );
  }
}
