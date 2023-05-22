import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_list/database/sqlFlite.dart';
import 'package:movie_list/model/movie_model.dart';

class MovieDataController extends GetxController {
  final note = TextEditingController();
  // List<Map> data = <Map>[];
  List<Movie> data = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchData();
  }
  
  deleteItem(String id) async {
    await Sql(
        version: 1, table: 'movies')
        .deleteColumn(id);
    fetchData();
  }

  fetchData() async {
    var mapData = await Sql(version: 1, table: 'movies').getRecords();
    data = mapData.map((map) => Movie.fromJson(map)).toList();
    update();
  }

  insertData(String name, String director, String year, BuildContext context) async {
    await Sql(version: 1, table: 'movies')
        .insertDatabase(
      name, director, year
    );
    fetchData();
    if(context.mounted) {
      Navigator.pop(context);
    }
  }

  updateData(String id, String name, String director, String year, BuildContext context) async {
    await Sql(version: 1, table: 'movies')
        .updateData(
      id, name, director, year
    );
    fetchData();

    if(context.mounted) {
      Navigator.pop(context);
    }
  }
}