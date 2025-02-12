import 'package:chat_app_ai/utils/app_constants.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatServices {
  late  ChatSession _chatSession;

  final model = GenerativeModel(
    model: 'gemini-pro',
    apiKey: AppConstants.apiKey,
  );

  void startChatSession() {
    _chatSession = model.startChat();
  }

  Future<String?> sendMessage(String message) async {
    late final Content content;
    content = Content.text(message);
    final response = await _chatSession.sendMessage(content);
    return response.text;
  }
}
