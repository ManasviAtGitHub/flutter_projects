import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:voice_assistant/constants/strings.dart';
import 'package:voice_assistant/services/api_service.dart';
import 'package:voice_assistant/services/assets_manager.dart';

import '../constants/pallete.dart';
import '../widgets/feature_box.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final speechToText = SpeechToText();
  final flutterTts = FlutterTts();
  String lastWords = '';
  final ApiService apiService = ApiService();
  String? generatedContent, generatedImageUrl;
  int start = 200, delay = 200;

  Future<void> initTextToSpeech() async{
    await flutterTts.setSharedInstance(true);
    setState(() {});
  }
  Future<void> initSpeechToText() async{
    await speechToText.initialize();
    setState(() {});
  }
  Future<void> systemSpeak(String content) async{
    await flutterTts.speak(content);
  }

  void onSpeechResult(SpeechRecognitionResult result){

    setState(() {
      lastWords = result.recognizedWords;
      debugPrint("lastWords : $lastWords");
    });
  }

  Future<void> startListening() async{
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }
  Future<void> stopListening() async{
    await speechToText.stop();
    setState(() {});
  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSpeechToText();
    initTextToSpeech();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    speechToText.stop();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BounceInDown(child: const Text("Auora")),
        leading: const Icon(Icons.menu),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            ZoomIn(
              child:Stack(
                children: [
                  Center(
                    child:Container(
                      height : 120,
                      width : 120,
                      decoration : const BoxDecoration(
                        color: Pallete.assistantCircleColor,
                        shape: BoxShape.circle,
                      )
                    )
                  ),
                  Container(
                    height : 125,
                    decoration: BoxDecoration(
                      shape : BoxShape.circle,
                      image : DecorationImage(
                        image : AssetImage(AssetsManager.virtualAssistant),
                      ),
                    ),
                  )
                ],
              )
            ),
            FadeInRight(
              child : Visibility(
                visible: generatedImageUrl == null,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical:10),
                  margin: const EdgeInsets.symmetric(horizontal :40).copyWith(top : 30),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Pallete.borderColor
                    ),
                    borderRadius: BorderRadius.circular(20).copyWith(
                      topLeft: Radius.zero,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      generatedContent == null ?
                          "Good Morning, what can I do for you?" :
                          generatedContent!,
                      style: TextStyle(
                        fontFamily: FONT_FAMILY,
                        color: Pallete.mainFontColor,
                        fontSize: generatedContent == null?25:18,
                      ),
                    )
                  ),
                ),
              ),
            ),
            if(generatedImageUrl != null)
              Padding(
                padding : const EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child : Image.network(generatedImageUrl!),
                ),
              ),

            if (lastWords.length>1)
            SlideInLeft(
                child : Visibility(
                    child : Container(
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(top:10, left:22),
                      child:Text(
                        "Prompt : $lastWords",
                        style: TextStyle(
                          fontFamily: FONT_FAMILY,
                          color: Pallete.mainFontColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                )
            ),

            SlideInLeft(
              child : Visibility(
                visible: generatedImageUrl == null && generatedContent == null,
                child : Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(top:10, left:22),
                  child:Text(
                    "Here are a few features",
                    style: TextStyle(
                      fontFamily: FONT_FAMILY,
                      color: Pallete.mainFontColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              )
            ),
            Visibility(
              visible: generatedImageUrl == null && generatedContent == null,
              child: Column(
                children: [
                  SlideInLeft(
                    delay: Duration(milliseconds: start),
                    child: const FeatureBox(
                      color : Pallete.firstSuggestionBoxColor,
                      headerText : "ChatGPT",
                      descriptionText : "Chat with an AI",
                    ),
                  ),
                  SlideInLeft(
                    delay: Duration(milliseconds: start + delay),
                    child: const FeatureBox(
                      color : Pallete.secondSuggestionBoxColor,
                      headerText : "Dall-E",
                      descriptionText : "Generate images from text",
                    ),
                  ),
                  SlideInLeft(
                    delay: Duration(milliseconds: start + 2 * delay),
                    child: const FeatureBox(
                      color : Pallete.thirdSuggestionBoxColor,
                      headerText : "Smart Voice Assistant",
                      descriptionText : "Get things done with your voice",
                    ),
                  ),

                ],
              )
            )
          ],
        ),

      ),
      floatingActionButton: ZoomIn(
        delay: Duration(milliseconds: start + 3 * delay),
        child: FloatingActionButton(
          backgroundColor: Pallete.firstSuggestionBoxColor,
          onPressed:() async{
            if(await speechToText.hasPermission && speechToText.isNotListening){
              await startListening();
            }
            else if(speechToText.isListening){
              final speech = await apiService.isArtPromptAPI(lastWords);
              debugPrint("************ Speech Results : $speech *************");
              if(speech.contains('https')){
                generatedImageUrl = speech;
                generatedContent = null;
                setState(() {});
              }
              else{
                generatedImageUrl = null;
                generatedContent = speech;
                setState(() {});
                await systemSpeak(speech);
              }
              await stopListening();
            } else{
              initSpeechToText();
            }
          },
          child: Icon(speechToText.isListening?Icons.stop:Icons.mic),
        ),
      ),
    );
  }
}
