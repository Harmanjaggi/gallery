class GalleryResponse {
  int? total;
  int? totalHits;
  List<PictureData>? hits;

  GalleryResponse({this.total, this.totalHits, this.hits});

  GalleryResponse.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    totalHits = json['totalHits'];
    hits = (json['hits'] as List).map((gallery) => PictureData.fromJson(gallery)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['totalHits'] = totalHits;
    data['hits'] = hits;
    return data;
  }
}

class PictureData {
  int? id;
  int? likes;
  int? views;
  String? imageUrl;
  String? previewImageUrl;

  PictureData({this.id, this.likes, this.views, this.imageUrl, this.previewImageUrl});

  PictureData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    likes = json['likes'];
    views = json['views'];
    imageUrl = json['largeImageURL'];
    previewImageUrl = json['webformatURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['likes'] = likes;
    data['views'] = views;
    data['largeImageURL'] = imageUrl;
    data['webformatURL'] = previewImageUrl;
    return data;
  }
}
