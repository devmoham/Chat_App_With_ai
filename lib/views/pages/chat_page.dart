import 'package:chat_app_ai/chat_cubit/chat_cubit.dart';
import 'package:chat_app_ai/views/widgets/drawer_widget.dart';
import 'package:chat_app_ai/views/widgets/message_item_widget.dart';
import 'package:flutter/cupertino.dart';
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

  // void showOptions() {
  //   showCupertinoModalPopup(
  //     context: context,
  //     builder: (_) {
  //       return CupertinoActionSheet(
  //         actions: [
  //           CupertinoActionSheetAction(
  //             onPressed: () {
  //               Navigator.pop(context);
  //               BlocProvider.of<ChatCubit>(context).pickFromCamera();
  //             },
  //             child: const Text('Camera'),
  //           ),
  //           CupertinoActionSheetAction(
  //             onPressed: () {
  //               Navigator.pop(context);
  //               BlocProvider.of<ChatCubit>(context).pickFromGallery();
  //             },
  //             child: const Text('Gallery'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  void showBottomSheetOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 120,
        width: double.infinity,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 70,
                    width: 110,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: IconButton(
                          onPressed: () {}, icon: Icon(Icons.attachment)),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text('Document'),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 70,
                    width: 110,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                            BlocProvider.of<ChatCubit>(context)
                                .pickImageFromGallery();
                          },
                          icon: Icon(Icons.image)),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text('Image OCR'),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 70,
                    width: 110,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                            BlocProvider.of<ChatCubit>(context)
                                .pickImageFromCamera();
                          },
                          icon: Icon(Icons.camera_alt)),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text('Photo OCR'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    BlocProvider.of<ChatCubit>(context).startChattingSession();

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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chat with Ai',
        ),
        centerTitle: true,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          CircleAvatar(
            radius: 22,
            backgroundImage: AssetImage(
              'assets/images/mo2.jpg',
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      drawer: Drawer(),
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
                      return Center(
                        child: ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [
                              Colors.blue,
                              Colors.purple,
                              Colors.pinkAccent
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(
                            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                          ),
                          child: Text(
                            'Hello, Mohamed',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<ChatCubit, ChatState>(
                    bloc: chatCubit,
                    buildWhen: (previous, current) =>
                        current is ImagePicked || current is ImageRemoved,
                    builder: (_, state) {
                      if (state is ImagePicked) {
                        return SizedBox(
                          height: 200.0,
                          width: size.width - 75,
                          child: Card(
                            color: Colors.white,
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16.0),
                                    child: Image.file(
                                      state.image,
                                      width: size.width - 100,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 5,
                                  right: 5,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: InkWell(
                                      onTap: () => chatCubit.removeImage(),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Icon(Icons.close),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Expanded(
                        child: Scrollbar(
                          controller:
                              _textFieldScrollController, // Attach Controller
                          thumbVisibility:
                              true, // Make scrollbar always visible
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
                                  suffix: InkWell(
                                    child: const Icon(Icons.attachment),
                                    onTap: () {
                                      // showOptions();
                                      showBottomSheetOptions();
                                    },
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 16),

                                  border:
                                      InputBorder.none, // Remove default border
                                ),
                                onSubmitted: (value) {
                                  chatCubit.sendMessage(value);
                                  _messageController.clear();
                                  chatCubit.removeImage();
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
                            current is SendingMessageFailed ||
                            current is ChatSuccess,
                        listener: (context, state) {
                          if (state is SendingMessageFailed) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.error)));
                          } else if (state is ChatSuccess) {
                            _scrollDown();
                          }
                        },
                        buildWhen: (previous, current) =>
                            current is SendingMessage ||
                            current is MessageSent ||
                            current is SendingMessageFailed,
                        builder: (context, state) {
                          if (state is SendingMessage) {
                            return CircularProgressIndicator.adaptive();
                          }
                          return IconButton(
                            icon: Icon(Icons.send),
                            onPressed: () {
                              chatCubit.sendMessage(_messageController.text);
                              _messageController.clear();
                              chatCubit.removeImage();
                              _scrollDown();
                              FocusScope.of(context).unfocus();
                            },
                          );
                        },
                      ),
                    ],
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
