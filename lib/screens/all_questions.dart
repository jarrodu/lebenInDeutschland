import 'package:flutter/material.dart';
import 'package:leben_in_deutschland/cache/cache_manager.dart';
import 'package:leben_in_deutschland/enums/enums.dart';
import 'package:leben_in_deutschland/models/question_model.dart';
import 'package:leben_in_deutschland/viewModels/question_view_model.dart';
import 'package:leben_in_deutschland/widgets/question_widget.dart';
import 'package:provider/provider.dart';

class AllQuestions extends StatefulWidget {
  const AllQuestions({Key? key}) : super(key: key);

  @override
  State<AllQuestions> createState() => _AllQuestionsState();
}

class _AllQuestionsState extends State<AllQuestions> {
  final controller = PageController();
  bool? isTrue;
  List<Color> optionColors = [
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black,
  ];
  final counter = ValueNotifier<int>(-1);

  late int page;

  List<int>? pinnedQuestions;
  late bool isPinned;
  @override
  void initState() {
    super.initState();
    getPinned();
    page = 0;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void getPinned() async {
    pinnedQuestions = (await CacheManager.instance.getPinnedQuestions())!;
  }

  @override
  Widget build(BuildContext context) {
    final QuestionViewModel _questionsViewModel =
        Provider.of<QuestionViewModel>(context);
    final List<QuestionModel>? questions = _questionsViewModel.questions;

    pinnedQuestions == null ? isPinned = false : searchIsPinned(page + 1);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                searchIsPinned(page + 1);
                if (isPinned) {
                  pinnedQuestions!.remove(page + 1);
                  isPinned = false;
                } else {
                  pinnedQuestions!.add(page + 1);
                  isPinned = true;
                }
                CacheManager.instance.setPinnedQuestiona(pinnedQuestions!);
                pinnedQuestions =
                    await CacheManager.instance.getPinnedQuestions();
                setState(() {});
              },
              icon: isPinned
                  ? const Icon(Icons.push_pin)
                  : const Icon(Icons.push_pin_outlined)),
          IconButton(
              onPressed: () {
                counter.value = controller.page!.toInt();
              },
              icon: const Icon(Icons.translate)),
        ],
      ),
      body: Center(
        child: PageView.builder(
          itemBuilder: (context, index) {
            return _buildQuestionPages(questions!, index);
          },
          allowImplicitScrolling: true,
          controller: controller,
          onPageChanged: (value) {
            searchIsPinned(value + 1);
            page = value;
            setState(() {});
          },
        ),
      ),
    );
  }

  void searchIsPinned(int id) {
    pinnedQuestions!.contains(id) ? isPinned = true : isPinned = false;
  }

  Widget _buildQuestionPages(List<QuestionModel> questions, int i) {
    return ValueListenableBuilder<int>(
      valueListenable: counter,
      builder: (context, value, _) {
        if (value == i) {
          return QuestionWidget(questions[i], true, PageType.allQuestionPage);
        } else {
          return QuestionWidget(questions[i], false, PageType.allQuestionPage);
        }
      },
    );
    
  }
}
