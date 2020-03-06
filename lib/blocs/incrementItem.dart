import 'dart:async';

import 'package:foodapptask/consts/exports.dart';

class IncrementItem extends Bloc {
  IncrementItem() {
    _valueController.sink.add(0);
  }
  StreamController _valueController = StreamController<int>.broadcast();
  Stream get valueStream => _valueController.stream;
  StreamSink get valueStreamSink => _valueController.sink;
  @override
  void dispose() {
    _valueController.close();
  }
}

IncrementItem cartCountBloc = IncrementItem();