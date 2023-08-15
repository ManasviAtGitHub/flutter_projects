import 'package:flutter/cupertino.dart';

import '../models/chat_model.dart';
import '../services/api_service.dart';

class ChatsProvider extends ChangeNotifier{

  List<ChatModel> chatList = [];
  
  List<ChatModel> get getChatList => chatList;
  
  void addUserMessage({required String msg}){
    chatList.add(ChatModel(message: msg, chatIndex: 0));
    notifyListeners();
  }

  Future<void> sendMessageAndGetAnswers({required String msg, required String chosenModelId}) async{
    chatList.addAll(await ApiService.sendMessage(message: msg, modelId: chosenModelId));
    notifyListeners();
  }
}