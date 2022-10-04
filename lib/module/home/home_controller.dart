import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:oru_rock/function/api_func.dart';
import 'package:oru_rock/model/store_model.dart';

class HomeController extends GetxController {
  var logger = Logger(
    printer: PrettyPrinter(),
  );
  final api = Get.find<ApiFunction>();

  var isPinned = true.obs;
  var stores = <StoreModel>[].obs;

  @override
  void onInit() async {
    await getStoreList();
    super.onInit();
  }

  Future<void> getStoreList() async {
    try {
      final res = await api.dio.get('/store/list');

      final List<dynamic>? data = res.data['payload']['result'];
      if (data != null) {
        stores.value = data.map((map) => StoreModel.fromJson(map)).toList();
      }
    } catch (e) {
      logger.e(e.toString());
    }
  }

}
