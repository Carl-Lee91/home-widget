// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_widget_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HomeWidgetData _$HomeWidgetDataFromJson(Map<String, dynamic> json) =>
    _HomeWidgetData(
      actionDone: json['actionDone'] as bool? ?? false,
      widgetTitle: json['widgetTitle'] as String? ?? 'Welcome',
      widgetMessage:
          json['widgetMessage'] as String? ?? 'Open the app to get started',
      widgetImageName: json['widgetImageName'] as String? ?? 'default',
      lastAccessTimestamp: (json['lastAccessTimestamp'] as num?)?.toInt() ?? 0,
      inactivityThresholdMs:
          (json['inactivityThresholdMs'] as num?)?.toInt() ?? 60000,
    );

Map<String, dynamic> _$HomeWidgetDataToJson(_HomeWidgetData instance) =>
    <String, dynamic>{
      'actionDone': instance.actionDone,
      'widgetTitle': instance.widgetTitle,
      'widgetMessage': instance.widgetMessage,
      'widgetImageName': instance.widgetImageName,
      'lastAccessTimestamp': instance.lastAccessTimestamp,
      'inactivityThresholdMs': instance.inactivityThresholdMs,
    };
