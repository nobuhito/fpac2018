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

class MaterialIconsViewer extends StatefulWidget {
  @override
  _MaterialIconsViewerState createState() => _MaterialIconsViewerState();
}

class _MaterialIconsViewerState extends State<MaterialIconsViewer> {
  List<MIcon> icons;
  List<String> categories;

  int columnsWidth;

  @override
  void initState() {
    this.columnsWidth = 64;

    MIcons().fetch().then((_icons) {
      setState(() {
        this.icons = _icons.items;
        this.categories = _icons.categories;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    int columnCount = deviceSize.width ~/ this.columnsWidth;
    return (this.icons == null)
        ? Center(child: CircularProgressIndicator())
        : DefaultTabController(
            length: this.categories.length,
            child: Scaffold(
              appBar: AppBar(
                title: Text("Material Icons"),
                bottom: TabBar(
                  isScrollable: true,
                  tabs: List.generate(this.categories.length, (index) {
                    return Text(
                      this.categories[index],
                    );
                  }),
                ),
              ),
              body: TabBarView(
                // physics: PageScrollPhysics(),
                children: List.generate(
                  this.categories.length,
                  (index) {
                    List<MIcon> filderedIcons = this
                        .icons
                        .where(
                            (icon) => icon.category == this.categories[index])
                        .toList();
                    return SafeArea(
                      child: GridView.builder(
                        itemCount: filderedIcons.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: columnCount,
                        ),
                        itemBuilder: (context, index) {
                          MIcon icon = filderedIcons[index];
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
                                child: Icon(
                                  icon.iconData,
                                  size: this.columnsWidth * 0.8,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          );
  }
}
