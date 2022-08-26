import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final phoneSizeProvider = Provider<Size>((_) {
  final context = useContext();
  return MediaQuery.of(context).size;
});