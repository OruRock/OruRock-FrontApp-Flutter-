import 'package:flutter/material.dart';
import 'package:oru_rock/constant/style/size.dart';

AppBar mainAppBar = AppBar(
  title: const Text("OruRock"),
);

const TextStyle drawerListTextStyle =
    TextStyle(fontSize: FontSize.medium, fontFamily: "NotoB");

const TextStyle boldNanumTextStyle = TextStyle(
    fontSize: FontSize.medium,
    fontFamily: "NotoB",
    height: 1.6,
    color: Colors.black);

const TextStyle regularNanumTextStyle = TextStyle(
    fontSize: FontSize.small,
    fontFamily: "NotoR",
    height: 1.6,
    color: Colors.black);

const TextStyle regularNanumDetailPageTextStyle = TextStyle(
    fontSize: FontSize.medium, fontFamily: "NotoR", color: Colors.black);

const TextStyle pinTextStyle = TextStyle(
    fontSize: FontSize.large,
    fontFamily: "NotoM",
    height: 1.6,
    color: Colors.black);

const TextStyle unSelectedToggleTextStyle = TextStyle(
    color: Colors.black, fontFamily: "NotoB", fontSize: FontSize.medium);

const TextStyle selectedToggleTextStyle = TextStyle(
    color: Colors.white, fontFamily: "NotoB", fontSize: FontSize.medium);

const TextStyle reviewNickNameTextStyle =
    TextStyle(fontFamily: "NotoB", fontSize: FontSize.small);

const TextStyle reviewContentTextStyle =
    TextStyle(fontFamily: "NotoR", fontSize: FontSize.small);

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
  border: Border.all(color: Colors.black26, width: 1.0),
);

BoxDecoration noShadowBoxDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: const BorderRadius.all(Radius.circular(RadiusSize.large)),
  border: Border.all(color: Colors.black26, width: 1.0),
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
