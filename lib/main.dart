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
                crossAxisCount: 4,
              ),
              itemBuilder: (context, index) {
                return Card(
                  child: Icon(icons[index].iconData, size: 50),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
