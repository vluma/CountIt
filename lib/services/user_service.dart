import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static const String _userInfoKey = 'user_info';
  static const String _isLoggedInKey = 'is_logged_in';

  // 保存用户信息
  static Future<void> saveUserInfo(Map<String, dynamic> userInfo) async {
    final prefs = await SharedPreferences.getInstance();
    // 使用json.encode将用户信息转换为JSON字符串保存
    String userInfoString = json.encode(userInfo);
    await prefs.setString(_userInfoKey, userInfoString);
    await prefs.setBool(_isLoggedInKey, true);
  }

  // 获取用户信息
  static Future<Map<String, dynamic>?> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final userInfoString = prefs.getString(_userInfoKey);
    if (userInfoString == null) return null;

    // 使用json.decode将JSON字符串转换为Map
    try {
      return json.decode(userInfoString) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  // 检查用户是否已登录
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  // 清除用户信息（登出）
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userInfoKey);
    await prefs.setBool(_isLoggedInKey, false);
  }
}
