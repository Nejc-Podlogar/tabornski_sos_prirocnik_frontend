abstract interface class ITorchService {
  /// Transmit [morseSequence] via the device torch using standard timing.
  ///
  /// Dot  = 100 ms on + 100 ms off
  /// Dash = 300 ms on + 100 ms off
  /// Space (letter gap) = 200 ms off
  /// '/'  (word gap)    = 400 ms off
  ///
  /// Repeats indefinitely when [loop] is true until [stop] is called.
  Future<void> transmit(String morseSequence, {bool loop = false});

  /// Stops any ongoing transmission and turns the torch off.
  Future<void> stop();

  /// Directly sets the torch on or off — for manual tap-toggle outside
  /// transmission mode.
  Future<void> setTorch(bool on);
}
