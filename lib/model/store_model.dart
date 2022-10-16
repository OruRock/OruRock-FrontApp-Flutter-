class StoreModel {
  int? storeId;
  List<Image>? image;
  String? storePhone;
  String? storeOpentime;
  int? recommendCnt;
  String? stroreName;
  String? storeAddr;
  double? storeLng;
  int? bookmarkYn;
  double? storeLat;
  String? storeDescription;

  StoreModel(
      {this.storeId,
      this.image,
      this.storePhone,
      this.storeOpentime,
      this.recommendCnt,
      this.stroreName,
      this.storeAddr,
      this.storeLng,
      this.bookmarkYn,
      this.storeLat,
      this.storeDescription});

  StoreModel.fromJson(Map<String, dynamic> json) {
    storeId = json['store_id'];
    if (json['image'] != null) {
      image = <Image>[];
      json['image'].forEach((v) {
        image!.add(Image.fromJson(v));
      });
    }
    storePhone = json['store_phone'];
    storeOpentime = json['store_opentime'];
    recommendCnt = json['recommend_cnt'];
    stroreName = json['strore_name'];
    storeAddr = json['store_addr'];
    storeLng = json['store_lng'];
    bookmarkYn = json['bookmark_yn'];
    storeLat = json['store_lat'];
    storeDescription = json['store_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['store_id'] = storeId;
    if (image != null) {
      data['image'] = image!.map((v) => v.toJson()).toList();
    }
    data['store_phone'] = storePhone;
    data['store_opentime'] = storeOpentime;
    data['recommend_cnt'] = recommendCnt;
    data['strore_name'] = stroreName;
    data['store_addr'] = storeAddr;
    data['store_lng'] = storeLng;
    data['bookmark_yn'] = bookmarkYn;
    data['store_lat'] = storeLat;
    data['store_description'] = storeDescription;
    return data;
  }
}

class Image {
  String? imageUrl;
  int? imageId;

  Image({this.imageUrl, this.imageId});

  Image.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image_url'];
    imageId = json['image_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image_url'] = imageUrl;
    data['image_id'] = imageId;
    return data;
  }
}
