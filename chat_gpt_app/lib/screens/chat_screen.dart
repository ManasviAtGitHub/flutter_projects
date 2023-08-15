import 'package:chat_gpt_app/constants/constants.dart';
import 'package:chat_gpt_app/providers/chats_provider.dart';
import 'package:chat_gpt_app/services/asset_manager.dart';
import 'package:chat_gpt_app/widgets/chat_widget.dart';
import 'package:chat_gpt_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../models/chat_model.dart';
import '../providers/models_provider.dart';
import '../services/api_service.dart';
import '../services/services.dart';
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  bool _isTyping = false;
  late TextEditingController textEditingController;
  late ScrollController scrollController;
  late FocusNode focusNode;
  @override
  void initState() {
    // TODO: implement initState
    scrollController = ScrollController();
    textEditingController = TextEditingController();
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    scrollController.dispose();
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  // List<ChatModel> chatList = [];

  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context);
    final chatsProvider = Provider.of<ChatsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetsManager.logoImage),
        ),
        title: const Text("ChatGPT"),
        actions: [
          IconButton(
            onPressed: () async{

             await Services.showModalSheet(context: context);
            },
            icon: const Icon(Icons.more_vert_rounded, color: Colors.white,),
          )
        ],

      ),
      body: SafeArea(
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                    controller: scrollController,
                    // itemCount: chatList.length,
                    itemCount: chatsProvider.getChatList.length,
                    itemBuilder: (context, index){
                      return ChatWidget(
                        // msg : chatList[index].message,
                        // chatIndex: chatList[index].chatIndex,
                        msg : chatsProvider.getChatList[index].message,
                        chatIndex: chatsProvider.getChatList[index].chatIndex,
                      );
                    }
                ),
              ),

              if(_isTyping) ...[
                const SpinKitThreeBounce(
                  color: Colors.white,
                  size: 18.0,
                ),],
                SizedBox(height: 15,),
                Material(
                  color : cardColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child : TextField(
                            focusNode: focusNode,
                            style: const TextStyle(color: Colors.white),
                            controller: textEditingController,
                            onSubmitted: (value) async{
                              await sendMessageFCT(modelsProvider: modelsProvider, chatProvider: chatsProvider);
                            },
                            decoration: const InputDecoration.collapsed(hintText: "How can I help you?", hintStyle: TextStyle(color: Colors.white)),
                          )
                        ),

                        IconButton(
                          onPressed: () async{

                            await sendMessageFCT(modelsProvider: modelsProvider, chatProvider: chatsProvider);

                          },
                          icon: const Icon(Icons.send, color: Colors.white,),
                        )
                      ],
                    ),
                  ),
                )
            ],
          )
      ),
    );
  }

  Future<void> sendMessageFCT({required ModelsProvider modelsProvider, required ChatsProvider chatProvider}) async{
    if(_isTyping){

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: TextWidget( label: "Please wait for the previous message to be sent"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        )
      );
      return;
    }
    if(textEditingController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: TextWidget( label: "Please enter a message"),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          )
      );
      return;
    }

    try{
      String msg = textEditingController.text;
      setState(() {
        _isTyping = true;
        // chatList.add(ChatModel(message: textEditingController.text, chatIndex: 0));
        chatProvider.addUserMessage(msg: msg);
        textEditingController.clear();
        focusNode.unfocus();
      });
      await chatProvider.sendMessageAndGetAnswers(msg: msg, chosenModelId: modelsProvider.getCurrentModel);
      // chatList.addAll(await ApiService.sendMessage(
      //     message: textEditingController.text,
      //     modelId: modelsProvider.getCurrentModel
      // ));
      setState(() {});
    }catch(e){
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: TextWidget( label: e.toString()),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
          )
      );
    }finally{
      setState(() {
        scrollToEnd();
        _isTyping = false;
      });
    }
  }

  void scrollToEnd(){
    scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(seconds: 2), curve: Curves.easeOut);
  }

}
