import 'package:controller/controller.dart';
import 'package:flutter/material.dart';

class CounterController extends ChangeNotifier {
  int _count;

  CounterController({final int initialValue = 0}) : _count = initialValue;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

class CountryNotifier extends ChangeNotifier {
  String _country;

  CountryNotifier({final String country = 'France'}) : _country = country;

  String get country => _country;

  set country(String value) {
    _country = value;
    notifyListeners();
  }
}

void main() {
  runApp(const App());
}

class Injection extends StatelessWidget {
  final Widget child;

  const Injection({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final counterNotifier = CounterController();
    final countryNotifier = CountryNotifier();

    return Provider(
      value: countryNotifier,
      child: Provider(
        value: counterNotifier,
        child: child,
      ),
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
    final countryNotifier = context.read<CountryNotifier>();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownMenu(
                  initialSelection: 'France',
                  onSelected: (selectedValue) {
                    final countryNotifier = context.read<CountryNotifier>();
                    countryNotifier.country = selectedValue ?? 'France';
                  },
                  dropdownMenuEntries: const [
                    DropdownMenuEntry(value: 'France', label: 'France'),
                    DropdownMenuEntry(value: 'Germany', label: 'Germany'),
                  ],
                ),
                Consumer<CountryNotifier>(
                  builder: (context, countryNotifier) {
                    return Text(countryNotifier.country);
                  },
                ),
                Text(countryNotifier.country),
              ],
            ),
            Consumer<CounterController>(
              builder: (context, counterNotifier) {
                return Text('You pressed the button ${counterNotifier.count}');
              },
            ),
          ],
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
