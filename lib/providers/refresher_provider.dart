import 'dart:async';

import 'package:flutter/material.dart';

class RefresherProvider with ChangeNotifier {
  Timer _timer;

  RefresherProvider() {
    _timer = Timer.periodic(Duration(seconds: 5), (Timer t) => notifyListeners());
  }

  void stop() {
    _timer?.cancel();
  }
}
