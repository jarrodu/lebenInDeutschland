import 'package:flutter/material.dart';
import 'package:leben_in_deutschland/screens/all_questions.dart';
import 'package:leben_in_deutschland/screens/constitution_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [_constitutionButton(context), _allQuestionsButton(context)],
        ),
      ),
    );
  }

  ElevatedButton _allQuestionsButton(BuildContext context) => ElevatedButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AllQuestions(),
            )),
        child: const Text("Alle Fragen"),
      );

  ElevatedButton _constitutionButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ConstitutionPage(),
          )),
      child: const Text("Grundgesetz"),
    );
  }
}
