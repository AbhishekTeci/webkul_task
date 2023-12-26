import 'package:flutter/material.dart';

import 'package:webkul_task/Widget/star_rating.dart';
import 'package:webkul_task/helper/design_confg.dart';
import 'package:webkul_task/helper/routes.dart';
import '../../../Helper/Constant.dart';

import '../helper/Color.dart';

import '../model/movies_list_model.dart';

class ListViewLayOut extends StatefulWidget {
  ScrollController controller;
  int index;
  List<MovieListModel> list;

  ListViewLayOut(
      {Key? key,
      required this.controller,
      required this.index,
      required this.list})
      : super(key: key);

  @override
  State<ListViewLayOut> createState() => _ListViewLayOutState();
}

class _ListViewLayOutState extends State<ListViewLayOut> {
  List<MovieListModel> moviesDataList = [];

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowIndicator();
        return true;
      },
      child: ListView.builder(
        itemCount: widget.index,
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        controller: widget.controller,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsetsDirectional.only(
                start: 10.0, end: 10.0, top: 5.0),
            child: Container(
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(circularBorderRadius10),
              ),
              child: InkWell(
                child: Stack(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 1,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(circularBorderRadius4),
                              bottomLeft:
                                  Radius.circular(circularBorderRadius4),
                            ),
                            child: DesignConfiguration.getCacheNotworkImage(
                              boxFit: BoxFit.cover,
                              context: context,
                              heightvalue: 107,
                              widthvalue: 107,
                              placeHolderSize: 50,
                              imageurlString:
                                  imageBaseUrl + widget.list[0].results![index].posterPath.toString(),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.only(
                                    top: 15.0, start: 15.0),
                                child: Text(
                                  widget.list[0].results![index].title ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(
                                          fontFamily: 'ubuntu',
                                          color: black,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          fontSize: textFontSize12),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.only(
                                    start: 15.0, top: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.list[0].results![index].overview ?? '',
                                      style: const TextStyle(
                                        color: lightBlack,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'ubuntu',
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      widget.list[0].results![index].releaseDate ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .overline!
                                          .copyWith(
                                              fontFamily: 'ubuntu',
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              decorationColor: lightBlack2,
                                              decorationStyle:
                                                  TextDecorationStyle.solid,
                                              decorationThickness: 2,
                                              letterSpacing: 0),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.only(
                                    top: 8.0, start: 15.0),
                                child: StarRating(
                                  noOfRatings:
                                  widget.list[0].results![index].voteCount.toString(),
                                  totalRating:
                                  widget.list[0].results![index].voteAverage.toString(),
                                  needToShowNoOfRatings: true,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                onTap: () async {
                  Routes.navigateToMovieDetailView(
                      context,
                      widget.list[0].results![index].title.toString(),
                      widget.list[0].results![index].overview.toString(),
                      imageBaseUrl +
                          widget.list[0].results![index].posterPath.toString());
                },
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
