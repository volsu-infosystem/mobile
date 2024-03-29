import 'package:volsu_app_v1/exceptions/base_exception.dart';

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

class ThereIsNoWayItCanBeReached extends LogicException {
  const ThereIsNoWayItCanBeReached(
    String msg, [
    Exception previous,
  ]) : super("ThereIsNoWayItCanBeDone", msg, previous);
}
