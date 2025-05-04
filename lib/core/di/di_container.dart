class DIContainer {
  final _instances = <Type, dynamic>{};
  final _factories = <Type, dynamic Function(DIContainer)>{};
  final _lazySingletons = <Type, dynamic Function(DIContainer)>{};

  void registerSingleton<T>(T instance) {
    _instances[T] = instance;
  }

  void registerLazySingleton<T>(T Function(DIContainer) factory) {
    _lazySingletons[T] = factory;
  }

  void registerFactory<T>(T Function(DIContainer) factory) {
    _factories[T] = factory;
  }

  T get<T>() {
    if (_instances.containsKey(T)) {
      return _instances[T] as T;
    }

    if (_lazySingletons.containsKey(T)) {
      final instance = _lazySingletons[T]!(this) as T;
      _instances[T] = instance;
      _lazySingletons.remove(T);
      return instance;
    }

    if (_factories.containsKey(T)) {
      return _factories[T]!(this) as T;
    }

    throw Exception('Dependency not found: $T');
  }

  void reset() {
    _instances.clear();
    _lazySingletons.clear();
  }
}
