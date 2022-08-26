class GeocodingModel {
  String? status;
  Meta? meta;
  List<Addresses>? addresses;
  String? errorMessage;

  GeocodingModel({this.status, this.meta, this.addresses, this.errorMessage});

  GeocodingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses!.add(Addresses.fromJson(v));
      });
    }
    errorMessage = json['errorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    if (addresses != null) {
      data['addresses'] = addresses!.map((v) => v.toJson()).toList();
    }
    data['errorMessage'] = errorMessage;
    return data;
  }
}

class Meta {
  int? totalCount;
  int? page;
  int? count;

  Meta({this.totalCount, this.page, this.count});

  Meta.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    page = json['page'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalCount'] = totalCount;
    data['page'] = page;
    data['count'] = count;
    return data;
  }
}

class Addresses {
  String? roadAddress;
  String? jibunAddress;
  String? englishAddress;
  List<AddressElements>? addressElements;
  String? x;
  String? y;
  double? distance;

  Addresses(
      {this.roadAddress,
      this.jibunAddress,
      this.englishAddress,
      this.addressElements,
      this.x,
      this.y,
      this.distance});

  Addresses.fromJson(Map<String, dynamic> json) {
    roadAddress = json['roadAddress'];
    jibunAddress = json['jibunAddress'];
    englishAddress = json['englishAddress'];
    if (json['addressElements'] != null) {
      addressElements = <AddressElements>[];
      json['addressElements'].forEach((v) {
        addressElements!.add(AddressElements.fromJson(v));
      });
    }
    x = json['x'];
    y = json['y'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['roadAddress'] = roadAddress;
    data['jibunAddress'] = jibunAddress;
    data['englishAddress'] = englishAddress;
    if (addressElements != null) {
      data['addressElements'] =
          addressElements!.map((v) => v.toJson()).toList();
    }
    data['x'] = x;
    data['y'] = y;
    data['distance'] = distance;
    return data;
  }
}

class AddressElements {
  List<String>? types;
  String? longName;
  String? shortName;
  String? code;

  AddressElements({this.types, this.longName, this.shortName, this.code});

  AddressElements.fromJson(Map<String, dynamic> json) {
    types = json['types'].cast<String>();
    longName = json['longName'];
    shortName = json['shortName'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['types'] = types;
    data['longName'] = longName;
    data['shortName'] = shortName;
    data['code'] = code;
    return data;
  }
}
