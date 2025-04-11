import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:recipe_app/constants/api.dart';

class DioClient {
  static Dio createDio() {
    final options = BaseOptions(
      baseUrl: '$baseURL/api',
      followRedirects: false,
      headers: {
        'Accept': 'application/json',
      },
    );

    var dio = Dio(options);

    dio.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        maxWidth: 134,
      ),
    );
    return dio;
  }

  static final Dio instance = createDio();
}
