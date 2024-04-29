import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:news_app/model/news_categories_model.dart';
import 'package:news_app/model/news_headlines_model.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/utils/route_names.dart';

class NewsRepository {
  Future<NewsHeadlinesModel> fetchNewsHeadlines(
      String newsname, context) async {
    String headlinesURl =
        'https://newsapi.org/v2/top-headlines?sources=${newsname}&apiKey=93fb73d53d94436f88cf7ef4a04b3e7e';

    final response = await http.get(Uri.parse(headlinesURl));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsHeadlinesModel.fromJson(body);
    } else if (response.statusCode == 400) {
      Navigator.pushNamed(context, RouteNames.errorScreen);
    } else if (response.statusCode == 401) {
      Navigator.pushNamed(context, RouteNames.errorScreen);
    } else if (response.statusCode == 429) {
      Navigator.pushNamed(context, RouteNames.errorScreen);
    } else if (response.statusCode == 500) {
      Navigator.pushNamed(context, RouteNames.errorScreen);
    } else if (response.statusCode == 502) {
      Navigator.pushNamed(context, RouteNames.errorScreen);
    }
    throw Exception(Error().toString());
  }

  Future<NewsCategoriesModel> fetchNewsCategories(
      String category, context) async {
    String headlinesURl =
        'https://newsapi.org/v2/everything?q=${category}&apiKey=93fb73d53d94436f88cf7ef4a04b3e7e';

    final response = await http.get(Uri.parse(headlinesURl));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsCategoriesModel.fromJson(body);
    } else if (response.statusCode == 400) {
      Navigator.pushNamed(context, RouteNames.errorScreen);
    } else if (response.statusCode == 401) {
      Navigator.pushNamed(context, RouteNames.errorScreen);
    } else if (response.statusCode == 429) {
      Navigator.pushNamed(context, RouteNames.errorScreen);
    } else if (response.statusCode == 500) {
      Navigator.pushNamed(context, RouteNames.errorScreen);
    } else if (response.statusCode == 502) {
      Navigator.pushNamed(context, RouteNames.errorScreen);
    }

    throw Exception();
  }
}
