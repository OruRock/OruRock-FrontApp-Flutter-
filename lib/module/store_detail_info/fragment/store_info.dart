import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/constant/style/style.dart';
import 'package:oru_rock/model/store_model.dart' as storeModel;
import 'package:oru_rock/module/store_detail_info/store_info_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreInfoFragment extends GetView<StoreInfoController> {
  final storeModel.StoreModel? store;

  const StoreInfoFragment({
    required this.store,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            height: HeightWithRatio.xxxxSmall,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: GapSize.small, vertical: GapSize.medium),
            decoration: shadowBoxDecoration,
            child: Row(
              children: [
                Image.asset(
                  'asset/image/icon/address_icon.png',
                  height: WidthWithRatio.xSmall,
                ),
                const SizedBox(
                  width: GapSize.xxSmall,
                ),
                Expanded(
                  child: controller.setStoreAddrHandler(store?.storeAddr),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: GapSize.small,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: GapSize.small, vertical: GapSize.medium),
            decoration: shadowBoxDecoration,
            child: Row(
              children: [
                Image.asset(
                  'asset/image/icon/phone_icon.png',
                  height: WidthWithRatio.xSmall,
                ),
                const SizedBox(
                  width: GapSize.xxSmall,
                ),
                InkWell(
                  onTap: () => launchUrl(
                      Uri.parse('tel:${store?.storePhone}')
                  ),
                  child: Text(
                    '${store?.storePhone}',
                    style: regularEllipsisNanumTextStyle.apply(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: GapSize.small,
          ),
          _buildInfoTile(
            imageUrl: 'asset/image/icon/timer_icon.png',
            title: "이용 시간",
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                  controller.detailModel.value!.openTime!.length, (index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: GapSize.xxxSmall),
                  child: Text(
                    '${controller.detailModel.value!.openTime![index].dayName} : ${controller.detailModel.value!.openTime![index].openTime}',
                    style: regularEllipsisNanumTextStyle,
                  ),
                );
              }),
            ),
          ),
          const SizedBox(
            height: GapSize.small,
          ),
          _buildInfoTile(
            imageUrl: 'asset/image/icon/description_icon.png',
            title: "암장 설명",
            content: Text(
              '${store?.storeDescription}',
              style: regularClipNanumTextStyle,
            ),
          ),
          const SizedBox(
            height: GapSize.small,
          ),
          _buildInfoTile(
            imageUrl: 'asset/image/icon/money_icon.png',
            title: "이용 요금",
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                  controller.detailModel.value!.price!.length, (index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: GapSize.xxxSmall),
                  child: Text(
                    '${controller.detailModel.value!.price![index].priceDescription} : ${controller.detailModel.value!.price![index].price}',
                    style: regularEllipsisNanumTextStyle,
                  ),
                );
              }),
            ),
          ),
          SizedBox(
            height: HeightWithRatio.xxxxSmall,
          ),
        ],
      ),
    );
  }

  _buildInfoTile(
      {required String imageUrl,
      required String title,
      required Widget content}) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: GapSize.small, vertical: GapSize.medium),
      decoration: shadowBoxDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                imageUrl,
                height: WidthWithRatio.xSmall,
              ),
              const SizedBox(
                width: GapSize.xxSmall,
              ),
              Text(
                title,
                style: mediumNanumTextStyle,
              ),
            ],
          ),
          const SizedBox(
            height: GapSize.xxSmall,
          ),
          content
        ],
      ),
    );
  }
}
