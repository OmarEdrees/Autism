import 'package:autism/logic/cubit/chat/chat_cubit.dart';
import 'package:autism/logic/services/colors_app.dart';
import 'package:autism/logic/services/sized_config.dart';
import 'package:flutter/material.dart';

class SendMessage extends StatelessWidget {
  const SendMessage({super.key, required this.cubit});
  final ChatCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.height * 0.1,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width * 0.03,
          vertical: SizeConfig.height * 0.01,
        ),
        child: TextFormField(
          controller: cubit.messageController,
          decoration: InputDecoration(
            hintText: "enter your message",
            suffixIcon: IconButton(
              icon: Icon(Icons.send, color: ColorsApp().primaryColor),
              onPressed: () {
                cubit.addMessage(text: cubit.messageController.text);
              },
            ),
          ),
        ),
      ),
    );
  }
}
