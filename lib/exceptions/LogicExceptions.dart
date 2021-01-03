import 'BaseException.dart';

class LogicException extends BaseException {
  const LogicException(
    String tag,
    String msg, [
    Exception previous,
  ]) : super("LogicException/$tag", msg, previous);
}

class InvalidPassCode extends LogicException {
  const InvalidPassCode(
    String msg, [
    Exception previous,
  ]) : super("InvalidPassCode", msg, previous);
}

class EmailIsNotInWhiteList extends LogicException {
  const EmailIsNotInWhiteList(
    String msg, [
    Exception previous,
  ]) : super("EmailIsNotInWhiteList", msg, previous);
}
