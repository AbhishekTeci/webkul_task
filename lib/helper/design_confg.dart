import 'package:flutter/cupertino.dart';

class DesignConfiguration {

  static setPngPath(String name) {
    return 'assets/image/$name.png';
  }


  static getCacheNotworkImage({
    required String imageurlString,
    required BuildContext context,
    required BoxFit? boxFit,
    required double? heightvalue,
    required double? widthvalue,
    required double? placeHolderSize,
  }) {
    return FadeInImage.assetNetwork(
      image: imageurlString,
      placeholder: DesignConfiguration.setPngPath('logo'),
      width: widthvalue,
      height: heightvalue,
      fit: boxFit,
      fadeInDuration: const Duration(
        milliseconds: 150,
      ),
      fadeOutDuration: const Duration(
        milliseconds: 150,
      ),
      fadeInCurve: Curves.linear,
      fadeOutCurve: Curves.linear,
      imageErrorBuilder: (context, error, stackTrace) {
        return Container(
            alignment: Alignment.bottomCenter,
            child: Stack(
              children: [
                Image.asset(
                  DesignConfiguration.setPngPath('logo'),
                  fit: BoxFit.contain,
                )
              ],
            ));
      },
    );
  }
}
