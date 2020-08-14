import 'dart:async';

import 'package:provider/provider.dart';

class EventBus {
  final _streamController = StreamController<String>.broadcast();

  Stream<String> get stream => _streamController.stream;

  sendEvent(String event) {
    _streamController.add(event);
  }

  dispose() {
    _streamController.close();
  }

  static EventBus get(context) => Provider.of<EventBus>(context, listen: false);
}