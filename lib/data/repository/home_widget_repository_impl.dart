import 'package:injectable/injectable.dart';

import 'package:home_widget/core/channels/home_widget_method_channel.dart';
import 'package:home_widget/domain/repository/home_widget_repository.dart';

@LazySingleton(as: HomeWidgetRepository)
class HomeWidgetRepositoryImpl implements HomeWidgetRepository {
  final HomeWidgetMethodChannel _channel;

  HomeWidgetRepositoryImpl(this._channel);

  @override
  Future<bool> updateWidgetForAction() async {
    return _channel.updateWidget(
      actionDone: true,
      title: 'Action Complete!',
      message: 'You did it!',
      imageName: 'action_done',
    );
  }

  @override
  Future<bool> resetWidget() async {
    return _channel.updateWidget(
      actionDone: false,
      title: 'Welcome',
      message: 'Open the app to get started',
      imageName: 'default',
    );
  }

  @override
  Future<bool> recordAppAccess() async {
    return _channel.updateLastAccess();
  }
}
