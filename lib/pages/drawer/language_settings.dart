import 'package:click/helpers/layout.dart';
import 'package:flutter/material.dart';

class LanguageSettings extends StatefulWidget {
  const LanguageSettings({Key? key}) : super(key: key);

  @override
  State<LanguageSettings> createState() => _LanguageSettingsState();
}

class _LanguageSettingsState extends State<LanguageSettings> {
  String preferredLanguage = 'Hindi';

  void setLang(val) {
    setState(() {
      preferredLanguage = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'Please select your preferred language',
              style: TextStyle(
                fontSize: AppLayout.getHeight(18),
                fontWeight: FontWeight.w700,
              ),
            ),
            DropdownButtonFormField(
              value: preferredLanguage,
              items: ['English', 'Hindi', 'Marathi', 'Gujarati']
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ),
                  )
                  .toList(),
              onChanged: (val) => setLang(val),
            )
          ],
        ),
      ),
    );
  }
}
