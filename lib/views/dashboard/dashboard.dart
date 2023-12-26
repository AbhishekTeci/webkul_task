import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import '../../Helper/Constant.dart';
import '../../Widget/list_view_widgets.dart';
import '../../Widget/search_widget.dart';
import 'package:http/http.dart' as http;
import '../../helper/snackbar.dart';
import '../../model/movies_list_model.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

 ScrollController scrollController = ScrollController();
  TextEditingController controller = TextEditingController();
 List<MovieListModel> moviesDataList = [];




 Future<void> getMoviesList() async {
   try {
     final parameter = {"api_key": apikey, "language": language, "page": "1"};

     final uri = Uri.http(baseUrl, moviesList, parameter);
     debugPrint('url $uri');
     final response = await http.get(uri);

     if (response.statusCode == 200) {
       final data = json.decode(response.body);

       List<MovieListModel> items = [];

       setState(() {
         items.add(MovieListModel.fromJson(data));
         List<MovieListModel> mainList = [];
         mainList.addAll(items);
         moviesDataList.addAll(items);
       });

       debugPrint('movieName ${moviesDataList[0].results![0].title} ');
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

       setState(() {
         items.add(MovieListModel.fromJson(data));
         List<MovieListModel> mainList = [];
         mainList.addAll(items);
         moviesDataList.addAll(items);
       });
       debugPrint('movieName ${moviesDataList[0].results![0].title} ');
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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.86,
                child: ListViewLayOut(
                  controller: scrollController,
                  index: moviesDataList.isNotEmpty ? moviesDataList[0].results!.length : 0,
                  list: moviesDataList,
                ),
              ),
              SearchWidgetView(
                txtController: controller,
                onSubmitted: (value) {
                  debugPrint('myValue2 $value');
                  controller.text = value;
                  searchMovies(value);
                },
              ),

            ],
          ),
        ),
      ),
    );

  }


  @override
  void initState() {
    super.initState();
    getMoviesList();
  }
}