import 'package:chat_app_ai/chat_cubit/chat_cubit.dart';
import 'package:chat_app_ai/utils/app_theme.dart';
import 'package:chat_app_ai/views/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.themeData,
        home: ChatPage(),
      ),
    );
  }
}
