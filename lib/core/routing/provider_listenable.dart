import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Bridges a Riverpod [ProviderListenable] to Flutter's [ChangeNotifier] so
/// that GoRouter's [refreshListenable] can trigger redirect re-evaluation
/// whenever the watched provider changes.
class ProviderListenableAdapter<T> extends ChangeNotifier {
  ProviderListenableAdapter(
    this._container,
    this._provider,
  ) {
    _subscription = _container.listen<T>(
      _provider,
      (_, __) => notifyListeners(),
      fireImmediately: false,
    );
  }

  final ProviderContainer _container;
  final ProviderListenable<T> _provider;
  late final ProviderSubscription<T> _subscription;

  @override
  void dispose() {
    _subscription.close();
    super.dispose();
  }
}
