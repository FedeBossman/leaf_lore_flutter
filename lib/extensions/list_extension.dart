extension FilterNotNull<T> on List<T?> {
  Iterable filterNotNull() {
    return where((element) => element != null).cast<T>();
  }
}