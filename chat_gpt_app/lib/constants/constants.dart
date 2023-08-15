
import 'dart:core';

import 'package:flutter/material.dart';

import '../widgets/text_widget.dart';


Color scaffoldBackgroundColor = const Color(0xFF343541);
Color cardColor = const Color(0xFF444654);

List<String> models = [
  "Model 1",
  "Model 2",
  "Model 3",
  "Model 4",
  "Model 5",
  "Model 6",
];

List<DropdownMenuItem<String>>? get getModelsItem{
  List<DropdownMenuItem<String>>? modelsItems =
  List<DropdownMenuItem<String>>.generate(
    models.length,
        (index) => DropdownMenuItem(value: models[index],
          child: TextWidget(label: models[index], fontSize: 15,),
        ),
  );
  return modelsItems;
}



final chatMessages = [
  {
    "msg": "Hello, who are you ?",
    "chatIndex": 0,
  },
  {
    "msg":"Hello, I am ChatGPT, a large language model developed by OpenAI. I am here to assist you ?",
    "chatIndex": 1,
  },
  {
    "msg":"What is flutter?",
    "chatIndex": 0,
  },
  {
    "msg":"Flutter is an open-source UI software development kit created by Google. It is used to develop cross platform applications for Android, iOS, Linux, Mac, Windows, Google Fuchsia, and the web from a single codebase.",
    "chatIndex": 1,
  },
  {
    "msg" : "Okay, thanks",
    "chatIndex": 0,
  },
  {
    "msg" : "You are welcome",
    "chatIndex": 1,
  }

];