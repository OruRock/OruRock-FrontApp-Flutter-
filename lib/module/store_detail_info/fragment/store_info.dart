import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/constant/style/style.dart';
import 'package:oru_rock/module/store_detail_info/store_info_controller.dart';
import 'package:oru_rock/model/store_model.dart' as storeModel;

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
          Row(
            children: [
              Image.asset(
                'asset/image/icon/address_icon.png',
                height: WidthWithRatio.small,
              ),
              const SizedBox(
                width: GapSize.xxSmall,
              ),
              Expanded(
                child: Text(
                  '${store?.storeAddr}',
                  style: const TextStyle(
                    fontFamily: "NotoR",
                    fontSize: FontSize.small,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.grey,
            height: HeightWithRatio.xxSmall,
          ),
          Row(
            children: [
              Image.asset(
                'asset/image/icon/phone_icon.png',
                height: WidthWithRatio.small,
              ),
              const SizedBox(
                width: GapSize.xxSmall,
              ),
              Text(
                '${store?.storePhone}',
                style: regularNanumDetailPageTextStyle,
              ),
            ],
          ),
          Divider(
            color: Colors.grey,
            height: HeightWithRatio.xxSmall,
          ),
          _buildInfoTile(
            imageUrl: 'asset/image/icon/timer_icon.png',
            title: "이용 시간",
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: WidthWithRatio.small),
                  child: Text(
                    '평일 : ${store?.storeOpentime}',
                    style: regularNanumTextStyle,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: WidthWithRatio.small),
                  child: Text(
                    '주말 : ${store?.storeOpentime}',
                    style: regularNanumTextStyle,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey,
            height: HeightWithRatio.xxSmall,
          ),
          _buildInfoTile(
            imageUrl: 'asset/image/icon/description_icon.png',
            title: "암장 설명",
            content: Padding(
              padding: EdgeInsets.only(left: WidthWithRatio.small),
              child: Text(
                '${store?.storeDescription}',
                style: regularNanumTextStyle,
              ),
            ),
          ),
          Divider(
            color: Colors.grey,
            height: HeightWithRatio.xxSmall,
          ),
          _buildInfoTile(
            imageUrl: 'asset/image/icon/money_icon.png',
            title: "이용 요금",
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                  controller.detailModel.value!.price!.length, (index) {
                return Padding(
                  padding: EdgeInsets.only(left: WidthWithRatio.small),
                  child: Text(
                    '${controller.detailModel.value!.price![index].priceDescription} : ${controller.detailModel.value!.price![index].price}',
                    style: regularNanumTextStyle,
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }

  _buildInfoTile(
      {required String imageUrl,
      required String title,
      required Widget content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(
              imageUrl,
              height: WidthWithRatio.small,
            ),
            const SizedBox(
              width: GapSize.xxSmall,
            ),
            Text(
              title,
              style: boldNanumTextStyle,
            ),
          ],
        ),
        const SizedBox(
          height: GapSize.xxSmall,
        ),
        content
      ],
    );
  }
}
