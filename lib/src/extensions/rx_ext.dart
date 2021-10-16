import 'dart:async';

import 'package:rxdart/rxdart.dart';

class Rxv<T> implements StreamSink<T> {
  final PublishSubject<T> _subject=PublishSubject<T>();

  late T _value;

  @override
  int get hashCode => _value.hashCode;

  bool operator ==(Object o) {
    if (o is T) return value == o;
    if (o is Rxv<T>) return value == o.value;
    return false;
  }

  Rxv(T value) {
    _value=value;
  }

  T get value => _value;
  set value(T newValue) {
    _subject.add(newValue);
    _value=newValue;
  }

  @override
  void add(T event) {
    _subject.add(event);
    _value=event;
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) => _subject.addError(error,stackTrace);

  @override
  Future addStream(Stream<T> stream) => _subject.addStream(stream);

  @override
  // TODO: implement done
  Future get done => _subject.done;

  StreamSubscription<T> listen( void Function(T)? onData,
      { Function? onError,
        void Function()? onDone,
        bool? cancelOnError}) {
    return _subject.stream.listen(
        onData,
        onDone: onDone,
        onError: onError
    );
  }

  @override
  Future close() {
    return _subject.close();
  }
}

extension StringExtension on String {
  Rxv<String> get rxv => Rxv<String>(this);
}

extension IntExtension on int {
  Rxv<int> get rxv => Rxv<int>(this);
}

extension DoubleExtension on double {
  Rxv<double> get rxv => Rxv<double>(this);
}

extension BoolExtension on bool {
  Rxv<bool> get rxv => Rxv<bool>(this);
}

extension RxT<T> on T {
  Rxv<T> get rxv => Rxv<T>(this);
}