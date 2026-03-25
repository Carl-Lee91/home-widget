import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_widget_data.freezed.dart';
part 'home_widget_data.g.dart';

@freezed
sealed class HomeWidgetData with _$HomeWidgetData {
  const factory HomeWidgetData({
    @Default(false) bool actionDone,
    @Default('Welcome') String widgetTitle,
    @Default('Open the app to get started') String widgetMessage,
    @Default('default') String widgetImageName,
    @Default(0) int lastAccessTimestamp,
    @Default(60000) int inactivityThresholdMs,
  }) = _HomeWidgetData;

  factory HomeWidgetData.fromJson(Map<String, dynamic> json) =>
      _$HomeWidgetDataFromJson(json);
}
