import 'dart:async';

import 'package:foodapptask/consts/exports.dart';

class ResponseBloc extends Bloc {
  StreamController _responseController = StreamController<List<Map<String,dynamic>>>.broadcast();
  Stream get valueStream => _responseController.stream;
  StreamSink get valueStreamSink => _responseController.sink;
  @override
  void dispose() {
    _responseController.close();
  }
}
ResponseBloc responseBloc = ResponseBloc();