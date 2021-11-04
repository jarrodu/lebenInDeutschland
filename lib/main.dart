import 'package:flutter/material.dart';
import 'package:leben_in_deutschland/screens/home_page.dart';
import 'package:leben_in_deutschland/viewModels/question_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<QuestionViewModel>(create: (_) => QuestionViewModel()),
      ],
      child: MaterialApp(
        title: 'Leben In Deutschland',
        theme: ThemeData.dark(),
        home: const HomePage(),
      ),
    );
  }
}
