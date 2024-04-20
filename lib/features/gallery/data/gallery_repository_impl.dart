import 'package:dartz/dartz.dart';
import 'package:gallery/config/failure.dart';
import 'package:gallery/features/gallery/data/gallery_remote_datastore.dart';
import 'package:gallery/features/gallery/data/gallery_response.dart';
import 'package:gallery/features/gallery/domain/gallery_repository.dart';

class GalleryRepositoryImpl extends GalleryRepository {
  final GalleryRemoteDatasource _remoteDataSource = GalleryRemoteDatasource();

  @override
  Future<Either<GalleryResponse, Failure>> getGalleryList({required int page}) async {
    try {
      final response = await _remoteDataSource.getGalleryList(page);
      return response;
    } catch (e) {
      return right(GeneralFailure());
    }
  }
}
