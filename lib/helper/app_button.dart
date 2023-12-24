
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBtn extends StatelessWidget {
  final String? title;
  final AnimationController? btnCntrl;
  final VoidCallback? onBtnSelected;
  final bool? paddingRequired;

  const AppBtn({
    Key? key,
    this.title,
    this.btnCntrl,
    this.onBtnSelected,
    this.paddingRequired,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: paddingRequired == null ? 25 : 0,
      ),
      child: CupertinoButton(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 45,
          alignment: FractionalOffset.center,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.red, Colors.black],
              stops: [0, 1],
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(
                10,
              ),
            ),
          ),
          child: Text(
            title!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        onPressed: () {
          onBtnSelected!();
        },
      ),
    );
  }


}