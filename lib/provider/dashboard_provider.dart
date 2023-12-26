import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webkul_task/Helper/Constant.dart';

import '../helper/snackbar.dart';
import '../model/movies_list_model.dart';

class DashBoardProvider extends ChangeNotifier {

  TimeOfDay selectedTime = TimeOfDay.now();
  String? moviesName, movieImage,movieDescription,totalAvegageRating,totalNoOfRatingCount;
  AnimationController? buttonController;
  List<MovieListModel> moviesDataList = [];

  get time => selectedTime;
  get movName => moviesName;
  get movImage => movieImage;
  get movDescription => movieDescription;
  get movAvgRating => totalAvegageRating;
  get movTotalNoOfRating => totalNoOfRatingCount;





  setTime(TimeOfDay value){
    selectedTime = value;
    notifyListeners();
  }


  Future<void> getMoviesList() async {
    try {
      final parameter = {
        "api_key": apikey,
        "language": language,
        "page": "1"
      };

      final uri = Uri.http(baseUrl, moviesList, parameter);
      debugPrint('url $uri');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        List<MovieListModel> items = [];
        items.add(MovieListModel.fromJson(data));
        List<MovieListModel> mainList=[];
        mainList.addAll(items);
        moviesDataList.addAll(items);
        debugPrint('movieName ${moviesDataList[0].results![0].title} ');
        notifyListeners();
        debugPrint(moviesDataList.length.toString());
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } on SocketException catch (e) {
      debugPrint('No Internet connection');
      throw ApiException('No Internet connection');
    } on TimeoutException {
      debugPrint('Something went wrong, Server not Responding');
      throw ApiException('Something went wrong, Server not Responding');
    } on Exception catch (e) {
      throw ApiException('Something Went wrong with ${e.toString()}');
    }

  }


  Future<void> searchMovies(String moviesName) async {

    try {
      final parameter = {
            "api_key" : apikey,
            "language" :language,
            "query" : moviesName,
            "page" : "1"
          };

      final uri = Uri.http(baseUrl, moviesSearch, parameter);
      debugPrint('url $uri');
      final response = await http.get(uri);

      if (response.statusCode == 200) {

        moviesDataList.clear();
        final data = json.decode(response.body);
        List<MovieListModel> items = [];
         items.add(MovieListModel.fromJson(data));
        List<MovieListModel> mainList=[];
        mainList.addAll(items);
        moviesDataList.addAll(items);
        debugPrint('movieName ${moviesDataList[0].results![0].title} ');
        notifyListeners();
        debugPrint(moviesDataList.length.toString());
      } else {
        print('Request failed with status: ${response.statusCode}');
      }

    } on SocketException catch (e) {
      debugPrint('No Internet connection $e');
      throw ApiException('No Internet connection');
    } on TimeoutException {
      debugPrint('Something went wrong, Server not Responding');
      throw ApiException('Something went wrong, Server not Responding');
    } on Exception catch (e) {
      throw ApiException('Something Went wrong with ${e.toString()}');
    }
  }
}


