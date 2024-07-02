import 'package:flutter_bloc_base/data/models/annotation/exception_type.dart';
import 'package:flutter_bloc_base/data/models/exception/alert_exception.dart';
import 'package:flutter_bloc_base/data/models/exception/base_exception.dart';
import 'package:flutter_bloc_base/data/models/exception/inline_exception.dart';
import 'package:flutter_bloc_base/data/models/exception/toast_exception.dart';
import 'package:flutter_bloc_base/ui/utils/dialog_utils.dart';
import 'package:flutter_bloc_base/ui/widget/app_navigator.dart';

mixin BlocMixin {
  void setLoading() {
    DialogUtils.showLoading();
  }

  void hideLoading() {
    DialogUtils.hideLoading();
  }

  void setThrowable(dynamic throwable) {
    if (throwable is BaseException) {
      switch (throwable.exceptionType) {
        case ExceptionType.toast:
          final e = throwable as ToastException;
          DialogUtils.showAlert(
            AppNavigator.currentContext,
            message: e.message,
          );
        case ExceptionType.alert:
          final e = throwable as AlertException;
          DialogUtils.showAlert(
            AppNavigator.currentContext,
            message: e.message,
          );
        case ExceptionType.inline:
          final e = throwable as InlineException;
          DialogUtils.showAlert(
            AppNavigator.currentContext,
            message: e.message,
          );
      }
    } else {
      DialogUtils.showAlert(
        AppNavigator.currentContext,
        message: 'Error',
      );
    }
  }
}
