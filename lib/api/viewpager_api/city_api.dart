import 'package:dio/dio.dart';

import '../../models/img_model.dart';

class CityImgApi {
  final Dio appDioClient;
  final String _HEADER_AUTH = 'Authorization';
  final String _YOUR_KEY = 'Bearer 563492ad6f917000010000017806ce8e64d041ef93deaf9be7e08a4b';

  CityImgApi(
    this.appDioClient,
  );

  Future<ImgModel> getCityPhotosData() async {
    ImgModel imgData;

    final result = await appDioClient.get(
      'https://api.pexels.com//v1/search?query=city',
      options: Options(headers: {_HEADER_AUTH: _YOUR_KEY})
    );

    var res = result.data as Map<String, dynamic>;
    imgData = ImgModel.fromJson(res);

    return imgData;
  }

}
