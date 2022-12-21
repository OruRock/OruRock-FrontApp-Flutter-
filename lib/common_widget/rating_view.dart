import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:oru_rock/constant/style/size.dart';

class RatingView extends StatelessWidget {
  RatingView({
    Key? key,
    required this.rate,
  }) : super(key: key);
  double rate;

  @override
  Widget build(BuildContext context) {
    return RatingStars(
    valueLabelVisibility: false,
    value: rate,
    starSpacing: GapSize.xSmall,
    starCount: 5,
    starSize: 20,
    starOffColor: Colors.grey,
    starColor: Colors.amber,
    );

  }
}
