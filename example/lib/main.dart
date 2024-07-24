import 'package:controller/controller.dart';
import 'package:flutter/material.dart';

class CounterController extends Controller {
  int _count;

  CounterController({final int initialValue = 0}) : _count = initialValue;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

class CountryController extends Controller {
  String _country;

  CountryController({final String country = 'France'}) : _country = country;

  String get country => _country;
}

void main() {
  runApp(const App());
}

class Injection extends StatefulWidget {
  final Widget child;

  const Injection({super.key, required this.child});

  @override
  State<Injection> createState() => _InjectionState();
}

class _InjectionState extends State<Injection> {
  final counterController = CounterController();

  @override
  Widget build(BuildContext context) {
    return ControllerProvider(
      controller: counterController,
      child: widget.child,
    );
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const Injection(
      child: MaterialApp(
        home: Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ControllerListenable<CounterController>(
          builder: (context, counterController) {
            return Text('You pressed the button ${counterController.count}');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          final counterController = context.read<CounterController>();
          counterController.increment();
        },
      ),
    );
  }
}
