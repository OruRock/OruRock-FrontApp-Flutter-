import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/module/setting/setting_controller.dart';

class MyBookmarkList extends GetView<SettingController> {
  const MyBookmarkList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'My 즐겨찾기',
          ),
        ),
        body: Obx(
          () => ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.app.clientStoreBookMark.value.length,
            itemBuilder: (BuildContext context, int index) {
              return buildBookmarkList(index);
            },
          ),
        ),
      ),
    );
  }

  GestureDetector buildBookmarkList(int index) {
    return GestureDetector(
      onTap: () {
        controller.app.goMapToSelectedStoreAtBookMark(index);
      },
      child: ListTile(
        title: Text(controller.app.clientStoreBookMark[index].storeName!),
        subtitle: Text(controller.app.clientStoreBookMark[index].storePhone!),
      ),
    );
  }
}