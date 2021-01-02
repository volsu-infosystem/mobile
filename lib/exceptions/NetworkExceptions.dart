import 'BaseException.dart';

class InvalidPassCode extends BaseException {
  const InvalidPassCode(String msg) : super("InvalidPassCode: ", msg);
}

class ServerError extends BaseException {
  const ServerError(String msg) : super("ServerError: ", msg);
}

class EmailNotAllowed extends BaseException {
  const EmailNotAllowed(String msg) : super("EmailNotAllowed: ", msg);
}
