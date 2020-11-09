extension ScopeFunExt<T> on T {
  A let<A>(A Function(T) f) => f(this);

  T alse(void Function(T) f) {
    f(this);
    return this;
  }
}

extension ScopeFunListExt<T> on List<T> {
  List<T> copy() => List.from(this, growable: true);

  List<Y> mapIndexed<Y>(Y Function(int, T) onMap) =>
      asMap().entries.map((entry) => onMap(entry.key, entry.value)).toList();
}
