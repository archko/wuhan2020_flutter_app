import 'dart:ui';

import 'package:flutter/services.dart';

typedef Future<dynamic> MethodHandler(MethodCall call);

class DartChannel {
  final _methodChannel =
      const MethodChannel('plugins.cn.archko/wuhan2020_flutter_app');
  final Set<MethodHandler> _methodHandlers = Set();

  static final DartChannel _instance = DartChannel();

  static DartChannel get singleton => _instance;

  DartChannel() {
    _methodChannel.setMethodCallHandler((MethodCall call) {
      for (MethodHandler handler in _methodHandlers) {
        handler(call);
      }

      return Future.value();
    });
  }

  Future<T> invokeMethod<T>(String method, [dynamic arguments]) async {
    return await _methodChannel.invokeMethod<T>(method, arguments);
  }

  Future<List<T>> invokeListMethod<T>(String method,
      [dynamic arguments]) async {
    return await _methodChannel.invokeListMethod<T>(method, arguments);
  }

  Future<Map<K, V>> invokeMapMethod<K, V>(String method,
      [dynamic arguments]) async {
    return await _methodChannel.invokeMapMethod<K, V>(method, arguments);
  }

  VoidCallback addMethodHandler(MethodHandler handler) {
    assert(handler != null);

    _methodHandlers.add(handler);

    return () {
      _methodHandlers.remove(handler);
    };
  }
}
