import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:oru_rock/constant/style/style.dart';
import 'package:oru_rock/module/search_address/search_address_controller.dart';

class SearchAddress extends GetView<SearchAddressController> {
  const SearchAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: mainAppBar,
        body: Column(
          children: [
            SizedBox(
              height: 72.0,
              child: TextField(
                controller: controller.editAddress,
                focusNode: controller.editAddressFocus,
                style: const TextStyle(
                    fontSize: 14.0, fontFamily: 'NotoSansKR-Medium'),
                decoration: const InputDecoration(
                  hintText: '주소를 입력해주세요.',
                  hintStyle: TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'NotoSansKR-Medium',
                      color: Colors.grey),
                  contentPadding: EdgeInsets.zero,
                  filled: false,
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  disabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                ),
              ),
            ),
            Obx(
              () => Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(
                          "도로명 : ${controller.addressData.value[index].roadAddr}"),
                      subtitle: Text(
                          "지번 : ${controller.addressData.value[index].jibunAddr}"),
                      onTap: () {
                        controller.goToMapWithAddress(
                            admCd: controller.addressData.value[index].admCd,
                            rnMgtSn:
                                controller.addressData.value[index].rnMgtSn,
                            udrtYn: controller.addressData.value[index].udrtYn,
                            buldMnnm:
                                controller.addressData.value[index].buldMnnm,
                            buldSlno:
                                controller.addressData.value[index].buldSlno);
                      },
                    );
                  },
                  scrollDirection: Axis.vertical,
                  itemCount: controller.addressData.length,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
