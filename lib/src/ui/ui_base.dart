import 'dart:async';

abstract class UIState {}

abstract class PresenterBase<T> {
  final _state = StreamController<T>.broadcast();

  Stream<T> get state => _state.stream;

  void emit(T value) {
    _state.add(value);
  }

  void dispose(){
    _state.close();
  }
}
