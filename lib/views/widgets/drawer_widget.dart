// import 'package:chat_app_ai/chat_cubit/chat_cubit.dart';
// import 'package:chat_app_ai/utils/app_constants.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';

// class DrawerWidget extends StatelessWidget {
//   const DrawerWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ChatCubit, ChatState>(
//       builder: (context, state) {
//         return Drawer(
//           child: Column(
//             children: [
//               UserAccountsDrawerHeader(
//                 decoration: BoxDecoration(color: Colors.purple.shade300),
//                 currentAccountPicture: const CircleAvatar(
//                   backgroundImage: AssetImage('assets/images/mo2.jpg'),
//                 ),
//                 accountName: const Text('Mohamed Mostafa'),
//                 accountEmail: const Text('Chat History'),
//               ),
             
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: state.history.length,
//                     itemBuilder: (context, sessionIndex) {
//                       final session = state.history[sessionIndex];
//                       if (session.isEmpty) return const SizedBox.shrink();
                      
//                       // Get the first message of the session for preview
//                       final firstMessage = session.first;
//                       final dateStr = DateFormat('MMM dd, yyyy HH:mm')
//                           .format(firstMessage.time);
                      
//                       return ListTile(
//                         leading: const Icon(Icons.history),
//                         title: Text(
//                           firstMessage.text.length > 30
//                               ? '${firstMessage.text.substring(0, 30)}...'
//                               : firstMessage.text,
//                           style: const TextStyle(fontSize: 14),
//                         ),
//                         subtitle: Text(
//                           dateStr,
//                           style: const TextStyle(fontSize: 12),
//                         ),
//                         onTap: () {
//                           // Load this session
//                           Navigator.pop(context);
//                         },
//                       );
//                     },
//                   ),
//                 ),
//               ] else ...[
//                 const Expanded(
//                   child: Center(
//                     child: Text('No chat history available'),
//                   ),
//                 ),
//               ],
//               const Divider(),
//               ListTile(
//                 leading: const Icon(Icons.add),
//                 title: const Text('New Chat'),
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
