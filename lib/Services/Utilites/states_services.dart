import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../../Model/world_state_model.dart';
import 'app_url.dart';

class StateServices{
  Future<WorldStatesModel> fetchWorldStateModel() async{
    final response = await http.get(Uri.parse(AppUrl.baseUrl));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);
    }else{
      throw Exception("404 : Error");
    }
  }

  Future<List<Map<String, dynamic>>> cityListApi() async{
    final response = await http.get(Uri.parse(AppUrl.baseUrl));
    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      final dataList = data['data']['regional'];
      return dataList.cast<Map<String, dynamic>>();
    }
    else{
      throw Exception("404 : Error");
    }
  }
}