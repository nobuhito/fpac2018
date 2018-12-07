import 'package:flutter/material.dart';
import './mIcons.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MaterialIconsViewer());
  }
}

class MaterialIconsViewer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    double columnWidth = 64;
    int columnCount = deviceSize.width ~/ columnWidth;
    return Scaffold(
      appBar: AppBar(
        title: Text("Material Icons Viewer"),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: MIcons().fetchIcons(),
          builder: (context, future) {
            if (!future.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            List<MIcon> icons = future.data;
            return GridView.builder(
              itemCount: icons.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columnCount,
              ),
              itemBuilder: (context, index) {
                return Card(
                  child: Icon(icons[index].iconData, size: columnWidth * 0.8),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
