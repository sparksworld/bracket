import '/plugins.dart';
import '/service/http_util.dart';

class Api {
  static Future index({Map<String, dynamic>? queryParameters}) {
    return HttpUtil().get('index', queryParameters: queryParameters);
  }

  static Future filmDetail({Map<String, dynamic>? queryParameters}) {
    return HttpUtil().get('filmDetail', queryParameters: queryParameters);
  }

  static Future searchFilm({Map<String, dynamic>? queryParameters}) {
    return HttpUtil().get('searchFilm', queryParameters: queryParameters);
  }

  static Future filmClassifySearch({Map<String, dynamic>? queryParameters}) {
    return HttpUtil()
        .get('filmClassifySearch', queryParameters: queryParameters);
  }
}
