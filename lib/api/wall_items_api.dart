import 'package:wallz/models/api_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show jsonDecode;
import 'package:wallz/props/api_properties.dart';

Future<ApiResponse> getData(int page) async {

  var ratios = 'portrait';
  var categories = '100';
  var purity = '100';
  var sorting = 'date_added';
  var order = 'desc';
  var apiKey = '';

  var tagName =  'mountains';

  var url = baseUrl + '?page=${page}';

  if(tagName.isNotEmpty) {
    url += '&q=${tagName}&sorting=relevance';
  }
  if(ratios.isNotEmpty) {
    url += '&ratios=${ratios}';
  }
  if(categories.isNotEmpty) {
    url += '&categories=${categories}';
  }
  if(purity.isNotEmpty) {
    url += '&purity=${purity}';
  }
  if(order.isNotEmpty) {
    url += '&order=${order}';
  }
  if(apiKey.isNotEmpty) {
    url += '&apikey=${apiKey}';
  }

  print(url);
  final response = await http.get(Uri.parse(url));
  return ApiResponse.fromJson(jsonDecode(response.body));
}