import 'package:news_app/model/news_categories_model.dart';
import 'package:news_app/model/news_headlines_model.dart';
import 'package:news_app/repository/news_repository.dart';

class NewsViewModel {
  final _repo = NewsRepository();

  Future<NewsHeadlinesModel> fetchNewsHeadlines(
      String newsname, context) async {
    final response = await _repo.fetchNewsHeadlines(newsname, context);
    return response;
  }

  Future<NewsCategoriesModel> fetchNewsCategories(
      String category, context) async {
    final response = await _repo.fetchNewsCategories(category, context);
    return response;
  }
}
