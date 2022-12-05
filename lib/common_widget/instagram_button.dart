import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:url_launcher/url_launcher.dart';

///AlertDialog를 불러오는 공통 위젯
class InstagramButton extends StatelessWidget {
  const InstagramButton({Key? key, required this.nickName}) : super(key: key);
  final nickName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
          var nativeUrl = "instagram://user?username=$nickName";
          var webUrl = "https://www.instagram.com/$nickName";
          try {
            if (!await launchUrl(Uri.parse(nativeUrl),
                mode: LaunchMode.externalApplication)) {
              await launchUrl(Uri.parse(webUrl),
                  mode: LaunchMode.platformDefault);
            }
          } catch (e) {
            Logger().e(e.toString());
          }
        },
        child: Row(
          children: [
            const Icon(FontAwesomeIcons.instagram, color: Colors.pinkAccent, size: 18, ),
            const SizedBox(
              width: GapSize.xSmall,
            ),
            Text('$nickName', style: TextStyle(fontFamily: "NotoM", fontSize: FontSize.small, color: Colors.black),),
            SizedBox(
              width: GapSize.xxxSmall,
            ),
            Icon(Icons.chevron_right, size: FontSize.small,),
          ],
        ));
  }
}
