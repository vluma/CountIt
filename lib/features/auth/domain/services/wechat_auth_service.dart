import 'package:flutter_riverpod/flutter_riverpod.dart';

final weChatAuthProvider = Provider<WeChatAuthService>((ref) {
  return WeChatAuthService();
});

class WeChatAuthService {
  bool _isInstalled = false;

  Future<bool> get isWeChatInstalled async {
    _isInstalled = true;
    return _isInstalled;
  }

  Future<void> initWeChat() async {
  }

  Future<String?> loginWithWeChat() async {
    final installed = await isWeChatInstalled;
    if (!installed) {
      throw Exception('未安装微信应用');
    }

    try {
      await Future.delayed(const Duration(seconds: 1));
      return 'mock_wechat_code';
    } catch (e) {
      throw Exception('微信登录失败: $e');
    }
  }
}
