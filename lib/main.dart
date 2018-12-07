import 'package:flutter/material.dart';
import './mIcons.dart';
import './vIcon.dart';

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
                MIcon icon = icons[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VIcon(icon: icon),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                  child: Card(
                    child: Hero(
                      tag: icon.key,
                      child: Icon(icon.iconData, size: columnWidth * 0.8),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
