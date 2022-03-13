class TimeOffset {
  String rawOffset;
  late int offsetHours;
  late int offsetMins;

  TimeOffset({required this.rawOffset}) {
    getOffset(rawOffset);
  }

  void getOffset(String input) {
    offsetHours = int.parse(input.substring(0, 3));
    offsetMins = int.parse(input.substring(4, 6));
  }
}
