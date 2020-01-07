import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:wmn_plus/features/auth/resource/auth_repository.dart';
import 'package:wmn_plus/features/news/news_detail/news_detail_model.dart';

class NewsDetailProvider {
  Future<NewsDetail> getNewsDetail(String id) async {
    Response response;
    var userRepo = await UserRepository();
    try {
      var user = await userRepo.getCurrentUser();
      response = await get(
          'http://194.146.43.98:4000/api/v1/patient/newsDetail/$id',
          headers: {
            "Content-Type": "application/json",
            "Authorization": "wmn538179 ${user.result.token}",
          });
      String body = utf8.decode(response.bodyBytes);
      Map newsObject = json.decode(body);
      var newsList = NewsDetail.fromJson(newsObject);
      return newsList;
    } catch (error) {
      throw (error.toString());
    }
  }

  void test(bool isError) {
    if (isError == true) {
      throw Exception("manual error");
    }
  }
}
