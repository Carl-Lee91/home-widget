part of 'home_widget_bloc.dart';

@freezed
sealed class HomeWidgetEvent with _$HomeWidgetEvent {
  const factory HomeWidgetEvent.actionPerformed() = HomeWidgetActionPerformed;
  const factory HomeWidgetEvent.actionReset() = HomeWidgetActionReset;
  const factory HomeWidgetEvent.appResumed() = HomeWidgetAppResumed;
}
