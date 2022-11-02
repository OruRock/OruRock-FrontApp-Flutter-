class StoreModel {
  int? storeId;
  String? imageUrl;
  String? storePhone;
  String? storeOpentime;
  int? recommendCnt;
  String? storeName;
  String? storeAddr;
  double? storeLng;
  int? bookmarkYn;
  double? storeLat;
  String? storeDescription;

  StoreModel(
      {this.storeId,
      this.imageUrl,
      this.storePhone,
      this.storeOpentime,
      this.recommendCnt,
      this.storeName,
      this.storeAddr,
      this.storeLng,
      this.bookmarkYn,
      this.storeLat,
      this.storeDescription});

  StoreModel.fromJson(Map<String, dynamic> json) {
    storeId = json['store_id'];
    imageUrl = json['image_url'];
    storePhone = json['store_phone'];
    storeOpentime = json['store_opentime'];
    recommendCnt = json['recommend_cnt'];
    storeName = json['store_name'];
    storeAddr = json['store_addr'];
    storeLng = json['store_lng'];
    bookmarkYn = json['bookmark_yn'];
    storeLat = json['store_lat'];
    storeDescription = json['store_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['store_id'] = storeId;
    data['image_url'] = imageUrl;
    data['store_phone'] = storePhone;
    data['store_opentime'] = storeOpentime;
    data['recommend_cnt'] = recommendCnt;
    data['store_name'] = storeName;
    data['store_addr'] = storeAddr;
    data['store_lng'] = storeLng;
    data['bookmark_yn'] = bookmarkYn;
    data['store_lat'] = storeLat;
    data['store_description'] = storeDescription;
    return data;
  }
}
