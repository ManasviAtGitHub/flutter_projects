import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../models/models_model.dart';
import '../services/api_service.dart';

class ModelsProvider with ChangeNotifier{
  List<ModelsModel> modelsList = [];

  String currentModel = "text-davinci-001";
  List<ModelsModel> get getModelsList => modelsList;

  String get getCurrentModel => currentModel;

  void setCurrentModel(String value) {
    currentModel = value;
    notifyListeners();
  }

  List<ModelsModel> get getModesList => modelsList;

  Future<List<ModelsModel>> getAllModels() async{
    modelsList = await ApiService.getModels();
    return modelsList;
  }

}