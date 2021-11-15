import 'package:flutter/material.dart';
import 'package:leben_in_deutschland/screens/state_question_page.dart';

class ChooseStatePage extends StatefulWidget {
  ChooseStatePage({Key? key}) : super(key: key);

  @override
  State<ChooseStatePage> createState() => _ChooseStatePageState();
}

class _ChooseStatePageState extends State<ChooseStatePage> {
  List<String> allStates = [
    "Baden-Württemberg",
    "Bayern",
    "Berlin",
    "Brandenburg",
    "Bremen",
    "Hamburg",
    "Hessen",
    "Mecklenburg-Vorpommern",
    "Niedersachsen",
    "Nordrhein-Westfalen",
    "Rheinland-Pfalz",
    "Saarland",
    "Sachsen",
    "Sachsen-Anhalt",
    "Schleswig-Holstein",
    "Thüringen",
  ];

  late int _selectedStateIndex;
  @override
  void initState() {
    super.initState();
    _selectedStateIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            DropdownButton<int>(
              value: _selectedStateIndex,
              items: List.generate(
                  allStates.length,
                  (index) =>
                      DropdownMenuItem(value: index, child: Text(allStates[index]))),
              onChanged: (value) {
                _selectedStateIndex = value!;
                setState(() {});
              },
            ),
            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => StateQuestionPage(_selectedStateIndex),));
            }, child: const Text("Zum KatalogFragen"))
          ],
        ),
      ),
    );
  }
}
