import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_app_ai/chat_cubit/chat_cubit.dart';
import 'package:chat_app_ai/views/widgets/message_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final TextEditingController _messageController;
  // late final AnimatedTextController myAnimatedTextController;
  late final ScrollController _scrollController;
  late final ScrollController
      _textFieldScrollController; // New Scroll Controller for TextField

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 700), curve: Curves.easeInOut));
  }

  @override
  void initState() {
    BlocProvider.of<ChatCubit>(context).startChatSession();
    _messageController = TextEditingController();
    // myAnimatedTextController = AnimatedTextController();
    _scrollController = ScrollController();
    _textFieldScrollController = ScrollController(); // Initialize Controller
    super.initState();
  }

  @override
  void dispose() {
    _messageController.dispose();
    // myAnimatedTextController.dispose();
    _scrollController.dispose();
    _textFieldScrollController.dispose(); // Dispose Controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatCubit = BlocProvider.of<ChatCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chat with Ai',
          // style: Theme.of(context)
          //     .textTheme
          //     .titleLarge!
          //     .copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<ChatCubit, ChatState>(
                  bloc: chatCubit,
                  buildWhen: (previous, current) => current is ChatSuccess,
                  builder: (context, state) {
                    if (state is ChatSuccess) {
                      final chatMessages = state.messages;
                      return ListView.separated(
                        controller: _scrollController,
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 8,
                          );
                        },
                        itemCount: chatMessages.length,
                        itemBuilder: (context, index) {
                          final message = chatMessages[index];
                          return MessageItemWidget(message: message);
                        },
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Scrollbar(
                      controller:
                          _textFieldScrollController, // Attach Controller
                      thumbVisibility: true, // Make scrollbar always visible
                      child: Container(
                        constraints: BoxConstraints(
                          maxHeight: 150, // Limit TextField height
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SingleChildScrollView(
                          controller:
                              _textFieldScrollController, // Scroll Controller
                          scrollDirection: Axis.vertical,
                          child: TextField(
                            controller: _messageController,
                            maxLines: null, // Allow multiple lines
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              hintText: 'Ask me anything...',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),

                              border: InputBorder.none, // Remove default border
                            ),
                            onSubmitted: (value) {
                              chatCubit.sendMessage(value);
                              _messageController.clear();
                              _scrollDown();
                              FocusScope.of(context).unfocus();
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  BlocConsumer<ChatCubit, ChatState>(
                    bloc: chatCubit,
                    listenWhen: (previous, current) =>
                        current is SendingMessageError ||
                        current is ChatSuccess,
                    listener: (context, state) {
                      if (state is SendingMessageError) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(state.error)));
                      } else if (state is ChatSuccess) {
                        _scrollDown();
                      }
                    },
                    buildWhen: (previous, current) =>
                        current is SendingMessage ||
                        current is MessageSent ||
                        current is SendingMessageError,
                    builder: (context, state) {
                      if (state is SendingMessage) {
                        return CircularProgressIndicator.adaptive();
                      }
                      return IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          chatCubit.sendMessage(_messageController.text);
                          _messageController.clear();
                          _scrollDown();
                          FocusScope.of(context).unfocus();
                        },
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
