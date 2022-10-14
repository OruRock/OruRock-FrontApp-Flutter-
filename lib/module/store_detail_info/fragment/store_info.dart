
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/constant/style/style.dart';
import 'package:oru_rock/module/store_detail_info/store_info_controller.dart';
import 'package:oru_rock/model/store_detail_model.dart' as detailModel;
import 'package:oru_rock/model/store_model.dart' as storeModel;

class StoreInfoFragment extends GetView<StoreInfoController>{
  final storeModel.StoreModel? store;
  final detailModel.StoreReviewModel? review;

  StoreInfoFragment({
    required this.store,
    required this.review,
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
              Text(
                '${store?.storeAddr}',
                style: regularNanumDetailPageTextStyle,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    'asset/image/icon/timer_icon.png',
                    height: WidthWithRatio.small,
                  ),
                  const SizedBox(
                    width: GapSize.xxSmall,
                  ),
                  const Text(
                    '이용 시간',
                    style: boldNanumTextStyle,
                  ),
                ],
              ),
              const SizedBox(
                height: GapSize.xxSmall,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: WidthWithRatio.small),
                child: Text(
                  '평일 : ${store?.storeOpentime}',
                  style: regularNanumTextStyle,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: WidthWithRatio.small),
                child: Text(
                  '주말 : ${store?.storeOpentime}',
                  style: regularNanumTextStyle,
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.grey,
            height: HeightWithRatio.xxSmall,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    'asset/image/icon/description_icon.png',
                    height: WidthWithRatio.small,
                  ),
                  const SizedBox(
                    width: GapSize.xxSmall,
                  ),
                  const Text(
                    '설명',
                    style: boldNanumTextStyle,
                  ),
                ],
              ),
              const SizedBox(
                height: GapSize.xxSmall,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: WidthWithRatio.small),
                child: Text(
                  '${store?.storeDescription}',
                  style: regularNanumTextStyle,
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.grey,
            height: HeightWithRatio.xxSmall,
          ),
        ],
      ),
    );
  }

}


