import 'package:wallz/models/api_response.dart';
import 'package:wallz/models/api_details_response.dart';
import 'package:wallz/models/filters.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show jsonDecode;
import 'package:wallz/props/api_properties.dart';

Future<ApiResponse> getData(int page, Filters filters) async {

  var ratios = filters.ratios;
  var categories = filters.categories;
  var purity = filters.purity;
  var sorting = filters.sorting;
  var order = filters.order;
  var colors = filters.colors;
  var apiKey = '';

  print(filters.sorting);

  var tagName =  filters.tagName;
  tagName = tagName.trim().replaceAll(' ', '+');

  var url = baseUrl + '?page=${page}';

  if(tagName != null && tagName.isNotEmpty) {
    url += '&q=${tagName}&sorting=relevance';
  } else {
    url += '&q=';
  }

  if(ratios != null && ratios.isNotEmpty) {
    url += '&ratios=${ratios}';
  }
  if(categories != null && categories.isNotEmpty) {
    url += '&categories=${categories}';
  }
  if(sorting != null && sorting.isNotEmpty) {
    url += '&sorting=${sorting}';
  }
  if(purity != null && purity.isNotEmpty) {
    url += '&purity=${purity}';
  }
  if(order != null && order.isNotEmpty) {
    url += '&order=${order}';
  }
  if(apiKey != null && apiKey.isNotEmpty) {
    url += '&apikey=${apiKey}';
  }
  if(colors != null && colors.isNotEmpty) {
    url += '&colors=${colors}';
  }

  print(url);
  final response = await http.get(Uri.parse(url));
  return ApiResponse.fromJson(jsonDecode(response.body));
}

Future<ApiDetailsResponse> getDetails(String id) async {
  final response = await http.get(Uri.parse(detailById + id));
  return ApiDetailsResponse.fromJson(jsonDecode(response.body));
}