// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_widget_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HomeWidgetData {

 bool get actionDone; String get widgetTitle; String get widgetMessage; String get widgetImageName; int get lastAccessTimestamp; int get inactivityThresholdMs;
/// Create a copy of HomeWidgetData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeWidgetDataCopyWith<HomeWidgetData> get copyWith => _$HomeWidgetDataCopyWithImpl<HomeWidgetData>(this as HomeWidgetData, _$identity);

  /// Serializes this HomeWidgetData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeWidgetData&&(identical(other.actionDone, actionDone) || other.actionDone == actionDone)&&(identical(other.widgetTitle, widgetTitle) || other.widgetTitle == widgetTitle)&&(identical(other.widgetMessage, widgetMessage) || other.widgetMessage == widgetMessage)&&(identical(other.widgetImageName, widgetImageName) || other.widgetImageName == widgetImageName)&&(identical(other.lastAccessTimestamp, lastAccessTimestamp) || other.lastAccessTimestamp == lastAccessTimestamp)&&(identical(other.inactivityThresholdMs, inactivityThresholdMs) || other.inactivityThresholdMs == inactivityThresholdMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,actionDone,widgetTitle,widgetMessage,widgetImageName,lastAccessTimestamp,inactivityThresholdMs);

@override
String toString() {
  return 'HomeWidgetData(actionDone: $actionDone, widgetTitle: $widgetTitle, widgetMessage: $widgetMessage, widgetImageName: $widgetImageName, lastAccessTimestamp: $lastAccessTimestamp, inactivityThresholdMs: $inactivityThresholdMs)';
}


}

