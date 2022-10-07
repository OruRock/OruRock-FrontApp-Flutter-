class StoreModel {
  int? storeId;
  String? storePhone;
  String? storeOpentime;
  int? recommendCnt;
  String? stroreName;
  String? storeAddr;
  String? storeLag;
  int? bookmarkYn;
  String? storeLat;
  String? storeDescription;

  StoreModel(
      {this.storeId,
        this.storePhone,
        this.storeOpentime,
        this.recommendCnt,
        this.stroreName,
        this.storeAddr,
        this.storeLag,
        this.bookmarkYn,
        this.storeLat,
        this.storeDescription});

  StoreModel.fromJson(Map<String, dynamic> json) {
    storeId = json['store_id'];
    storePhone = json['store_phone'];
    storeOpentime = json['store_opentime'];
    recommendCnt = json['recommend_cnt'];
    stroreName = json['strore_name'];
    storeAddr = json['store_addr'];
    storeLag = json['store_lag'];
    bookmarkYn = json['bookmark_yn'];
    storeLat = json['store_lat'];
    storeDescription = json['store_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['store_id'] = storeId;
    data['store_phone'] = storePhone;
    data['store_opentime'] = storeOpentime;
    data['recommend_cnt'] = recommendCnt;
    data['strore_name'] = stroreName;
    data['store_addr'] = storeAddr;
    data['store_lag'] = storeLag;
    data['bookmark_yn'] = bookmarkYn;
    data['store_lat'] = storeLat;
    data['store_description'] = storeDescription;
    return data;
  }
}
