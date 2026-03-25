import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class HomeWidgetMethodChannel {
  @visibleForTesting
  static const String channelName = 'com.example.home_widget/widget';

  final MethodChannel _channel = const MethodChannel(channelName);

  Future<bool> updateWidget({
    required bool actionDone,
    required String title,
    required String message,
    required String imageName,
  }) async {
    try {
      await _channel.invokeMethod<void>('updateWidget', {
        'action_done': actionDone,
        'widget_title': title,
        'widget_message': message,
        'widget_image_name': imageName,
      });
      return true;
    } on PlatformException catch (e) {
      debugPrint('[HomeWidget] updateWidget error: $e');
      return false;
    }
  }

  Future<bool> updateLastAccess() async {
    try {
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      await _channel.invokeMethod<void>('updateLastAccess', {
        'timestamp': timestamp,
      });
      return true;
    } on PlatformException catch (e) {
      debugPrint('[HomeWidget] updateLastAccess error: $e');
      return false;
    }
  }

  Future<bool> forceRefresh() async {
    try {
      await _channel.invokeMethod<void>('forceRefresh');
      return true;
    } on PlatformException catch (e) {
      debugPrint('[HomeWidget] forceRefresh error: $e');
      return false;
    }
  }
}