/// @nodoc
abstract mixin class $HomeWidgetDataCopyWith<$Res>  {
  factory $HomeWidgetDataCopyWith(HomeWidgetData value, $Res Function(HomeWidgetData) _then) = _$HomeWidgetDataCopyWithImpl;
@useResult
$Res call({
 bool actionDone, String widgetTitle, String widgetMessage, String widgetImageName, int lastAccessTimestamp, int inactivityThresholdMs
});




}
/// @nodoc
class _$HomeWidgetDataCopyWithImpl<$Res>
    implements $HomeWidgetDataCopyWith<$Res> {
  _$HomeWidgetDataCopyWithImpl(this._self, this._then);

  final HomeWidgetData _self;
  final $Res Function(HomeWidgetData) _then;

/// Create a copy of HomeWidgetData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? actionDone = null,Object? widgetTitle = null,Object? widgetMessage = null,Object? widgetImageName = null,Object? lastAccessTimestamp = null,Object? inactivityThresholdMs = null,}) {
  return _then(_self.copyWith(
actionDone: null == actionDone ? _self.actionDone : actionDone // ignore: cast_nullable_to_non_nullable
as bool,widgetTitle: null == widgetTitle ? _self.widgetTitle : widgetTitle // ignore: cast_nullable_to_non_nullable
as String,widgetMessage: null == widgetMessage ? _self.widgetMessage : widgetMessage // ignore: cast_nullable_to_non_nullable
as String,widgetImageName: null == widgetImageName ? _self.widgetImageName : widgetImageName // ignore: cast_nullable_to_non_nullable
as String,lastAccessTimestamp: null == lastAccessTimestamp ? _self.lastAccessTimestamp : lastAccessTimestamp // ignore: cast_nullable_to_non_nullable
as int,inactivityThresholdMs: null == inactivityThresholdMs ? _self.inactivityThresholdMs : inactivityThresholdMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeWidgetData].
extension HomeWidgetDataPatterns on HomeWidgetData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeWidgetData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeWidgetData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeWidgetData value)  $default,){
final _that = this;
switch (_that) {
case _HomeWidgetData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeWidgetData value)?  $default,){
final _that = this;
switch (_that) {
case _HomeWidgetData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool actionDone,  String widgetTitle,  String widgetMessage,  String widgetImageName,  int lastAccessTimestamp,  int inactivityThresholdMs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeWidgetData() when $default != null:
return $default(_that.actionDone,_that.widgetTitle,_that.widgetMessage,_that.widgetImageName,_that.lastAccessTimestamp,_that.inactivityThresholdMs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool actionDone,  String widgetTitle,  String widgetMessage,  String widgetImageName,  int lastAccessTimestamp,  int inactivityThresholdMs)  $default,) {final _that = this;
switch (_that) {
case _HomeWidgetData():
return $default(_that.actionDone,_that.widgetTitle,_that.widgetMessage,_that.widgetImageName,_that.lastAccessTimestamp,_that.inactivityThresholdMs);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool actionDone,  String widgetTitle,  String widgetMessage,  String widgetImageName,  int lastAccessTimestamp,  int inactivityThresholdMs)?  $default,) {final _that = this;
switch (_that) {
case _HomeWidgetData() when $default != null:
return $default(_that.actionDone,_that.widgetTitle,_that.widgetMessage,_that.widgetImageName,_that.lastAccessTimestamp,_that.inactivityThresholdMs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HomeWidgetData implements HomeWidgetData {
  const _HomeWidgetData({this.actionDone = false, this.widgetTitle = 'Welcome', this.widgetMessage = 'Open the app to get started', this.widgetImageName = 'default', this.lastAccessTimestamp = 0, this.inactivityThresholdMs = 60000});
  factory _HomeWidgetData.fromJson(Map<String, dynamic> json) => _$HomeWidgetDataFromJson(json);

@override@JsonKey() final  bool actionDone;
@override@JsonKey() final  String widgetTitle;
@override@JsonKey() final  String widgetMessage;
@override@JsonKey() final  String widgetImageName;
@override@JsonKey() final  int lastAccessTimestamp;
@override@JsonKey() final  int inactivityThresholdMs;

/// Create a copy of HomeWidgetData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeWidgetDataCopyWith<_HomeWidgetData> get copyWith => __$HomeWidgetDataCopyWithImpl<_HomeWidgetData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomeWidgetDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeWidgetData&&(identical(other.actionDone, actionDone) || other.actionDone == actionDone)&&(identical(other.widgetTitle, widgetTitle) || other.widgetTitle == widgetTitle)&&(identical(other.widgetMessage, widgetMessage) || other.widgetMessage == widgetMessage)&&(identical(other.widgetImageName, widgetImageName) || other.widgetImageName == widgetImageName)&&(identical(other.lastAccessTimestamp, lastAccessTimestamp) || other.lastAccessTimestamp == lastAccessTimestamp)&&(identical(other.inactivityThresholdMs, inactivityThresholdMs) || other.inactivityThresholdMs == inactivityThresholdMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,actionDone,widgetTitle,widgetMessage,widgetImageName,lastAccessTimestamp,inactivityThresholdMs);

@override
String toString() {
  return 'HomeWidgetData(actionDone: $actionDone, widgetTitle: $widgetTitle, widgetMessage: $widgetMessage, widgetImageName: $widgetImageName, lastAccessTimestamp: $lastAccessTimestamp, inactivityThresholdMs: $inactivityThresholdMs)';
}


}

/// @nodoc
abstract mixin class _$HomeWidgetDataCopyWith<$Res> implements $HomeWidgetDataCopyWith<$Res> {
  factory _$HomeWidgetDataCopyWith(_HomeWidgetData value, $Res Function(_HomeWidgetData) _then) = __$HomeWidgetDataCopyWithImpl;
@override @useResult
$Res call({
 bool actionDone, String widgetTitle, String widgetMessage, String widgetImageName, int lastAccessTimestamp, int inactivityThresholdMs
});




}
/// @nodoc
class __$HomeWidgetDataCopyWithImpl<$Res>
    implements _$HomeWidgetDataCopyWith<$Res> {
  __$HomeWidgetDataCopyWithImpl(this._self, this._then);

  final _HomeWidgetData _self;
  final $Res Function(_HomeWidgetData) _then;

/// Create a copy of HomeWidgetData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? actionDone = null,Object? widgetTitle = null,Object? widgetMessage = null,Object? widgetImageName = null,Object? lastAccessTimestamp = null,Object? inactivityThresholdMs = null,}) {
  return _then(_HomeWidgetData(
actionDone: null == actionDone ? _self.actionDone : actionDone // ignore: cast_nullable_to_non_nullable
as bool,widgetTitle: null == widgetTitle ? _self.widgetTitle : widgetTitle // ignore: cast_nullable_to_non_nullable
as String,widgetMessage: null == widgetMessage ? _self.widgetMessage : widgetMessage // ignore: cast_nullable_to_non_nullable
as String,widgetImageName: null == widgetImageName ? _self.widgetImageName : widgetImageName // ignore: cast_nullable_to_non_nullable
as String,lastAccessTimestamp: null == lastAccessTimestamp ? _self.lastAccessTimestamp : lastAccessTimestamp // ignore: cast_nullable_to_non_nullable
as int,inactivityThresholdMs: null == inactivityThresholdMs ? _self.inactivityThresholdMs : inactivityThresholdMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
