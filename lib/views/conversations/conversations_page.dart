import 'package:flutter/material.dart';
import 'package:flutter_base_app/views/conversations/bloc/conversations_cubit.dart';
import 'package:flutter_base_app/views/conversations/user_conversations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ConversationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: BlocProvider(
        create: (context) => ConversationsCubit(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Text(
                'Chats',
                style: textTheme.headline5,
              ),
              BlocBuilder<ConversationsCubit, ConversationsState>(
                builder: (conversationContext, state) {
                  if (state is ConversationsLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if(state is ConversationsIdle) {
                    return UserConversations(conversations: state.conversations);
                  } else if (state is ConversationsError) {
                    return Center(
                      child: Text(state.message.toString()),
                    );
                  } else if (state is ConversationsFatalError) {
                    return Center(
                      child: Text(state.message.toString()),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
