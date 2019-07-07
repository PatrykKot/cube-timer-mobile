import 'package:cube_timer/app/scramble/dto/Scramble.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;

const BASE_URL = "www.worldcubeassociation.org";

class ScrambleService {
  var cachedScrambles = List<Scramble>();

  Future<Scramble> fetch() async {
    if(cachedScrambles.isEmpty)
      {
        await _fetchAndCache();
      }

    var result = cachedScrambles[0];
    cachedScrambles.remove(result);
    return result;
  }

  // TODO not working. Do it programmatically
  Future _fetchAndCache() async {
    var document = parse(await _fetchRaw());
    var table = document.getElementsByTagName("tbody")[0];
    var rows = table.children;
    rows.removeAt(0);

    cachedScrambles.addAll(rows.map((row) {
      var columns = row.getElementsByTagName("tr");
      var scramble = columns[1].text;

      return Scramble(scramble);
    }));
  }

  Future<String> _fetchRaw() async {
    var params = Map<String, String>.from({
      "size": 3.toString(),
      "num": 10.toString(),
      "len": 30.toString(),
      "col": 'yobwrg',
      "subbutton": 'Scramble!'
    });
    var url = Uri.https(BASE_URL,
        "/regulations/history/files/scrambles/scramble_cube.htm", params);

    var response = await http.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
          "Failed to load scrambles. Status code ${response.statusCode}");
    }
  }
}
