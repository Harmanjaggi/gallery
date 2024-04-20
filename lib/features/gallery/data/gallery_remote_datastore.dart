import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:gallery/config/app_config.dart';
import 'package:gallery/config/failure.dart';
import 'package:gallery/features/gallery/data/gallery_response.dart';

class GalleryRemoteDatasource {
  final Dio dio = Dio();

  Future<Either<GalleryResponse, Failure>> getGalleryList(int page) async {
    try {
      final response = await dio.get('${AppConfig.baseUrl}&image_type=photo&page=$page');

      return left(GalleryResponse.fromJson(response.data));
    } catch (e) {
      return right(ServerFailure());
    }
  }
}
