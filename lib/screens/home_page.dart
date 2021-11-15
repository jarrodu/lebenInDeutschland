import 'package:flutter/material.dart';
import 'package:leben_in_deutschland/screens/all_questions.dart';
import 'package:leben_in_deutschland/screens/choose_state_page.dart';
import 'package:leben_in_deutschland/screens/constitution_page.dart';
import 'package:leben_in_deutschland/screens/exam_page.dart';
import 'package:leben_in_deutschland/screens/false_questions_page.dart';
import 'package:leben_in_deutschland/screens/pinned_questions_page.dart';
import 'package:leben_in_deutschland/screens/settings_page.dart';
import 'package:leben_in_deutschland/viewModels/question_view_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<QuestionViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            _constitutionButton(context),
            _allQuestionsButton(context),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChooseStatePage(),
                      ));
                },
                child: const Text("Landesbezogene Fragen"))
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildExamFAB(context),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildHomeButton(),
            _buildPinnedQuestionButton(context),
            const SizedBox(width: 30),
            _buildFalseQuestionsButton(context),
            _buildSettingButton(context),
          ],
        ),
      ),
    );
  }

  FloatingActionButton _buildExamFAB(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ExamPage(),
          )),
    );
  }

  IconButton _buildSettingButton(BuildContext context) {
    return IconButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SettingsPage(),
            )),
        icon: const Icon(Icons.settings));
  }

  IconButton _buildFalseQuestionsButton(BuildContext context) {
    return IconButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FalseQuestionsPage(),
            )),
        icon: const Icon(Icons.cancel_outlined));
  }

  IconButton _buildPinnedQuestionButton(BuildContext context) {
    return IconButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PinnedQuestionsPage(),
            )),
        icon: const Icon(Icons.push_pin_rounded));
  }

  IconButton _buildHomeButton() => IconButton(onPressed: () {}, icon: const Icon(Icons.home));

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
