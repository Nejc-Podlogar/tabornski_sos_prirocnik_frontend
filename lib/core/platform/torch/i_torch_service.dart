abstract interface class ITorchService {
  /// Transmit [morseSequence] via the device torch using standard timing.
  ///
  /// Dot  = 200 ms on + 200 ms off
  /// Dash = 600 ms on + 200 ms off
  /// Space (letter gap) = 400 ms off  (200 ms symbol gap + 200 ms extra)
  /// '/'  (word gap)    = 400 ms off
  ///
  /// Repeats indefinitely when [loop] is true until [stop] is called.
  ///
  /// Throws [StateError] if already transmitting.
  /// Check [isTransmitting] before calling.
  Future<void> transmit(String morseSequence, {bool loop = false});

  /// Stops any ongoing transmission and turns the torch off.
  Future<void> stop();

  /// Directly sets the torch on or off — for manual tap-toggle outside
  /// transmission mode.
  Future<void> setTorch(bool on);

  /// Whether a transmission is currently in progress.
  bool get isTransmitting;
}
