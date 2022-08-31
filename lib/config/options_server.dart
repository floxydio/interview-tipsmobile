import 'package:dio/dio.dart';

class OptionsDio {
  static Options options() => Options(
        contentType: 'application/json',
        validateStatus: (status) => status! < 500,
        followRedirects: false,
      );
}
