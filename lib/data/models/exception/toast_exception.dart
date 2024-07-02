import 'package:flutter_bloc_base/data/models/annotation/exception_type.dart';
import 'package:flutter_bloc_base/data/models/exception/base_exception.dart';

class ToastException extends BaseException {
  ToastException(int code, String message)
      : super(code, message, ExceptionType.toast);
}
