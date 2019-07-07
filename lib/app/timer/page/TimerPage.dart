import 'package:cube_timer/app/cube/type/CubeType.dart';
import 'package:cube_timer/app/practice/domain/PracticeDomain.dart';
import 'package:cube_timer/app/practice/service/PracticeService.dart';
import 'package:cube_timer/app/scramble/dto/Scramble.dart';
import 'package:cube_timer/app/scramble/service/ScrambleService.dart';
import 'package:cube_timer/app/timer/domain/SolveDomain.dart';
import 'package:cube_timer/app/timer/helper/SolveHelper.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:uuid/uuid.dart';

class TimerPage extends StatefulWidget {
  final Practice practice;
  final CubeType cubeType;

  TimerPage({Key key, this.practice, this.cubeType}) : super(key: key);

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  var practiceService = PracticeService();
  var timerText = '--';
  DateTime startedDate;
  DateTime finishedDate;
  var timerState = TimerState.FINISHED;
  Timer readyTimer;
  Timer textTimer;
  String solveId;

  Scramble scramble;
  var scrambleService = ScrambleService();

  @override
  void initState() {
    super.initState();

    solveId = randomUuid();
    scrambleService.fetch();
  }

  @override
  void deactivate() {
    readyTimer.cancel();
    textTimer.cancel();

    super.deactivate();
  }

  String randomUuid() {
    return Uuid().v1();
  }

  void onPress(PointerDownEvent event) {
    if (timerState == TimerState.FINISHED) {
      setState(() {
        timerState = TimerState.NOT_READY;

        readyTimer = Timer(Duration(milliseconds: 500), () {
          setState(() {
            timerState = TimerState.READY;
          });
        });
      });
    }

    if (timerState == TimerState.RUNNING) {
      finishedDate = DateTime.now();
      textTimer.cancel();

      setState(() {
        timerState = TimerState.FINISHED;
        timerText = createCounterText(startedDate, finishedDate);
        saveSolve(finishedDate.millisecondsSinceEpoch -
            startedDate.millisecondsSinceEpoch);
      });
    }
  }

  void onRelease(PointerUpEvent event) {
    if (timerState == TimerState.NOT_READY) {
      readyTimer.cancel();
      setState(() {
        timerState = TimerState.FINISHED;
      });
    }

    if (timerState == TimerState.READY) {
      startedDate = DateTime.now();
      setState(() {
        timerState = TimerState.RUNNING;
        solveId = randomUuid();
      });

      textTimer = Timer.periodic(Duration(milliseconds: 1), (timer) {
        setState(() {
          timerText = createCounterText(startedDate, DateTime.now());
        });
      });
    }
  }

  void saveSolve(int duration) {
    var practice = widget.practice;
    var solves = practice.solves;
    solves.removeWhere((solve) => solve.id == solveId);
    solves.add(Solve(solveId, duration, false, false));

    practiceService.savePractice(practice);
  }

  String createCounterText(DateTime fromDate, DateTime toDate) {
    var from = fromDate.millisecondsSinceEpoch;
    var to = toDate.millisecondsSinceEpoch;

    return SolveHelper.formatDuration(to - from);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cube ' + CubeTypeHelper.getText(widget.cubeType)),
      ),
      body: Listener(
          onPointerDown: onPress,
          onPointerUp: onRelease,
          child: SizedBox.expand(
            child: Container(
                color: getBackgroundColor(),
                child: Center(
                  child: Text(
                    timerText,
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 70,
                        fontFamily: 'Elronmonospace',
                        color: Colors.white),
                  ),
                )),
          )),
    );
  }

  Color getBackgroundColor() {
    switch (timerState) {
      case TimerState.FINISHED:
        return Colors.red;
      case TimerState.NOT_READY:
        return Colors.orange;
      case TimerState.READY:
        return Colors.green;
      case TimerState.RUNNING:
        return Colors.blue;
      default:
        return Colors.black;
    }
  }
}

enum TimerState { FINISHED, NOT_READY, READY, RUNNING }
