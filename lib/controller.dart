import "package:flutter/material.dart";

abstract class Controller extends ChangeNotifier {}

class _ControllerModel<T> extends InheritedWidget {
  const _ControllerModel({
    super.key,
    required super.child,
    required this.controller,
  });

  final T controller;

  @override
  bool updateShouldNotify(_ControllerModel<T> oldWidget) {
    return oldWidget.controller != controller;
  }
}

class ControllerListenable<T extends Controller> extends StatelessWidget {
  final Widget Function(BuildContext context, T controller) builder;

  const ControllerListenable({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    final controller = context.ofType<T>();
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) => builder(context, controller),
    );
  }
}

class ControllerProvider<T extends Controller> extends StatelessWidget {
  const ControllerProvider({
    super.key,
    required this.controller,
    required this.child,
  });

  final Widget child;
  final T controller;

  @override
  Widget build(BuildContext context) {
    return _ControllerModel<T>(controller: controller, child: this.child);
  }
}

extension ControllerExtension on BuildContext {
  T ofType<T extends Controller>() =>
      getInheritedWidgetOfExactType<_ControllerModel<T>>()!.controller;
}

class Provider<T> extends InheritedWidget {
  final T value;

  const Provider({super.key, required super.child, required this.value});

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}

extension ProviderExtension on BuildContext {
  T read<T>() => getInheritedWidgetOfExactType<Provider<T>>()!.value;
}
