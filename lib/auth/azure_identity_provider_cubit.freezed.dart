// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'azure_identity_provider_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AzureIdentityProviderCubitState<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unauthenticated,
    required TResult Function(String serverUrl) authenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unauthenticated,
    TResult? Function(String serverUrl)? authenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unauthenticated,
    TResult Function(String serverUrl)? authenticated,
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
abstract class $AzureIdentityProviderCubitStateCopyWith<T, $Res> {
  factory $AzureIdentityProviderCubitStateCopyWith(
          AzureIdentityProviderCubitState<T> value,
          $Res Function(AzureIdentityProviderCubitState<T>) then) =
      _$AzureIdentityProviderCubitStateCopyWithImpl<T, $Res,
          AzureIdentityProviderCubitState<T>>;
}

/// @nodoc
class _$AzureIdentityProviderCubitStateCopyWithImpl<T, $Res,
        $Val extends AzureIdentityProviderCubitState<T>>
    implements $AzureIdentityProviderCubitStateCopyWith<T, $Res> {
  _$AzureIdentityProviderCubitStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AzureIdentityProviderCubitState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$UnauthenticatedImplCopyWith<T, $Res> {
  factory _$$UnauthenticatedImplCopyWith(_$UnauthenticatedImpl<T> value,
          $Res Function(_$UnauthenticatedImpl<T>) then) =
      __$$UnauthenticatedImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$UnauthenticatedImplCopyWithImpl<T, $Res>
    extends _$AzureIdentityProviderCubitStateCopyWithImpl<T, $Res,
        _$UnauthenticatedImpl<T>>
    implements _$$UnauthenticatedImplCopyWith<T, $Res> {
  __$$UnauthenticatedImplCopyWithImpl(_$UnauthenticatedImpl<T> _value,
      $Res Function(_$UnauthenticatedImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of AzureIdentityProviderCubitState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$UnauthenticatedImpl<T> implements _Unauthenticated<T> {
  const _$UnauthenticatedImpl();

  @override
  String toString() {
    return 'AzureIdentityProviderCubitState<$T>.unauthenticated()';
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
    required TResult Function(String serverUrl) authenticated,
  }) {
    return unauthenticated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unauthenticated,
    TResult? Function(String serverUrl)? authenticated,
  }) {
    return unauthenticated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unauthenticated,
    TResult Function(String serverUrl)? authenticated,
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

abstract class _Unauthenticated<T>
    implements AzureIdentityProviderCubitState<T> {
  const factory _Unauthenticated() = _$UnauthenticatedImpl<T>;
}

/// @nodoc
abstract class _$$AuthenticatedImplCopyWith<T, $Res> {
  factory _$$AuthenticatedImplCopyWith(_$AuthenticatedImpl<T> value,
          $Res Function(_$AuthenticatedImpl<T>) then) =
      __$$AuthenticatedImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String serverUrl});
}

/// @nodoc
class __$$AuthenticatedImplCopyWithImpl<T, $Res>
    extends _$AzureIdentityProviderCubitStateCopyWithImpl<T, $Res,
        _$AuthenticatedImpl<T>>
    implements _$$AuthenticatedImplCopyWith<T, $Res> {
  __$$AuthenticatedImplCopyWithImpl(_$AuthenticatedImpl<T> _value,
      $Res Function(_$AuthenticatedImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of AzureIdentityProviderCubitState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serverUrl = null,
  }) {
    return _then(_$AuthenticatedImpl<T>(
      serverUrl: null == serverUrl
          ? _value.serverUrl
          : serverUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AuthenticatedImpl<T> implements _Authenticated<T> {
  const _$AuthenticatedImpl({required this.serverUrl});

  @override
  final String serverUrl;

  @override
  String toString() {
    return 'AzureIdentityProviderCubitState<$T>.authenticated(serverUrl: $serverUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticatedImpl<T> &&
            (identical(other.serverUrl, serverUrl) ||
                other.serverUrl == serverUrl));
  }

  @override
  int get hashCode => Object.hash(runtimeType, serverUrl);

  /// Create a copy of AzureIdentityProviderCubitState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticatedImplCopyWith<T, _$AuthenticatedImpl<T>> get copyWith =>
      __$$AuthenticatedImplCopyWithImpl<T, _$AuthenticatedImpl<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unauthenticated,
    required TResult Function(String serverUrl) authenticated,
  }) {
    return authenticated(serverUrl);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unauthenticated,
    TResult? Function(String serverUrl)? authenticated,
  }) {
    return authenticated?.call(serverUrl);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unauthenticated,
    TResult Function(String serverUrl)? authenticated,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(serverUrl);
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

abstract class _Authenticated<T> implements AzureIdentityProviderCubitState<T> {
  const factory _Authenticated({required final String serverUrl}) =
      _$AuthenticatedImpl<T>;

  String get serverUrl;

  /// Create a copy of AzureIdentityProviderCubitState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthenticatedImplCopyWith<T, _$AuthenticatedImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
