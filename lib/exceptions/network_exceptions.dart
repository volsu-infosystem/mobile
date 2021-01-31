import 'base_exception.dart';

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
  const ErrorStatusCode(
    String msg, [
    Exception previous,
  ]) : super(msg, previous);
}
