// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_widget_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeWidgetEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeWidgetEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeWidgetEvent()';
}


}

/// @nodoc
class $HomeWidgetEventCopyWith<$Res>  {
$HomeWidgetEventCopyWith(HomeWidgetEvent _, $Res Function(HomeWidgetEvent) __);
}


/// Adds pattern-matching-related methods to [HomeWidgetEvent].
extension HomeWidgetEventPatterns on HomeWidgetEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( HomeWidgetActionPerformed value)?  actionPerformed,TResult Function( HomeWidgetActionReset value)?  actionReset,TResult Function( HomeWidgetAppResumed value)?  appResumed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case HomeWidgetActionPerformed() when actionPerformed != null:
return actionPerformed(_that);case HomeWidgetActionReset() when actionReset != null:
return actionReset(_that);case HomeWidgetAppResumed() when appResumed != null:
return appResumed(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( HomeWidgetActionPerformed value)  actionPerformed,required TResult Function( HomeWidgetActionReset value)  actionReset,required TResult Function( HomeWidgetAppResumed value)  appResumed,}){
final _that = this;
switch (_that) {
case HomeWidgetActionPerformed():
return actionPerformed(_that);case HomeWidgetActionReset():
return actionReset(_that);case HomeWidgetAppResumed():
return appResumed(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( HomeWidgetActionPerformed value)?  actionPerformed,TResult? Function( HomeWidgetActionReset value)?  actionReset,TResult? Function( HomeWidgetAppResumed value)?  appResumed,}){
final _that = this;
switch (_that) {
case HomeWidgetActionPerformed() when actionPerformed != null:
return actionPerformed(_that);case HomeWidgetActionReset() when actionReset != null:
return actionReset(_that);case HomeWidgetAppResumed() when appResumed != null:
return appResumed(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  actionPerformed,TResult Function()?  actionReset,TResult Function()?  appResumed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case HomeWidgetActionPerformed() when actionPerformed != null:
return actionPerformed();case HomeWidgetActionReset() when actionReset != null:
return actionReset();case HomeWidgetAppResumed() when appResumed != null:
return appResumed();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  actionPerformed,required TResult Function()  actionReset,required TResult Function()  appResumed,}) {final _that = this;
switch (_that) {
case HomeWidgetActionPerformed():
return actionPerformed();case HomeWidgetActionReset():
return actionReset();case HomeWidgetAppResumed():
return appResumed();}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  actionPerformed,TResult? Function()?  actionReset,TResult? Function()?  appResumed,}) {final _that = this;
switch (_that) {
case HomeWidgetActionPerformed() when actionPerformed != null:
return actionPerformed();case HomeWidgetActionReset() when actionReset != null:
return actionReset();case HomeWidgetAppResumed() when appResumed != null:
return appResumed();case _:
  return null;

}
}

}

/// @nodoc


class HomeWidgetActionPerformed implements HomeWidgetEvent {
  const HomeWidgetActionPerformed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeWidgetActionPerformed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeWidgetEvent.actionPerformed()';
}


}




/// @nodoc


class HomeWidgetActionReset implements HomeWidgetEvent {
  const HomeWidgetActionReset();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeWidgetActionReset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeWidgetEvent.actionReset()';
}


}




/// @nodoc


class HomeWidgetAppResumed implements HomeWidgetEvent {
  const HomeWidgetAppResumed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeWidgetAppResumed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeWidgetEvent.appResumed()';
}


}




/// @nodoc
mixin _$HomeWidgetState {

 bool get actionDone; bool get isLoading;
/// Create a copy of HomeWidgetState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeWidgetStateCopyWith<HomeWidgetState> get copyWith => _$HomeWidgetStateCopyWithImpl<HomeWidgetState>(this as HomeWidgetState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeWidgetState&&(identical(other.actionDone, actionDone) || other.actionDone == actionDone)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,actionDone,isLoading);

@override
String toString() {
  return 'HomeWidgetState(actionDone: $actionDone, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class $HomeWidgetStateCopyWith<$Res>  {
  factory $HomeWidgetStateCopyWith(HomeWidgetState value, $Res Function(HomeWidgetState) _then) = _$HomeWidgetStateCopyWithImpl;
@useResult
$Res call({
 bool actionDone, bool isLoading
});




}
/// @nodoc
class _$HomeWidgetStateCopyWithImpl<$Res>
    implements $HomeWidgetStateCopyWith<$Res> {
  _$HomeWidgetStateCopyWithImpl(this._self, this._then);

  final HomeWidgetState _self;
  final $Res Function(HomeWidgetState) _then;

/// Create a copy of HomeWidgetState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? actionDone = null,Object? isLoading = null,}) {
  return _then(_self.copyWith(
actionDone: null == actionDone ? _self.actionDone : actionDone // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeWidgetState].
extension HomeWidgetStatePatterns on HomeWidgetState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeWidgetState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeWidgetState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeWidgetState value)  $default,){
final _that = this;
switch (_that) {
case _HomeWidgetState():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeWidgetState value)?  $default,){
final _that = this;
switch (_that) {
case _HomeWidgetState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool actionDone,  bool isLoading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeWidgetState() when $default != null:
return $default(_that.actionDone,_that.isLoading);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool actionDone,  bool isLoading)  $default,) {final _that = this;
switch (_that) {
case _HomeWidgetState():
return $default(_that.actionDone,_that.isLoading);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool actionDone,  bool isLoading)?  $default,) {final _that = this;
switch (_that) {
case _HomeWidgetState() when $default != null:
return $default(_that.actionDone,_that.isLoading);case _:
  return null;

}
}

}

/// @nodoc


class _HomeWidgetState implements HomeWidgetState {
  const _HomeWidgetState({this.actionDone = false, this.isLoading = false});
  

@override@JsonKey() final  bool actionDone;
@override@JsonKey() final  bool isLoading;

/// Create a copy of HomeWidgetState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeWidgetStateCopyWith<_HomeWidgetState> get copyWith => __$HomeWidgetStateCopyWithImpl<_HomeWidgetState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeWidgetState&&(identical(other.actionDone, actionDone) || other.actionDone == actionDone)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,actionDone,isLoading);

@override
String toString() {
  return 'HomeWidgetState(actionDone: $actionDone, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class _$HomeWidgetStateCopyWith<$Res> implements $HomeWidgetStateCopyWith<$Res> {
  factory _$HomeWidgetStateCopyWith(_HomeWidgetState value, $Res Function(_HomeWidgetState) _then) = __$HomeWidgetStateCopyWithImpl;
@override @useResult
$Res call({
 bool actionDone, bool isLoading
});




}
/// @nodoc
class __$HomeWidgetStateCopyWithImpl<$Res>
    implements _$HomeWidgetStateCopyWith<$Res> {
  __$HomeWidgetStateCopyWithImpl(this._self, this._then);

  final _HomeWidgetState _self;
  final $Res Function(_HomeWidgetState) _then;

/// Create a copy of HomeWidgetState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? actionDone = null,Object? isLoading = null,}) {
  return _then(_HomeWidgetState(
actionDone: null == actionDone ? _self.actionDone : actionDone // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
