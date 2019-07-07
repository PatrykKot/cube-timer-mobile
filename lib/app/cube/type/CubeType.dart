enum CubeType {
  CUBE_3x3
}

class CubeTypeHelper {
  static String getText(CubeType type) {
    switch (type) {
      case CubeType.CUBE_3x3:
        return '3x3x3';
      default:
        throw Exception();
    }
  }
}