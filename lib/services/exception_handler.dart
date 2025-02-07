import 'dart:async';
import 'dart:io';

import 'package:assignment/services/app_exceptions.dart';

class ExceptionHandler {
  static getExceptionString(error) {
    if (error is SocketException) {
      return "No internet connection.";
    } else if (error is HttpException) {
      return "HTTP error occured.";
    } else if (error is FormatException) {
      return "Invalid data format";
    } else if (error is TimeoutException) {
      return "Request time out.";
    } else if (error is BadRequestException) {
      return error.message.toString();
    } else if (error is UnAuthorizedException) {
      return error.message.toString();
    } else if (error is NotFoundException) {
      return error.message.toString();
    } else if (error is FetchDataException) {
      return error.message.toString();
    } else {
      return "Unknown error occured.";
    }
  }
}
