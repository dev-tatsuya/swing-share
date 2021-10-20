String trimLastBlankLine(String s) {
  if (s.isEmpty) {
    return '';
  }

  if (!s.contains('\n')) {
    return s;
  }

  final lines = s.split('\n');
  final finalIndex = lines.lastIndexWhere((e) => e.isNotEmpty);
  return lines.take(finalIndex + 1).join('\n');
}
