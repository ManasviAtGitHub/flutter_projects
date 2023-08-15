
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:voice_assistant/constants/api_constants.dart';
class ApiService{
  final List<Map<String, String>> messages = [];

  Future<String> isArtPromptAPI(String prompt) async{
    debugPrint("isArtPromptAPI prompt : $prompt");
    try {
      final result = await http.post(
        Uri.parse("$BASE_URL/chat/completions"),
        headers: {
          'Content-Type' : 'application/json',
          'Authorization': 'Bearer $API_KEY',
        },
        body: jsonEncode({
          "model" : "gpt-3.5-turbo",
          "messages" : [
            {
              "role" : "user",
              "content" : 'Does this message want to generate an AI picture, image, art or anything similar? "$prompt" . Simply answer with a yes or no.',
            }
          ],
        }),
      );
      print(result.body);
      if(result.statusCode == 200){
        String content = jsonDecode(result.body)['choices'][0]['message']['content'];
        content = content.trim();
        debugPrint("isArtPromptAPI content : ${content[0]}");
        if(content[0].toLowerCase() == 'y'){
          final result = await dallEAPI(prompt);
          return result;
        }else{
          final result = await chatGPTAPI(prompt);
          return result;
        }
      }

      return 'An internal error occurred';


    }catch(e){
      return e.toString();
    }
  }
  Future<String> chatGPTAPI(String prompt) async{
    debugPrint("chatGPTAPI prompt : $prompt");
    messages.add({"role": 'user', "content": prompt});

    try{
      final result = await http.post(
        Uri.parse("$BASE_URL/chat/completions"),
        headers: {
          'Content-Type' : 'application/json',
          'Authorization' : 'Bearer $API_KEY',
        },
        body : jsonEncode({
          "model" : "gpt-3.5-turbo",
          "messages" : messages,
        }),
      );

      if(result.statusCode == 200){
        String content = jsonDecode(result.body)['choices'][0]['message']['content'];
        content = content.trim();
        messages.add({"role": 'assistant', "content": content});
        return content;
      }
      return 'An internal error occurred';
    }
    catch(e){
      return e.toString();
    }
  }
  Future<String> dallEAPI(String prompt) async{
    debugPrint("dallEAPI prompt : $prompt");
    messages.add({"role": 'user', "content": prompt});
    try{
      final result = await http.post(
        Uri.parse("$BASE_URL/images/generations"),
        headers: {
          'Content-Type' : 'application/json',
          'Authorization' : 'Bearer $API_KEY',
        },
        body : jsonEncode({
          "prompt" : prompt,
          "n" : 1,
        }),
      );

      if(result.statusCode == 200){
        String imageUrl = jsonDecode(result.body)['data'][0]['url'];
        imageUrl = imageUrl.trim();
        messages.add({"role": 'assistant', "content": imageUrl});
        return imageUrl;
      }
      return 'An internal error occurred';

    }catch(e){
      return e.toString();
    }
  }
}