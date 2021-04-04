import 'package:volsu_app_v1/exceptions/base_exception.dart';

class NetworkException extends BaseException {
  const NetworkException(
    String msg, [
    Exception previous,
  ]) : super("NetworkException", msg, previous);
}

class ConnectionFailure extends NetworkException {
  const ConnectionFailure(
    String msg, [
    Exception previous,
  ]) : super(msg, previous);
}

class ErrorStatusCode extends NetworkException {
  final int code;

  const ErrorStatusCode(
    String msg,
    this.code, [
    Exception previous,
  ]) : super(msg, previous);
}

class NotAuthenticated extends NetworkException {
  const NotAuthenticated(
    String msg, [
    Exception previous,
  ]) : super(msg, previous);
}
