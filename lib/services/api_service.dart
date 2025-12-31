import 'package:dio/dio.dart';
import 'user_service.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.1.221:8888';
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {
      'Content-Type': 'application/json',
    },
  ));

  // 发送验证码
  static Future<void> sendVerificationCode(String email) async {
    try {
      final response = await _dio.post(
        '/appUser/sendVerifyCode',
        data: {'email': email},
      );
      
      // 检查响应体中的code字段（增强空安全和类型检查）
      if (response.data != null && response.data is Map) {
        final code = response.data['code'];
        if (code != null && code != 0) {
          final errorMessage = response.data['msg'] ?? '发送验证码失败';
          throw Exception(errorMessage);
        }
      } else {
        throw Exception('无效的响应格式');
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data?['msg'] ?? e.response?.data?['error'] ?? '发送验证码失败';
      throw Exception(errorMessage);
    } catch (e) {
      // 捕获所有其他异常
      throw Exception('发送验证码失败: ${e.toString()}');
    }
  }

  // 用户注册
  static Future<Map<String, dynamic>> register(String email, String password, String verifyCode) async {
    try {
      final response = await _dio.post(
        '/appUser/register',
        data: {
          'email': email,
          'password': password,
          'verifyCode': verifyCode,
        },
      );
      
      // 检查响应体中的code字段（增强空安全和类型检查）
      if (response.data != null && response.data is Map) {
        final code = response.data['code'];
        if (code != null && code != 0) {
          final errorMessage = response.data['msg'] ?? '注册失败';
          throw Exception(errorMessage);
        }
        
        // 获取用户信息并保存
        final userInfo = response.data['data'] as Map<String, dynamic>? ?? {};
        await UserService.saveUserInfo(userInfo);
        return userInfo;
      } else {
        throw Exception('无效的响应格式');
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data?['msg'] ?? e.response?.data?['error'] ?? '注册失败';
      throw Exception(errorMessage);
    } catch (e) {
      // 捕获所有其他异常
      throw Exception('注册失败: ${e.toString()}');
    }
  }

  // 用户登录
  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/appUser/login',
        data: {
          'Account': email,
          'Password': password,
        },
      );
      
      // 检查响应体中的code字段
      if (response.data != null && response.data is Map) {
        final code = response.data['code'];
        if (code != null && code != 0) {
          final errorMessage = response.data['msg'] ?? '登录失败';
          throw Exception(errorMessage);
        }
        
        // 获取用户信息并保存
        final userInfo = response.data['data'] as Map<String, dynamic>? ?? {};
        await UserService.saveUserInfo(userInfo);
        return userInfo;
      } else {
        throw Exception('无效的响应格式');
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data?['msg'] ?? e.response?.data?['error'] ?? '登录失败';
      throw Exception(errorMessage);
    } catch (e) {
      // 捕获所有其他异常
      throw Exception('登录失败: ${e.toString()}');
    }
  }
}
