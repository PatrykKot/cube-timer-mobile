enum CubeType {
  CUBE_2x2x2,
  CUBE_3x3x3,
  CUBE_4x4x4,
  CUBE_5x5x5,
  CUBE_6x6x6,
  CUBE_7x7x7
}

class CubeTypeHelper {
  static String getText(CubeType type) {
    return type.toString().split('.').last.replaceAll("CUBE_", "");
  }
}
