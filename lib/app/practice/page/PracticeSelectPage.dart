import 'package:cube_timer/app/cube/type/CubeType.dart';
import 'package:cube_timer/app/practice/domain/PracticeDomain.dart';
import 'package:cube_timer/app/practice/service/PracticeService.dart';
import 'package:cube_timer/app/timer/helper/SolveHelper.dart';
import 'package:cube_timer/app/timer/page/TimerPage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PracticeSelectPage extends StatefulWidget {
  final CubeType cubeType;

  PracticeSelectPage({Key key, this.cubeType}) : super(key: key);

  @override
  _PracticeSelectPageState createState() => _PracticeSelectPageState();
}

class _PracticeSelectPageState extends State<PracticeSelectPage> {
  var practices = List<Practice>();
  var practiceService = PracticeService();

  void goToPractice(Practice practice) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => TimerPage(
              practice: practice,
              cubeType: widget.cubeType,
            )));
  }

  void onNewPracticeSelect() {
    practiceService.createNewPractice(widget.cubeType).then((practice) {
      setState(() {
        this.practices.add(practice);
      });

      goToPractice(practice);
    });
  }

  void deleteAllPractices() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("Are you sure you want to delete all?"),
          actions: <Widget>[
            FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                setState(() {
                  practices.clear();
                });

                practiceService.savePracticeList(practices, widget.cubeType);
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  void deletePractice(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("Are you sure?"),
          actions: <Widget>[
            FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                setState(() {
                  practices.removeWhere((practice) => practice.id == id);
                });

                practiceService.savePracticeList(practices, widget.cubeType);
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    practiceService.readAll().then((practices) {
      if (practices.cubeTypes.containsKey(widget.cubeType)) {
        setState(() {
          this.practices.addAll(practices.cubeTypes[widget.cubeType]);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Select the cube for ' + CubeTypeHelper.getText(widget.cubeType)),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.delete), onPressed: deleteAllPractices)
        ],
      ),
      body: ListView(
        children: buildCubeTypesList(),
      ),
    );
  }

  List<Widget> buildCubeTypesList() {
    var createNewPracticeWidget = ListTile(
      title: Text("Start new practice"),
      leading: Icon(Icons.add),
      onTap: onNewPracticeSelect,
    );

    var practicesCopy = List.of(practices);
    practicesCopy
        .sort((item1, item2) => item1.started.compareTo(item2.started));
    var practicesList = practicesCopy.reversed.map((practice) {
      return ListTile(
        title: Text(
            'Started ' + DateFormat('dd.MM HH:mm').format(practice.started)),
        subtitle: Text(practice.solves.length.toString() +
            ' solves' +
            '\r\n' +
            'Avg: ' +
            SolveHelper.formatDuration(practice.avg)),
        isThreeLine: true,
        trailing: PopupMenuButton<PracticePopupMenu>(
          onSelected: (item) {
            switch (item.key) {
              case 'delete':
                {
                  deletePractice(practice.id);
                }
            }
          },
          itemBuilder: (context) {
            var items = [PracticePopupMenu(title: 'Delete', key: 'delete')];

            return items
                .map((item) => PopupMenuItem<PracticePopupMenu>(
                      child: Text(item.title),
                      value: item,
                    ))
                .toList();
          },
        ),
        onTap: () {
          goToPractice(practice);
        },
      );
    }).toList();

    var result = List<Widget>();
    result.add(createNewPracticeWidget);
    result.addAll(practicesList);
    return result;
  }
}

class PracticePopupMenu {
  PracticePopupMenu({this.title, this.key});

  String title;
  String key;
}
