abstract class LocalStorage<T> {
  Future<void> save(String key, T value);
  Future<T?> get(String key);
  Future<void> delete(String key);
}
