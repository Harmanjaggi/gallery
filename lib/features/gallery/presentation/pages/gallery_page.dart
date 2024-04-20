import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gallery/features/gallery/presentation/pages/full_image_view.dart';
import 'package:gallery/features/gallery/presentation/gallery_controller.dart';
import 'package:get/get.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
          init: GalleryController(),
          builder: (controller) {
            return LayoutBuilder(builder: (context, constraint) {
              return CustomScrollView(
                  controller: controller.scrollController,
                  slivers: [
                    const SliverAppBar(
                      floating: true,
                      title: Text(
                        "Gallery",
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      centerTitle: true,
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 32)),
                    Obx(() {
                      if (controller.galleryListStatus.isLoading.value) {
                        return SliverToBoxAdapter(
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(top: 30),
                            child: const CircularProgressIndicator(),
                          ),
                        );
                      } else if (controller.galleryListStatus.isSuccess.value) {
                        return Obx(() {
                          return SliverPadding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            sliver: SliverGrid.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: constraint.maxWidth ~/ 250,
                                mainAxisSpacing: 16.0,
                                crossAxisSpacing: 16.0,
                              ),
                              itemCount: controller.galleryList.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.blueGrey,
                                  ),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (_) {
                                              return FullImageView(controller
                                                  .galleryList[index]);
                                            }));
                                          },
                                          child: Hero(
                                            tag: controller
                                                    .galleryList[index].id ??
                                                0,
                                            child: _customImage(controller
                                                .galleryList[index].imageUrl),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 8),
                                        child: Row(
                                          children: [
                                            const Icon(
                                                Icons.remove_red_eye_rounded),
                                            const SizedBox(width: 6),
                                            Text(
                                              (controller.galleryList[index]
                                                          .views ??
                                                      0)
                                                  .toString(),
                                            ),
                                            const Spacer(),
                                            const Icon(Icons.thumb_up),
                                            const SizedBox(width: 6),
                                            Text(
                                              (controller.galleryList[index]
                                                          .likes ??
                                                      0)
                                                  .toString(),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        });
                      } else {
                        return SliverToBoxAdapter(
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(top: 30),
                            child: const Text(
                              "Error",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        );
                      }
                    }),
                    const SliverToBoxAdapter(child: SizedBox(height: 32)),
                  ]);
            });
          }),
    );
  }

  Widget _customImage(String? url) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
      child: CachedNetworkImage(
        imageUrl: url ?? "",
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        errorWidget: (context, url, error) => const Center(
          child: Icon(Icons.error),
        ),
      ),
    );
  }
}
