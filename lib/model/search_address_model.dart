
import 'dart:convert';

SearchAddressModel searchAddressModelFromJson(String str) => SearchAddressModel.fromJson(json.decode(str));

String searchAddressModelToJson(SearchAddressModel data) => json.encode(data.toJson());

class SearchAddressModel {
  SearchAddressModel({
    required this.results,
  });

  Results? results;

  factory SearchAddressModel.fromJson(Map<String, dynamic> json) => SearchAddressModel(
    results: Results.fromJson(json["results"]),
  );

  Map<String, dynamic> toJson() => {
    "results": results!.toJson(),
  };
}

class Results {
  Results({
    required this.common,
    required this.juso,
  });

  Common common;
  List<Juso>? juso;

  factory Results.fromJson(Map<String, dynamic> json) => Results(
    common: Common.fromJson(json["common"]),
    juso: List<Juso>.from(json["juso"].map((x) => Juso.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "common": common.toJson(),
    "juso": List<dynamic>.from(juso!.map((x) => x.toJson())),
  };
}

class Common {
  Common({
    required this.totalCount,
    required this.currentPage,
    required this.countPerPage,
    required this.errorCode,
    required this.errorMessage,
  });

  String totalCount;
  String currentPage;
  String countPerPage;
  String errorCode;
  String errorMessage;

  factory Common.fromJson(Map<String, dynamic> json) => Common(
    totalCount: json["totalCount"],
    currentPage: json["currentPage"],
    countPerPage: json["countPerPage"],
    errorCode: json["errorCode"],
    errorMessage: json["errorMessage"],
  );

  Map<String, dynamic> toJson() => {
    "totalCount": totalCount,
    "currentPage": currentPage,
    "countPerPage": countPerPage,
    "errorCode": errorCode,
    "errorMessage": errorMessage,
  };
}

class Juso {
  Juso({
    required this.roadAddr,
    required this.roadAddrPart1,
    required this.roadAddrPart2,
    required this.jibunAddr,
    required this.engAddr,
    required this.zipNo,
    required this.admCd,
    required this.rnMgtSn,
    required this.bdMgtSn,
    required this.detBdNmList,
    required this.bdNm,
    required this.bdKdcd,
    required this.siNm,
    required this.sggNm,
    required this.emdNm,
    required this.liNm,
    required this.rn,
    required this.udrtYn,
    required this.buldMnnm,
    required this.buldSlno,
    required this.mtYn,
    required this.lnbrMnnm,
    required this.lnbrSlno,
    required this.emdNo,
    required this.hstryYn,
    required this.relJibun,
    required this.hemdNm,
  });

  String roadAddr;
  String roadAddrPart1;
  String? roadAddrPart2;
  String jibunAddr;
  String engAddr;
  String zipNo;
  String admCd;
  String rnMgtSn;
  String bdMgtSn;
  String? detBdNmList;
  String? bdNm;
  String bdKdcd;
  String siNm;
  String sggNm;
  String emdNm;
  String? liNm;
  String rn;
  String udrtYn;
  String buldMnnm;
  String buldSlno;
  String mtYn;
  String lnbrMnnm;
  String lnbrSlno;
  String emdNo;
  String? hstryYn;
  String? relJibun;
  String? hemdNm;

  factory Juso.fromJson(Map<String, dynamic> json) => Juso(
    roadAddr: json["roadAddr"],
    roadAddrPart1: json["roadAddrPart1"],
    roadAddrPart2: json["roadAddrPart2"],
    jibunAddr: json["jibunAddr"],
    engAddr: json["engAddr"],
    zipNo: json["zipNo"],
    admCd: json["admCd"],
    rnMgtSn: json["rnMgtSn"],
    bdMgtSn: json["bdMgtSn"],
    detBdNmList: json["detBdNmList"],
    bdNm: json["bdNm"],
    bdKdcd: json["bdKdcd"],
    siNm: json["siNm"],
    sggNm: json["sggNm"],
    emdNm: json["emdNm"],
    liNm: json["liNm"],
    rn: json["rn"],
    udrtYn: json["udrtYn"],
    buldMnnm: json["buldMnnm"],
    buldSlno: json["buldSlno"],
    mtYn: json["mtYn"],
    lnbrMnnm: json["lnbrMnnm"],
    lnbrSlno: json["lnbrSlno"],
    emdNo: json["emdNo"],
    hstryYn: json["hstryYn"],
    relJibun: json["relJibun"],
    hemdNm: json["hemdNm"],
  );

  Map<String, dynamic> toJson() => {
    "roadAddr": roadAddr,
    "roadAddrPart1": roadAddrPart1,
    "roadAddrPart2": roadAddrPart2,
    "jibunAddr": jibunAddr,
    "engAddr": engAddr,
    "zipNo": zipNo,
    "admCd": admCd,
    "rnMgtSn": rnMgtSn,
    "bdMgtSn": bdMgtSn,
    "detBdNmList": detBdNmList,
    "bdNm": bdNm,
    "bdKdcd": bdKdcd,
    "siNm": siNm,
    "sggNm": sggNm,
    "emdNm": emdNm,
    "liNm": liNm,
    "rn": rn,
    "udrtYn": udrtYn,
    "buldMnnm": buldMnnm,
    "buldSlno": buldSlno,
    "mtYn": mtYn,
    "lnbrMnnm": lnbrMnnm,
    "lnbrSlno": lnbrSlno,
    "emdNo": emdNo,
    "hstryYn": hstryYn,
    "relJibun": relJibun,
    "hemdNm": hemdNm,
  };
}
