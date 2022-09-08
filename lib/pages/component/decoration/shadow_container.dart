import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ShadowContainer extends HookConsumerWidget {
  const ShadowContainer({
    required this.child,
    this.margin,
    this.color,
    Key? key}) : super(key: key);
  final Widget child;
  final EdgeInsets? margin;
  final Color? color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Container(
        clipBehavior: Clip.antiAlias,
        margin: margin ?? const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1.0,
              blurRadius: 5.0,
              offset: const Offset(5, 5),
            ),
          ],
        ),
      child: child,
    );
  }
}
