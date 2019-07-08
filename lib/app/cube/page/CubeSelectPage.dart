import 'package:cube_timer/app/cube/icon/CubeIcon.dart';
import 'package:cube_timer/app/cube/type/CubeType.dart';
import 'package:cube_timer/app/practice/page/PracticeSelectPage.dart';
import 'package:flutter/material.dart';

class CubeSelectPage extends StatefulWidget {
  CubeSelectPage({Key key}) : super(key: key);

  @override
  _CubeSelectPageState createState() => _CubeSelectPageState();
}

class _CubeSelectPageState extends State<CubeSelectPage> {
  void onCubeSelect(CubeType type) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PracticeSelectPage(cubeType: type)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select cube'),
      ),
      body: ListView(
        children: buildCubeTypesList(),
      ),
    );
  }

  List<Widget> buildCubeTypesList() {
    return CubeType.values
        .map((cubeType) => ListTile(
              contentPadding: EdgeInsets.all(15),
              title: Text(
                CubeTypeHelper.getText(cubeType),
                style: TextStyle(fontSize: 20),
              ),
              leading: Icon(CubeIcon.rubik, size: 40),
              onTap: () {
                onCubeSelect(cubeType);
              },
            ))
        .toList();
  }
}
