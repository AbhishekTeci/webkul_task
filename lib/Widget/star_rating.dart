import 'package:flutter/material.dart';
import 'package:webkul_task/Helper/Constant.dart';

import '../helper/Color.dart';

class StarRating extends StatelessWidget {
  String totalRating, noOfRatings;
  bool needToShowNoOfRatings;

  StarRating({
    Key? key,
    required this.totalRating,
    required this.noOfRatings,
    required this.needToShowNoOfRatings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment(0, 0),
              end: Alignment(1, 1),
              colors: [
                grad1Color,
                grad2Color,
              ],
            ),
            borderRadius: BorderRadius.circular(circularBorderRadius3),
          ),
          child: const FittedBox(
            child: Icon(
              Icons.star,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(
          width: 5.0,
        ),
        Flexible(
          child: Text(
            totalRating,
            style: const TextStyle(
              fontFamily: 'ubuntu',
            ),
          ),
        ),
        needToShowNoOfRatings
            ? const SizedBox(
          width: 5.0,
        )
            : Container(),
        needToShowNoOfRatings
            ? Flexible(
          child: Text(
            '($noOfRatings)',
            style: const TextStyle(
              fontSize: textFontSize10,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.normal,
              fontFamily: 'ubuntu',
            ),
          ),
        )
            : Container(),
      ],
    );
  }
}
