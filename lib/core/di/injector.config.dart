// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:home_widget/core/channels/home_widget_method_channel.dart'
    as _i598;
import 'package:home_widget/data/repository/home_widget_repository_impl.dart'
    as _i920;
import 'package:home_widget/domain/repository/home_widget_repository.dart'
    as _i413;
import 'package:home_widget/presentation/home_widget/state/home_widget_bloc.dart'
    as _i430;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i598.HomeWidgetMethodChannel>(
      () => _i598.HomeWidgetMethodChannel(),
    );
    gh.lazySingleton<_i413.HomeWidgetRepository>(
      () => _i920.HomeWidgetRepositoryImpl(gh<_i598.HomeWidgetMethodChannel>()),
    );
    gh.factory<_i430.HomeWidgetBloc>(
      () => _i430.HomeWidgetBloc(gh<_i413.HomeWidgetRepository>()),
    );
    return this;
  }
}
