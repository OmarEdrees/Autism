import 'package:autism/logic/cubit/chat/chat_cubit.dart';
import 'package:autism/logic/models/chat_model.dart';
import 'package:autism/logic/services/colors_app.dart';
import 'package:autism/presentation/widgets/chat/messages_list_view.dart';
import 'package:autism/presentation/widgets/chat/send_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreenBody extends StatelessWidget {
  const ChatScreenBody({
    super.key,
    required this.chatModel,
  });

  final ChatModel chatModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        final cubit = context.read<ChatCubit>();
        if (state is ChatLoading) {
          return CircularProgressIndicator(
            color: ColorsApp().primaryColor,
          );
        }
        if (state is ChatLoaded) {
          return Column(
            children: [
              MessagesListView(messages: state.messages,),
              SendMessage(cubit: cubit),
            ],
          );
        }
        return Container();
      },
    );
  }
}

