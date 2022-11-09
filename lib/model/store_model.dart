class StoreModel {
  int? storeId;
  String? imageUrl;
  String? storePhone;
  int? recommendCnt;
  String? storeName;
  String? storeAddr;
  double? storeLng;
  int? bookmarkYn;
  double? storeLat;
  String? storeUrl;
  String? storeNote;
  String? storePayType;
  String? storeDescription;

  StoreModel(
      {this.storeId,
      this.imageUrl,
      this.storePhone,
      this.recommendCnt,
      this.storeName,
      this.storeAddr,
      this.storeLng,
      this.bookmarkYn,
      this.storeLat,
      this.storeNote,
      this.storePayType,
      this.storeUrl,
      this.storeDescription});

  StoreModel.fromJson(Map<String, dynamic> json) {
    storeId = json['store_id'];
    imageUrl = json['image_url'];
    storePhone = json['store_phone'];
    recommendCnt = json['recommend_cnt'];
    storeName = json['store_name'];
    storeAddr = json['store_addr'];
    storeLng = json['store_lng'];
    bookmarkYn = json['bookmark_yn'];
    storeLat = json['store_lat'];
    storeNote = json['store_note'];
    storePayType = json['store_pay_type'];
    storeUrl = json['store_url'];
    storeDescription = json['store_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['store_id'] = storeId;
    data['image_url'] = imageUrl;
    data['store_phone'] = storePhone;
    data['recommend_cnt'] = recommendCnt;
    data['store_name'] = storeName;
    data['store_addr'] = storeAddr;
    data['store_lng'] = storeLng;
    data['bookmark_yn'] = bookmarkYn;
    data['store_lat'] = storeLat;
    data['store_note'] = storeNote;
    data['store_pay_type'] = storePayType;
    data['store_url'] = storeUrl;
    data['store_description'] = storeDescription;
    return data;
  }
}
