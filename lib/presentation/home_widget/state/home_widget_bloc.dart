import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:home_widget/domain/repository/home_widget_repository.dart';

part 'home_widget_bloc.freezed.dart';
part 'home_widget_event.dart';
part 'home_widget_state.dart';

@injectable
class HomeWidgetBloc extends Bloc<HomeWidgetEvent, HomeWidgetState> {
  final HomeWidgetRepository _repository;

  HomeWidgetBloc(this._repository) : super(const HomeWidgetState()) {
    on<HomeWidgetActionPerformed>(_onActionPerformed);
    on<HomeWidgetActionReset>(_onActionReset);
    on<HomeWidgetAppResumed>(_onAppResumed);
  }

  Future<void> _onActionPerformed(
    HomeWidgetActionPerformed event,
    Emitter<HomeWidgetState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final success = await _repository.updateWidgetForAction();
    emit(state.copyWith(
      actionDone: success,
      isLoading: false,
    ));
  }

  Future<void> _onActionReset(
    HomeWidgetActionReset event,
    Emitter<HomeWidgetState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await _repository.resetWidget();
    emit(state.copyWith(
      actionDone: false,
      isLoading: false,
    ));
  }

  Future<void> _onAppResumed(
    HomeWidgetAppResumed event,
    Emitter<HomeWidgetState> emit,
  ) async {
    await _repository.recordAppAccess();
  }
}
