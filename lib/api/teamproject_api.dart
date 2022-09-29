import 'package:dio/dio.dart';
import 'package:team_project/api/pages_images_api.dart';

class TeamProjectAPI {
  static TeamProjectAPI? _singleton;

  late PagesImgApi imgPages;
  Dio appDioClient = Dio();

  factory TeamProjectAPI() {
    _singleton ??= TeamProjectAPI._internal();
    return _singleton!;
  }

  TeamProjectAPI._internal() {
    // Init subclasses
    imgPages = PagesImgApi(appDioClient);
  }
}
