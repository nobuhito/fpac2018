import './mIcons.dart';
import 'package:flutter/material.dart';

class VIcon extends StatelessWidget {
  final MIcon icon;

  VIcon({@required this.icon});

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(this.icon.key),
      ),
      body: Center(
        child: Icon(
          this.icon.iconData,
          size: 0.8 *
              ((deviceSize.width < deviceSize.height)
                  ? deviceSize.width
                  : deviceSize.height),
        ),
      ),
    );
  }
}
