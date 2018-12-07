import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MIcon {
  String key;
  int codepoint;
  IconData iconData;

  MIcon(
      {@required this.key, @required this.codepoint, @required this.iconData});
}

class MIcons {
  List<MIcon> items = [];

  Future<List<MIcon>> fetchIcons() async {
    String url =
        "https://raw.githubusercontent.com/flutter/flutter/master/packages/flutter/lib/src/material/icons.dart";

    RegExp regexp = RegExp(
      r'>(.*?)<\/i>[\s\S]*?IconData\(0x(.*?)\,',
      multiLine: true,
    );

    http.Response res = await http.get(url);
    regexp.allMatches(res.body).forEach((match) {
      String key = match.group(1);
      int codepoint = int.tryParse(match.group(2), radix: 16);
      IconData iconData = IconData(codepoint, fontFamily: "MaterialIcons");
      this.items.add(
            MIcon(
              key: key,
              codepoint: codepoint,
              iconData: iconData,
            ),
          );
    });

    return this.items;
  }
}
