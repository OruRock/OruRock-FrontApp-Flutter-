import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:oru_rock/constant/style/style.dart';
import 'package:oru_rock/module/setting/setting_controller.dart';
import '../../constant/style/size.dart';

class BookmarkList extends GetView<SettingController> {
  const BookmarkList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'My 즐겨찾기',
              style: TextStyle(
                fontFamily: "NoteB",
                fontSize: FontSize.xLarge,
                height: 1,
                color: Colors.black),
            ),
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            backgroundColor: Colors.white,
            elevation: 1,
          ),
            body: ListView(
                children: [
                  Obx(
                        () => Expanded(
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            // itemCount: controller.clientStoreBookMark.value.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                  onTap: () {
                                    // controller.goMapToSelectedStoreAtBookMark(index);
                                    },
                                  child: ListTile(
                                    // title: Text(controller.clientStoreBookMark[index].storeName!),
                                    // subtitle: Text(controller.clientStoreBookMark[index].storePhone!),
                                  ),
                              );
                            },
                          ),
                        ),
                  ),
                ],
            )
        ),
    );
  }
}