// pageControllerをグローバルに使えるようにするためのProvider

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final pageControllerProvider = Provider((ref) {
  return PageController();
});
