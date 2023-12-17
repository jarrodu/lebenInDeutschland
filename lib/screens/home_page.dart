import 'package:flutter/material.dart';
import 'package:leben_in_deutschland/constants/constants.dart';
import 'package:leben_in_deutschland/enums/enums.dart';
import 'package:leben_in_deutschland/extensions/context_extension.dart';
import 'package:leben_in_deutschland/screens/stateQuestionsPages/choose_state_page.dart';
import 'package:leben_in_deutschland/viewModels/question_view_model.dart';
import 'package:leben_in_deutschland/widgets/homeWidgets/home_bottom_navbar_item_button.dart';
import 'package:leben_in_deutschland/widgets/homeWidgets/home_menu_item_button.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<QuestionViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Image.asset(
              "assets/logos/app_logo_nobg.png",
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: SizedBox(
                width: context.width * 0.9,
                height: context.height * 0.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    HomeMenuItemButton(constitutionMenuItemModel),
                    HomeMenuItemButton(allQuestionsMenuItemModel),
                    HomeMenuItemButton(stateQuestionsMenuItemModel),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildExamFAB(context),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildHomeButton(context),
            HomeBottomNavbarItemButton(pinnedQuestionsNavbarItemModel),
            const SizedBox(width: 30),
            HomeBottomNavbarItemButton(allExamResultNavbarItemModel),
            HomeBottomNavbarItemButton(settingsNavbarItemModel),
          ],
        ),
      ),
    );
  }

  FloatingActionButton _buildExamFAB(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(
        Icons.edit_note,
        color: Colors.black,
        size: 30,
      ),
      onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ChooseStatePage(PageType.examPage),
          )),
    );
  }

  IconButton _buildHomeButton(BuildContext context) {
    return IconButton(onPressed: () {}, icon: const Icon(Icons.home));
  }
}
