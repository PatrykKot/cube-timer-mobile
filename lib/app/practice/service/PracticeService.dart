import 'dart:convert';
import 'dart:io';

import 'package:cube_timer/app/cube/type/CubeType.dart';
import 'package:cube_timer/app/domain/PracticesDomain.dart';
import 'package:cube_timer/app/practice/domain/PracticeDomain.dart';
import 'package:path_provider/path_provider.dart';

class PracticeService {
  Future<Practices> readAll() async {
    File file = await getFile();

    if (file.existsSync()) {
      var content = file.readAsStringSync();
      if (content.isNotEmpty) {
        return Practices.fromJson(jsonDecode(content));
      }
    }

    return Practices(Map());
  }

  Future<Practice> createNewPractice(CubeType cubeType) async {
    var practice = Practice.createNew();
    var practices = await readAll();
    if (practices.cubeTypes.containsKey(cubeType)) {
      practices.cubeTypes[cubeType].add(practice);
    } else {
      practices.cubeTypes[cubeType] = List<Practice>.of([practice]);
    }

    await save(practices);
    return practice;
  }

  Future<void> save(Practices practices) async {
    var file = await getFile();
    if (!file.existsSync()) {
      file.createSync();
    }
    file.writeAsString(jsonEncode(practices.toJson()));
  }

  Future<void> savePracticeList(
      List<Practice> practiceList, CubeType cubeType) async {
    var practices = await readAll();
    practices.cubeTypes[cubeType] = practiceList;

    await save(practices);
  }

  Future<void> savePractice(Practice practice) async {
    var practices = await readAll();
    practices.cubeTypes.values.forEach((practicesList) {
      practicesList
          .removeWhere((testPractice) => testPractice.id == practice.id);
      practicesList.add(practice);
    });

    await save(practices);
  }

  Future<File> getFile() async {
    var directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/practices.json');
  }
}
