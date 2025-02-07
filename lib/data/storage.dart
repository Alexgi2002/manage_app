// ignore_for_file: constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static Storage? _instance;
  
  Storage._();

  late SharedPreferences data;
  
  static Storage get instance{
    _instance??=  Storage._();
		return _instance!;
  }

  Future<void> init() async {
    data = await SharedPreferences.getInstance();
  }

  int getId(){
    return data.getInt("id") ?? -1;
  }
  void setId(int value){
    data.setInt("id", value);
  }


  int getStock(){
    return data.getInt("stock") ?? -1;
  }

  void setStock(int value){
    data.setInt("stock", value);
  }

}