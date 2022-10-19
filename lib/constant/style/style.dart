import 'package:flutter/material.dart';
import 'package:oru_rock/constant/style/size.dart';

AppBar mainAppBar = AppBar(
  title: const Text("OruRock"),
);

const TextStyle drawerListTextStyle =
    TextStyle(fontSize: FontSize.medium, fontFamily: "NanumB");

const TextStyle boldNanumTextStyle = TextStyle(
    fontSize: FontSize.medium,
    fontFamily: "NanumB",
    height: 1.6,
    color: Colors.black);

const TextStyle regularNanumTextStyle = TextStyle(
    fontSize: FontSize.small,
    fontFamily: "NanumR",
    height: 1.6,
    color: Colors.black);

const TextStyle regularNanumDetailPageTextStyle = TextStyle(
    fontSize: FontSize.medium, fontFamily: "NanumR", color: Colors.black);

const TextStyle pinTextStyle = TextStyle(
    fontSize: FontSize.large,
    fontFamily: "NanumB",
    height: 1.6,
    color: Colors.black);

const TextStyle unSelectedToggleTextStyle = TextStyle(
    color: Colors.black, fontFamily: "NanumB", fontSize: FontSize.medium);

const TextStyle selectedToggleTextStyle = TextStyle(
    color: Colors.white, fontFamily: "NanumB", fontSize: FontSize.medium);

const TextStyle reviewNickNameTextStyle =
    TextStyle(fontFamily: "NanumB", fontSize: FontSize.small);

const TextStyle reviewContentTextStyle =
    TextStyle(fontFamily: "NanumR", fontSize: FontSize.small);

BoxDecoration shadowBoxDecoration = BoxDecoration(
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(0.2),
      spreadRadius: 3,
      blurRadius: 5,
      offset: const Offset(0, 0), // changes position of shadow
    )
  ],
  color: Colors.white,
  borderRadius: const BorderRadius.all(Radius.circular(RadiusSize.large)),
);

BoxDecoration imageSliderBoxDecoration = BoxDecoration(
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(0.2),
      spreadRadius: 3,
      blurRadius: 5,
      offset: const Offset(0, 0), // changes position of shadow
    )
  ],
  color: Colors.white,
  borderRadius: const BorderRadius.all(Radius.circular(RadiusSize.large)),
  border: Border.all(color: Colors.grey, width: 3.0),
);
