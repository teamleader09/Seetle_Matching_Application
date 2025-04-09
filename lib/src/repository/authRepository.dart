import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seetle/src/model/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  String? _uid;
  String? get uid => _uid;

  set setUid(String str) {
    this._uid = str;
  }

  Future<bool> registerData(String userName, String birthday, String nickName, String password, String imageName,String base64Image, String email, String phone) async {
    final data = await DioClient.postRegister(userName, birthday, nickName, password, imageName, base64Image, email, phone);
    var result = data['status'];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uId = data['user']['id'];
    if (result == 'success') {
      await prefs.setString("uId", uId.toString());
      return true;
    } 
    return false;
  }

  Future<bool> compareNickname(String nickName) async {
    final data = await DioClient.postCompareNickname(nickName);
  
    var result = data['status'];
    if (result == 'success') {
      return true;
    } 
    return false;
  }

  Future<bool> loginAction(String emailOrNumber) async {
    final data = await DioClient.postLoginAction(emailOrNumber);
  
    var result = data['status'];
    if (result == 'success') {
      return true;
    } 
    return false;
  }

  Future<bool> loginWithPassword(String emailOrNumber, String password) async {
    final data = await DioClient.loginWithPassword(emailOrNumber, password);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = data['status'];
    if (result == 'success') {
      var uId = data['user']['id'];
      await prefs.setString("uId", uId.toString());
      return true;
    } else {
      return false;
    }
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});
