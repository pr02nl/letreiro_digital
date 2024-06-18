import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import 'widgets/display_simulator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ValueNotifier<String> text = ValueNotifier('');
  @override
  void dispose() {
    text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            DisplaySimulator(
              // key: Key(text),
              text: text,
              border: false,
              debug: false,
            ),
            const SizedBox(height: 48),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'insert_text'.i18n(),
              ),
              onChanged: (value) => setState(() => text.value = value),
            ),
          ],
        ),
      ),
    );
  }
}
