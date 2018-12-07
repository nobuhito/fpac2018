import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  List<Map<String, dynamic>> icons = [];

  Future<Null> fetchIcons() async {
    String url =
        "https://raw.githubusercontent.com/flutter/flutter/master/packages/flutter/lib/src/material/icons.dart";

    RegExp regexp = RegExp(
      r'>(.*?)<\/i>[\s\S]*?IconData\(0x(.*?)\,',
      multiLine: true,
    );

    http.Response res = await http.get(url);

    setState(() {
      regexp.allMatches(res.body).forEach((match) {
        String key = match.group(1);
        String codepoint = match.group(2);
        icons.add({
          "key": key,
          "codepoint": int.tryParse(codepoint, radix: 16),
        });
      });
    });
  }

  @override
  void initState() {
    fetchIcons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Material Icons Viewer"),
      ),
      body: GridView.builder(
        itemCount: icons.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        itemBuilder: (context, index) {
          return Card(
            child: Icon(
              IconData(
                this.icons[index]["codepoint"],
                fontFamily: "MaterialIcons",
              ),
              size: 50,
            ),
          );
        },
      ),
    );
  }
}
