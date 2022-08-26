import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:oru_rock/model/search_address_model.dart';
import 'package:oru_rock/module/naver_map/nmap_controller.dart';
import 'package:proj4dart/proj4dart.dart' as proj4;

class SearchAddressController extends GetxController {
  final dio = Dio();
  final mapController = Get.find<NMapController>();

  SearchAddressModel? searchAddressModel;
  var addressData = <Juso>[].obs;

  var editAddress = TextEditingController();
  var editAddressFocus = FocusNode();

  @override
  void onInit() async {
    editAddress.addListener(addressListener);
  }

  void addressListener() async {
    if (addressValidator(editAddress.text)) {
      await getSearchAddressData(editAddress.text);
    }
  }

  Future<void> getSearchAddressData(String keyword) async {
    final data = {
      "confmKey": "devU01TX0FVVEgyMDIyMDgxMDE2MDcyNTExMjg2NzU=",
      "currentPage": 1,
      "countPerPage": 40,
      "keyword": keyword,
      "resultType": "json",
    };

    final res = await dio.post("https://business.juso.go.kr/addrlink/addrLinkApi.do",
        queryParameters: data);

    if (res.data['results']['common']['errorCode'] == "0") {
      searchAddressModel = SearchAddressModel.fromJson(res.data);
    } else {
      return;
    }

    final List<dynamic>? jusoDataList =
        searchAddressModel?.results?.toJson()['juso'];

    if (jusoDataList != null) {
      if (jusoDataList.isNotEmpty) {
        addressData.value =
            jusoDataList.map((map) => Juso.fromJson(map)).toList();
      }
    }
  }

  bool addressValidator(String address) {
    final validationList = [
      "OR",
      "SELECT",
      "INSERT",
      "DELETE",
      "UPDATE",
      "CREATE",
      "DROP",
      "EXEC",
      "UNION",
      "FETCH",
      "DECLARE",
      "TRUNCATE"
    ];

    if (address.length < 2) {
      return false;
    }
    if (address.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return false;
    }
    for (var val in validationList) {
      if (address.contains(val)) {
        return false;
      }
    }

    return true;
  }

  Future<void> goToMapWithAddress({required String admCd, required String rnMgtSn, required String udrtYn, required String buldMnnm, required String buldSlno}) async {
    final data = {
      "confmKey": "U01TX0FVVEgyMDIyMDgwNTE3MDYyNzExMjg1NTk=",
      "admCd": admCd,
      "rnMgtSn": rnMgtSn,
      "udrtYn": udrtYn,
      "buldMnnm": buldMnnm,
      "buldSlno": buldSlno,
      "resultType": "json",
    };

    final res = await dio.post("https://business.juso.go.kr/addrlink/addrCoordApi.do",
        queryParameters: data);
    print(res.data.toString());
    final entX = double.parse(res.data['results']['juso'][0]['entX']);
    final entY = double.parse(res.data['results']['juso'][0]['entY']);

    final coord_X = (entX * 1000000).round()/ 1000000;
    final coord_Y = (entY * 1000000).round()/ 1000000;

    var pointDst = proj4.Point(x: coord_X, y: coord_Y);
    var projSrc = proj4.Projection.get('EPSG:4326')!;
    var projDst = proj4.Projection.get('EPSG:23700') ?? proj4.Projection.add(
      'EPSG:23700',
      '+proj=tmerc +lat_0=38 +lon_0=127.5 +k=0.9996 +x_0=1000000 +y_0=2000000 +ellps=GRS80 +units=m +no_defs',
    );
    var point = projDst.transform(projSrc, pointDst);
    print(point.toArray());
    final LatLng position = LatLng(point.y, point.x);
    mapController.goToSelectedLocation(position);
    Get.back();
  }

}
