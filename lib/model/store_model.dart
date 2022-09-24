class StoreModel {
  int? storeId;
  String? storePhone;
  String? storeOpentime;
  int? recommendCnt;
  String? stroreName;
  String? storeAddr;
  int? useYn;
  String? storeLag;
  String? createDate;
  String? updateDate;
  String? storeLat;
  String? storeDescription;

  StoreModel(
      {this.storeId,
        this.storePhone,
        this.storeOpentime,
        this.recommendCnt,
        this.stroreName,
        this.storeAddr,
        this.useYn,
        this.storeLag,
        this.createDate,
        this.updateDate,
        this.storeLat,
        this.storeDescription});

  StoreModel.fromJson(Map<String, dynamic> json) {
    storeId = json['store_id'];
    storePhone = json['store_phone'];
    storeOpentime = json['store_opentime'];
    recommendCnt = json['recommend_cnt'];
    stroreName = json['strore_name'];
    storeAddr = json['store_addr'];
    useYn = json['use_yn'];
    storeLag = json['store_lag'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
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
    data['use_yn'] = useYn;
    data['store_lag'] = storeLag;
    data['create_date'] = createDate;
    data['update_date'] = updateDate;
    data['store_lat'] = storeLat;
    data['store_description'] = storeDescription;
    return data;
  }
}
