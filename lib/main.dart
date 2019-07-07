import 'package:flutter/material.dart';

import 'app/cube/page/CubeSelectPage.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cube Timer',
      home: CubeSelectPage(),
    );
  }
}
