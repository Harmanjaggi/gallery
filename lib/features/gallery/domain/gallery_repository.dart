
import 'package:dartz/dartz.dart';
import 'package:gallery/config/failure.dart';
import 'package:gallery/features/gallery/data/gallery_response.dart';

abstract class GalleryRepository {
  Future<Either<GalleryResponse, Failure>> getGalleryList({required int page});
}