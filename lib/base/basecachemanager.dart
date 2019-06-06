class Cache<T> {
  final Map<int,T> cache = Map<int,T>();

  T get(int key){
    return cache[key];
  }

  void put(int key,T ifAbsent){
    cache.putIfAbsent(key, () => ifAbsent);
  }
}