import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MIcon {
  String key;
  int codepoint;
  IconData iconData;
  String category;

  MIcon(
      {@required this.key,
      @required this.codepoint,
      @required this.iconData,
      this.category = ""});
}

class MIcons {
  List<MIcon> items = [];
  List<String> categories = [];

  Map<String, int> _codepoints = {};

  MIcons();

  Future<Null> fetchCodepoints() async {
    String url =
        "https://raw.githubusercontent.com/flutter/flutter/master/packages/flutter/lib/src/material/icons.dart";

    RegExp regexp = RegExp(
      r'>(.*?)<\/i>[\s\S]*?IconData\(0x(.*?)\,',
      multiLine: true,
    );

    http.Response res = await http.get(url);
    regexp.allMatches(res.body).forEach((match) {
      String key = match.group(1);
      String codepoint = match.group(2);

      this._codepoints[key] = int.tryParse(codepoint, radix: 16);
    });
  }

  Future<MIcons> fetch() async {
    if (this._codepoints.length == 0) {
      await fetchCodepoints();
    }

    String url = "https://material.io/tools/icons/static/data.json";
    http.Response res = await http.get(url);

    var json = jsonDecode(res.body);
    json["categories"].forEach((category) {
      category["icons"].forEach((_icon) {
        String key = _icon["id"].toString();
        if (this._codepoints.containsKey(key)) {
          MIcon icon = MIcon(
            key: key,
            codepoint: this._codepoints[key],
            iconData:
                IconData(this._codepoints[key], fontFamily: "MaterialIcons"),
            category: category["name"],
          );
          this.items.add(icon);

          if (!this.categories.contains(category["name"])) {
            this.categories.add(category["name"]);
          }
        }
      });
    });

    return this;
  }
}
