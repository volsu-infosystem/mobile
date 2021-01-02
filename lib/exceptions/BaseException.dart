class BaseException implements Exception {
  final String prefix;
  final String msg;
  const BaseException(this.prefix, this.msg);

  @override
  String toString() => "$prefix$msg";
}
