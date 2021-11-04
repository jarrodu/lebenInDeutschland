import 'package:flutter/material.dart';
import 'package:leben_in_deutschland/screens/all_questions.dart';
import 'package:leben_in_deutschland/screens/constitution_page.dart';
import 'package:leben_in_deutschland/screens/false_questions_page.dart';
import 'package:leben_in_deutschland/screens/pinned_questions_page.dart';
import 'package:leben_in_deutschland/screens/settings_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            _constitutionButton(context),
            _allQuestionsButton(context),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(child: const Icon(Icons.add), onPressed: () {}),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.home)),
            IconButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PinnedQuestionsPage(),
                    )),
                icon: const Icon(Icons.push_pin_rounded)),
            SizedBox(width: 30),
            IconButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FalseQuestionsPage(),
                    )),
                icon: const Icon(Icons.cancel_outlined)),
            IconButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsPage(),
                    )),
                icon: const Icon(Icons.settings)),
          ],
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
