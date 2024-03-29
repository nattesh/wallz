import 'package:wallz/models/api_response.dart';
import 'package:wallz/models/api_details_response.dart';
import 'package:wallz/models/filters.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show jsonDecode;
import 'package:wallz/props/api_properties.dart';
import 'package:wallz/models/query_filter.dart';

Future<ApiResponse> getData(int page, Filters filters) async {
  var ratios = filters.ratios;
  var categories = filters.categories;
  var purity = filters.purity;
  var sorting = filters.sorting;
  var order = filters.order;
  var colors = filters.colors;
  var apiKey = '';

  var url = baseUrl + '?page=$page';
  url = handleQuery(url, filters.query, sorting);

  if (ratios.isNotEmpty) {
    url += '&ratios=$ratios';
  }
  if (categories.isNotEmpty) {
    url += '&categories=$categories';
  }
  if (sorting.isNotEmpty) {
    if (!url.contains('&sorting')) {
      url += '&sorting=$sorting';
    }
  }
  if (purity.isNotEmpty) {
    url += '&purity=$purity';
  }
  if (order.isNotEmpty) {
    url += '&order=$order';
  }
  if (apiKey.isNotEmpty) {
    url += '&apikey=$apiKey';
  }
  if (colors.isNotEmpty) {
    url += '&colors=$colors';
  }

  final response = await http.get(Uri.parse(url));
  return ApiResponse.fromJson(jsonDecode(response.body));
}

String handleQuery(String url, QueryFilter query, String sorting) {
  var tagName = query.tagName;
  var like = query.like;
  var username = query.username;

  tagName = tagName.trim().replaceAll(' ', '+');

  if (tagName.isNotEmpty) {
    url += '&q=$tagName';
    if (sorting.isEmpty) {
      url += '&sorting=relevance';
    }
  } else if (like.isNotEmpty) {
    url += '&q=like:$like';
  } else if (username.isNotEmpty) {
    url += '&q=@$username';
  } else {
    url += '&q=';
  }
  return url;
}

Future<ApiDetailsResponse> getDetails(String id) async {
  final response = await http.get(Uri.parse(detailById + id));
  return ApiDetailsResponse.fromJson(jsonDecode(response.body));
}
