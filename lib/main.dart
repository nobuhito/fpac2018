import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MaterialIconsViewer());
  }
}

class MaterialIconsViewer extends StatelessWidget {
  final List<IconData> icons = [
    Icons.access_alarm,
    Icons.arrow_back_ios,
    Icons.account_balance_wallet,
    Icons.center_focus_weak,
    Icons.blur_on,
    Icons.dashboard,
    Icons.phone,
    Icons.tap_and_play,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Material Icons Viewer"),
      ),
      body: SafeArea(
        child: GridView.builder(
          itemCount: icons.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          itemBuilder: (context, index) {
            return Card(
              child: Icon(icons[index], size: 50),
            );
          },
        ),
      ),
    );
  }
}
