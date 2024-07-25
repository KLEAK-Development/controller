import "package:flutter/material.dart";

class Provider<T> extends InheritedWidget {
  final T value;

  const Provider({super.key, required super.child, required this.value});

  @override
  bool updateShouldNotify(covariant Provider<T> oldWidget) {
    return value != oldWidget.value;
  }
}

class Consumer<T extends Listenable> extends StatelessWidget {
  final Widget Function(
    BuildContext context,
    T notifier,
    Widget? child,
  ) builder;
  final Widget? child;

  const Consumer({super.key, required this.builder, this.child});

  @override
  Widget build(BuildContext context) {
    final notifier = context.read<T>();

    return ListenableBuilder(
      listenable: notifier,
      builder: (context, child) => builder(context, notifier, child),
      child: child,
    );
  }
}

extension ProviderExtension on BuildContext {
  T read<T>() => getInheritedWidgetOfExactType<Provider<T>>()!.value;
}
