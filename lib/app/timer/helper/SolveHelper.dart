class SolveHelper {
  static String formatDuration(int duration) {
    var seconds = (duration / 1000).floor();
    var milis = duration - seconds * 1000;

    return seconds.toString() + "." + milis.toString().padLeft(3, '0');
  }
}