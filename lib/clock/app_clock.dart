import 'package:flutter_fastapp/clock/fake_clock.dart';
import 'package:time_machine/time_machine.dart';

/// Singleton implementation of [Clock] for this app which reads
/// the time from the given [clock] that is set on using [setClock] method
class AppClock extends Clock {
  final Clock _delegateClock;
  final bool unitTestMode;

  AppClock._(this._delegateClock, {this.unitTestMode = false});

  static AppClock _instance = AppClock._(SystemClock.instance);

  /// returns the clock instance that is used across the app as the only valid clock
  /// that should be referenced and used by this app
  static AppClock get instance => _instance;

  /// sets the clock instance that is used across the app as the only valid clock
  /// that should be referenced and used by this app
  static void setClock(Clock clock, {unitTestMode = false}) {
    _instance = AppClock._(clock, unitTestMode: unitTestMode);
  }

  /// returns true if the clock instance is an instance of [FakeClock]
  /// [FakeClock] is used for testing purposes. this should always return false
  /// in production.
  ///
  /// can user [setClock] method to set the clock instance used by [AppClock]
  bool get isFakeClock => _delegateClock is FakeClock && !unitTestMode;

  FakeClock? get getFakeClock =>
      (isFakeClock) ? _delegateClock as FakeClock : null;

  @override
  Instant getCurrentInstant() => _delegateClock.getCurrentInstant();
}
