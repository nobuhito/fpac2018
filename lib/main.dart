import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
          future: http.get(
              "https://raw.githubusercontent.com/flutter/flutter/master/packages/flutter/lib/src/material/icons.dart"),
          builder: (context, future) {
            if (!future.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            RegExp regexp = RegExp(
              r'>(.*?)<\/i>[\s\S]*?IconData\(0x(.*?)\,',
              multiLine: true,
            );

            List<Map<String, dynamic>> icons = [];
            regexp.allMatches(future.data.body).forEach((match) {
              String key = match.group(1);
              String codepoint = match.group(2);
              icons.add({
                "key": key,
                "codepoint": int.tryParse(codepoint, radix: 16),
              });
            });

            return GridView.builder(
              itemCount: icons.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemBuilder: (context, index) {
                return Card(
                  child: Icon(
                    IconData(
                      icons[index]["codepoint"],
                      fontFamily: "MaterialIcons",
                    ),
                    size: 50,
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
