import 'package:wallz/models/api_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show jsonDecode;
import 'package:wallz/props/api_properties.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<ApiResponse> getData(int page) async {

  final prefs = await SharedPreferences.getInstance();

  var ratios = 'portrait';
  var categories = '100';
  var purity = '100';
  var sorting = 'date_added';
  var order = 'desc';
  var apiKey = '';

  var tagName =  await prefs.getString('tagName');

  var url = baseUrl + '?page=${page}';

  if(tagName != null && tagName.isNotEmpty) {
    url += '&q=${tagName}&sorting=relevance';
  }
  if(ratios != null && ratios.isNotEmpty) {
    url += '&ratios=${ratios}';
  }
  if(categories != null && ratios.isNotEmpty) {
    url += '&categories=${categories}';
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

  print(url);
  final response = await http.get(Uri.parse(url));
  return ApiResponse.fromJson(jsonDecode(response.body));
}