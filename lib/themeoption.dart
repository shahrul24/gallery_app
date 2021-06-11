import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:gallery_app/blocs/theme.dart';

class ThemeOption extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);

    return new Scaffold(
        appBar: AppBar(
          title: Text('Change Theme'),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              FlatButton(
                  child: Text('Dark Theme'),
                  onPressed: () => _themeChanger.setTheme(ThemeData.dark())),
              FlatButton(
                  child: Text('Light Theme'),
                  onPressed: () => _themeChanger.setTheme(ThemeData.light())),
            ],
          ),
        )
    );
  }
}
