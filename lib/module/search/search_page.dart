import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/module/app/app_controller.dart';

class Search extends GetView<AppController> {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            '검색',
            style: TextStyle(
                fontFamily: "NotoB",
                fontSize: FontSize.xLarge,
                height: 1.7,
                color: Colors.black),
          ),
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.white,
          elevation: 1,
        ),
        body: Padding(
          padding: const EdgeInsets.only(
              top: GapSize.medium, left: GapSize.small, right: GapSize.small),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: GapSize.xSmall,
              ),
              TextField(
                controller: controller.searchText,
                decoration: InputDecoration(
                    filled: false,
                    suffixIcon: IconButton(
                      onPressed: () {
                        controller.search();
                      },
                      icon: const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                    ),
                    hintText: "암장을 검색해 보세요!",
                    hintStyle: const TextStyle(
                        fontSize: FontSize.large,
                        color: Colors.grey,
                        fontFamily: "NotoR"),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1.0)),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1.0)),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: GapSize.small, horizontal: GapSize.small)),
                style: const TextStyle(
                    fontSize: FontSize.large, fontFamily: "NotoR"),
              ),
              SizedBox(
                height: HeightWithRatio.xSmall,
              ),
              Obx(
                () => Expanded(
                    child: controller.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            itemCount: controller.searchStores.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: (){
                                  controller.goMapToSelectedStore(index);
                                },
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: GapSize.small),
                                      child: ListTile(
                                          leading: controller
                                                      .searchStores[index].imageUrl ==
                                                  null
                                              ? Image.asset(
                                                  'asset/image/logo/splash_logo.png')
                                              : Image.network(controller
                                                  .searchStores[index].imageUrl!),
                                          title: Text(
                                            controller.searchStores[index].stroreName!,
                                            style: const TextStyle(fontFamily: "NotoB", overflow: TextOverflow.ellipsis),
                                          ),
                                        subtitle: Text(
                                          controller.searchStores[index].storeDescription!,
                                          style: const TextStyle(fontFamily: "NotoR"),
                                        ),
                                      ),
                                    ),
                                    Divider(height: 1.0, color: Colors.black26,)
                                  ],
                                ),
                              );
                            })

                    /*GridView.builder(
                          padding: const EdgeInsets.symmetric(
                              vertical: GapSize.xxSmall,
                              horizontal: GapSize.xxSmall),
                          itemCount: controller.searchStores.length, //item 개수
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
                            childAspectRatio:
                                1 / 1.3, //item 의 가로 1, 세로 1.3 의 비율
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
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 3,
                                              blurRadius: 5,
                                              offset: const Offset(0,
                                                  0), // changes position of shadow
                                            )
                                          ],
                                          color: Colors.white,
                                          borderRadius:
                                              const BorderRadius.vertical(
                                                  top: Radius.circular(
                                                      RadiusSize.large))),
                                      alignment: Alignment.center,
                                      child: controller
                                              .searchStores[index].imageUrl == null
                                          ? Image.asset(
                                              'asset/image/logo/splash_logo.png')
                                          : Image.network(controller
                                              .searchStores[index]
                                              .imageUrl!),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 3,
                                              blurRadius: 5,
                                              offset: const Offset(0,
                                                  5), // changes position of shadow
                                            )
                                          ],
                                          color: Colors.grey[200]!,
                                          borderRadius:
                                              const BorderRadius.vertical(
                                                  bottom: Radius.circular(
                                                      RadiusSize.large))),
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: GapSize.xSmall),
                                        child: AutoSizeText(
                                          "${controller.searchStores[index].stroreName}",
                                          style: const TextStyle(
                                            fontFamily: "NotoB"
                                          ),
                                          minFontSize: FontSize.medium,
                                          maxFontSize: FontSize.large,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),*/
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
