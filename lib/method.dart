

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

Dio dio = new Dio();

void diologger() {
  dio.interceptors.add(PrettyDioLogger());
// customization
  dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90));
}
String server_url = 'https://tiny-list.herokuapp.com';

Future<dynamic> cibpost(path, payload,
    {bool useToken = true,
      Function onSendProgress,
      Function onReceiveProgress}) async {
  var sharedPrefs = await SharedPreferences.getInstance();
  String authToken = await sharedPrefs.getString('access_token');
  print('POST to $server_url/$path');
  // dio.options.headers = {'Authorization': '$authToken'};
  // diologger();
  print('Payload $payload');
  var response;

  try {
    response = await dio
        .post('$server_url/$path',
        data: payload,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }))
        .then((response) {
      if (response.statusCode < 500) {
        print('Response for $path - $response');
        return {'status': response.statusCode, 'body': response.data};
      }

      return {
        'status': 500,
        'body': {'success': 'false', 'error': 'api call failed'},
      };
    });
  } catch (ex) {
    response = {
      'status': 500,
      'body': {
        'success': 'false',
        'error': 'API call failed - \n${ex.toString()}'
      },
    };
  }
  return response;
}


Future<dynamic> cibput(path, payload,
    {bool useToken = true,
      Function onSendProgress,
      Function onReceiveProgress}) async {
  var sharedPrefs = await SharedPreferences.getInstance();
  String authToken = await sharedPrefs.getString('access_token');

  print('PUT to $path');

  // dio.options.headers = {'Authorization': '$authToken'};
  // diologger();

  print('Payload $payload');

  var response;

  try {
    response = await dio
        .put('$server_url/$path',
        data: payload,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }))
        .then((response) {
      if (response.statusCode < 500) {
        print('Response for $path - $response');
        return {'status': response.statusCode, 'body': response.data};
      }

      return {
        'status': 500,
        'body': {'success': 'false', 'error': 'api call failed'},
      };
    });
  } catch (ex) {
    response = {
      'status': 500,
      'body': {
        'success': 'false',
        'error': 'API call failed - \n${ex.toString()}'
      },
    };
  }

  return response;
}

Future<dynamic> cibget(String path) async {
  if (path.isEmpty) {
    return {
      'status': 500,
      'body': {'success': 'false', 'error': 'api call failed'},
    };
  }

  var sharedPrefs = await SharedPreferences.getInstance();
  String authToken = await sharedPrefs.getString('access_token');

  print('GET to $path');

  // dio.options.headers = {'Authorization': '$authToken'};

  var response;

  try {
    response = dio
        .get('$server_url/$path',
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }))
        .then((response) {
      if (response.statusCode < 500) {
        print('Response for $path - $response');
        return {'status': response.statusCode, 'body': response.data};
      }
      return {
        'status': 500,
        'body': {'success': 'false', 'error': 'api call failed'},
      };
    });
  } on DioError catch (ex) {
    response = {
      'status': 500,
      'body': {'success': 'false', 'error': 'api call failed'},
    };
  }
  return response;
}
Future<dynamic> cibdelete(String path) async {
  if (path.isEmpty) {
    return {
      'status': 500,
      'body': {'success': 'false', 'error': 'api call failed'},
    };
  }

  var sharedPrefs = await SharedPreferences.getInstance();
  String authToken = await sharedPrefs.getString('access_token');

  print('GET to $path');

  // dio.options.headers = {'Authorization': '$authToken'};

  var response;

  try {
    response = dio
        .delete('$server_url/$path',
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }))
        .then((response) {
      if (response.statusCode < 500) {
        print('Response for $path - $response');
        return {'status': response.statusCode, 'body': response.data};
      }
      return {
        'status': 500,
        'body': {'success': 'false', 'error': 'api call failed'},
      };
    });
  } on DioError catch (ex) {
    response = {
      'status': 500,
      'body': {'success': 'false', 'error': 'api call failed'},
    };
  }
  return response;
}
