extension IterableExtension<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T f(int index, E element)) {
    var i = 0;
    return map((e) => f(i++, e));
  }

  void forEachIndexed(void f(int index, E element)) {
    var i = 0;
    forEach((e) => f(i++, e));
  }
}
