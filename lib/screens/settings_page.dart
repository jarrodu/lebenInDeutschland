import 'package:flutter/material.dart';
import 'package:leben_in_deutschland/cache/cache_manager.dart';
import 'package:leben_in_deutschland/provider/theme_notifier.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _selectedPosition = -1;
  var isDarkTheme;
  List themes = ["Light", "Dark"];
  late ThemeNotifier themeNotifier;

  @override
  Widget build(BuildContext context) {
    isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    themeNotifier = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemBuilder: (context, position) {
            return _createList(context, themes[position], position);
          },
          itemCount: themes.length,
        ),
      ),
    );
  }

  _createList(context, item, position) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        _updateState(position);
      },
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Radio(
            value: _selectedPosition,
            groupValue: position,
            activeColor: isDarkTheme ? Colors.pink : Colors.black,
            onChanged: (_) {
              _updateState(position);
            },
          ),
          Text(item),
        ],
      ),
    );
  }

  _updateState(int position) {
    setState(() {
      _selectedPosition = position;
    });
    onThemeChanged(themes[position]);
  }

  void onThemeChanged(String value) async {
    if (value == "Dark") {
      themeNotifier.setThemeMode(ThemeMode.dark);
      CacheManager.instance.setThemePref(false);
    } else {
      themeNotifier.setThemeMode(ThemeMode.light);
      CacheManager.instance.setThemePref(true);
    }
  }
}
