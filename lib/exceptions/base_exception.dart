class BaseException implements Exception {
  final String tag;
  final String msg;
  final Exception previous;

  const BaseException(
    this.tag,
    this.msg, [
    this.previous,
  ]);

  @override
  String toString() => "$tag: $msg\n>>>>${previous.toString()}";
}
