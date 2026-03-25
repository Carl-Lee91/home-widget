part of 'home_widget_bloc.dart';

@freezed
sealed class HomeWidgetState with _$HomeWidgetState {
  const factory HomeWidgetState({
    @Default(false) bool actionDone,
    @Default(false) bool isLoading,
  }) = _HomeWidgetState;
}
