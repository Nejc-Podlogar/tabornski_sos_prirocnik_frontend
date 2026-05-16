abstract interface class IAudioMorseService {
  /// Plays [morseSequence] as a 700 Hz audio tone, looping until [stop].
  /// Throws [StateError] if already transmitting.
  Future<void> transmit(String morseSequence);

  /// Stops any in-progress transmission.
  Future<void> stop();

  bool get isTransmitting;

  /// Emits playback progress (0.0–1.0) for the current round.
  /// Resets to 0.0 at the start of each repetition.
  Stream<double> get progress;

  void dispose();
}
