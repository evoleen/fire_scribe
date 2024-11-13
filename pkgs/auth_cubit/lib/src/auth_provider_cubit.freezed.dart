// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_provider_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthProviderState<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unauthenticated,
    required TResult Function(T? data) authenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unauthenticated,
    TResult? Function(T? data)? authenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unauthenticated,
    TResult Function(T? data)? authenticated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Unauthenticated<T> value) unauthenticated,
    required TResult Function(_Authenticated<T> value) authenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Unauthenticated<T> value)? unauthenticated,
    TResult? Function(_Authenticated<T> value)? authenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Unauthenticated<T> value)? unauthenticated,
    TResult Function(_Authenticated<T> value)? authenticated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthProviderStateCopyWith<T, $Res> {
  factory $AuthProviderStateCopyWith(AuthProviderState<T> value,
          $Res Function(AuthProviderState<T>) then) =
      _$AuthProviderStateCopyWithImpl<T, $Res, AuthProviderState<T>>;
}

/// @nodoc
class _$AuthProviderStateCopyWithImpl<T, $Res,
        $Val extends AuthProviderState<T>>
    implements $AuthProviderStateCopyWith<T, $Res> {
  _$AuthProviderStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$UnauthenticatedImplCopyWith<T, $Res> {
  factory _$$UnauthenticatedImplCopyWith(_$UnauthenticatedImpl<T> value,
          $Res Function(_$UnauthenticatedImpl<T>) then) =
      __$$UnauthenticatedImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$UnauthenticatedImplCopyWithImpl<T, $Res>
    extends _$AuthProviderStateCopyWithImpl<T, $Res, _$UnauthenticatedImpl<T>>
    implements _$$UnauthenticatedImplCopyWith<T, $Res> {
  __$$UnauthenticatedImplCopyWithImpl(_$UnauthenticatedImpl<T> _value,
      $Res Function(_$UnauthenticatedImpl<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$UnauthenticatedImpl<T> implements _Unauthenticated<T> {
  const _$UnauthenticatedImpl();

  @override
  String toString() {
    return 'AuthProviderState<$T>.unauthenticated()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UnauthenticatedImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unauthenticated,
    required TResult Function(T? data) authenticated,
  }) {
    return unauthenticated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unauthenticated,
    TResult? Function(T? data)? authenticated,
  }) {
    return unauthenticated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unauthenticated,
    TResult Function(T? data)? authenticated,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Unauthenticated<T> value) unauthenticated,
    required TResult Function(_Authenticated<T> value) authenticated,
  }) {
    return unauthenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Unauthenticated<T> value)? unauthenticated,
    TResult? Function(_Authenticated<T> value)? authenticated,
  }) {
    return unauthenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Unauthenticated<T> value)? unauthenticated,
    TResult Function(_Authenticated<T> value)? authenticated,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated(this);
    }
    return orElse();
  }
}

abstract class _Unauthenticated<T> implements AuthProviderState<T> {
  const factory _Unauthenticated() = _$UnauthenticatedImpl<T>;
}

/// @nodoc
abstract class _$$AuthenticatedImplCopyWith<T, $Res> {
  factory _$$AuthenticatedImplCopyWith(_$AuthenticatedImpl<T> value,
          $Res Function(_$AuthenticatedImpl<T>) then) =
      __$$AuthenticatedImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T? data});
}

/// @nodoc
class __$$AuthenticatedImplCopyWithImpl<T, $Res>
    extends _$AuthProviderStateCopyWithImpl<T, $Res, _$AuthenticatedImpl<T>>
    implements _$$AuthenticatedImplCopyWith<T, $Res> {
  __$$AuthenticatedImplCopyWithImpl(_$AuthenticatedImpl<T> _value,
      $Res Function(_$AuthenticatedImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$AuthenticatedImpl<T>(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T?,
    ));
  }
}

/// @nodoc

class _$AuthenticatedImpl<T> implements _Authenticated<T> {
  const _$AuthenticatedImpl({this.data});

  @override
  final T? data;

  @override
  String toString() {
    return 'AuthProviderState<$T>.authenticated(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticatedImpl<T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticatedImplCopyWith<T, _$AuthenticatedImpl<T>> get copyWith =>
      __$$AuthenticatedImplCopyWithImpl<T, _$AuthenticatedImpl<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unauthenticated,
    required TResult Function(T? data) authenticated,
  }) {
    return authenticated(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unauthenticated,
    TResult? Function(T? data)? authenticated,
  }) {
    return authenticated?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unauthenticated,
    TResult Function(T? data)? authenticated,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Unauthenticated<T> value) unauthenticated,
    required TResult Function(_Authenticated<T> value) authenticated,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Unauthenticated<T> value)? unauthenticated,
    TResult? Function(_Authenticated<T> value)? authenticated,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Unauthenticated<T> value)? unauthenticated,
    TResult Function(_Authenticated<T> value)? authenticated,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class _Authenticated<T> implements AuthProviderState<T> {
  const factory _Authenticated({final T? data}) = _$AuthenticatedImpl<T>;

  T? get data;
  @JsonKey(ignore: true)
  _$$AuthenticatedImplCopyWith<T, _$AuthenticatedImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
