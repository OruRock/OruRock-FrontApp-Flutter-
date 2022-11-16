import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oru_rock/constant/style/size.dart';

///AlertDialog를 불러오는 공통 위젯
class ImageViewer extends StatelessWidget {
  ImageViewer({
    Key? key,
    required this.imageUrl,
    required this.width,
    required this.height,
  }) : super(key: key);
  String? imageUrl;
  double width;
  double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: const BorderRadius.all(Radius.circular(RadiusSize.large)),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(RadiusSize.large)),
        child: imageUrl == null
            ? Image.asset('asset/image/logo/splash_logo.png')
            : Image.network(
                imageUrl!,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
