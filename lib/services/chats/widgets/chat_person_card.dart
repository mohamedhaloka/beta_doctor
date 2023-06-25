import 'package:flutter/material.dart';

import '../../../routers/routers.dart';
import '../../../utilities/theme/text_styles.dart';
import '../model/chat_model.dart';

class ChatPersonCard extends StatelessWidget {
  final ChatModel chat;
  const ChatPersonCard(this.chat, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.chatRoom, arguments: [
          chat,
          chat.doctorId,
        ]);
      },
      child: Column(
        children: [
          const SizedBox(height: 16),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(chat.patentPhoto),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(chat.patentName,
                          style: AppTextStyles.w500.copyWith(fontSize: 16)),
                      const SizedBox(height: 4),
                      Text(chat.lastMessage,
                          style: AppTextStyles.w500.copyWith(
                              fontSize: 14,
                              color: Theme.of(context).hintColor)),
                    ],
                  ),
                ),
                Text(
                  chat.lastMessageDate,
                  style: AppTextStyles.w500.copyWith(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.primary),
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          Divider(
            height: 0,
            color: Theme.of(context).dividerColor,
          ),
        ],
      ),
    );
  }
}
