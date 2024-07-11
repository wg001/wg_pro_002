// lib/utils/disposable_mixin.dart

mixin Disposable {
  final List<Function> _disposers = [];

  void addDisposer(Function disposer) {
    _disposers.add(disposer);
  }

  void disposeResources() {
    for (var disposer in _disposers) {
      disposer();
    }
    _disposers.clear();
  }
}
