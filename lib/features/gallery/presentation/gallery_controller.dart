import 'package:flutter/material.dart';
import 'package:gallery/features/gallery/data/gallery_response.dart';
import 'package:gallery/features/gallery/data/gallery_repository_impl.dart';
import 'package:get/get.dart';

class GalleryController extends GetxController {
  final GalleryRepositoryImpl repository = GalleryRepositoryImpl();
  final RxList<PictureData> galleryList = <PictureData>[].obs;
  final ScrollController scrollController = ScrollController();
  final GalleryListState galleryListStatus = GalleryListState();
  int pageIndex = 1;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  @override
  void onReady() {
    super.onReady();
    scrollController.addListener(scrollListener);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void scrollListener() {
    if (!galleryListStatus.isLoading.value) {
      if (!galleryListStatus.isLoadingMore.value && scrollController.offset >= scrollController.position.maxScrollExtent) {
        pageIndex += 1;
        getData(loadMore: true);
      }
    }
  }

  void getData({bool loadMore = false}) async {
    if (loadMore) {
      galleryListStatus.changeStatus(loadingMore: true, success: true);
    }
    final response = await repository.getGalleryList(page: loadMore ? pageIndex : 1);
    response.fold(
      (l) {
        if (!loadMore) galleryList.clear();
        galleryList.addAll(l.hits ?? <PictureData>[]);
        galleryListStatus.changeStatus(success: true);
      },
      (r) => galleryListStatus.changeStatus(error: true),
    );
  }
}

class GalleryListState {
  RxBool isLoading = true.obs;
  RxBool isSuccess = false.obs;
  RxBool isError = false.obs;
  RxBool isLoadingMore = false.obs;

  changeStatus({
    bool loading = false,
    bool success = false,
    bool error = false,
    bool loadingMore = false,
  }) {
    isLoading.value = loading;
    isSuccess.value = success;
    isError.value = error;
    isLoadingMore.value = loadingMore;
  }
}
