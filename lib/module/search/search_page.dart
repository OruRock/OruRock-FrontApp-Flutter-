import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/module/search/search_controller.dart';


class Search extends GetView<SearchController> {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.only(
              top: GapSize.medium, left: GapSize.small, right: GapSize.small),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "검색",
                style:
                    TextStyle(fontSize: FontSize.xxLarge, fontFamily: "NanumB"),
              ),
              const SizedBox(
                height: GapSize.xSmall,
              ),
              const TextField(
                decoration: InputDecoration(
                    filled: false,
                    hintText: "암장을 검색해 보세요!",
                    hintStyle: TextStyle(
                        fontSize: FontSize.large,
                        color: Colors.grey,
                        fontFamily: "NanumR"),
                    enabledBorder:
                        OutlineInputBorder(borderSide: BorderSide(width: 1.0)),
                    focusedBorder:
                        OutlineInputBorder(borderSide: BorderSide(width: 1.0)),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: GapSize.small, horizontal: GapSize.small)),
                style:
                    TextStyle(fontSize: FontSize.large, fontFamily: "NanumR"),
              ),
              SizedBox(
                height: HeightWithRatio.xSmall,
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(
                      vertical: GapSize.xxSmall, horizontal: GapSize.xxSmall),
                  itemCount: controller.home.stores.length, //item 개수
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
                    childAspectRatio: 1 / 1.3, //item 의 가로 1, 세로 1.3 의 비율
                    mainAxisSpacing: 20, //수평 Padding
                    crossAxisSpacing: 20, //수직 Padding
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    //item 의 반목문 항목 형성
                    return GestureDetector(
                      onTap: () {
                        controller.goMapToSelectedStore(index);
                      },
                      child: Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 3,
                                      blurRadius: 5,
                                      offset: const Offset(
                                          0, 0), // changes position of shadow
                                    )
                                  ],
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(RadiusSize.large))),
                              alignment: Alignment.center,
                              child:
                                  controller.home.stores[index].image!.isEmpty
                                      ? Image.asset(
                                          'asset/image/logo/splash_logo.png')
                                      : Image.network(controller.home
                                          .stores[index].image![0].imageUrl!),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 3,
                                      blurRadius: 5,
                                      offset: const Offset(
                                          0, 5), // changes position of shadow
                                    )
                                  ],
                                  color: Colors.grey[200]!,
                                  borderRadius: const BorderRadius.vertical(
                                      bottom:
                                          Radius.circular(RadiusSize.large))),
                              alignment: Alignment.center,
                              child: Text(
                                "${controller.home.stores[index].stroreName}",
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
