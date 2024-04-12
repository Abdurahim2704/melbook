import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:melbook/config/core/constants/app_constants.dart';
import 'package:melbook/features/home/data/models/banner.dart';
import 'package:melbook/features/home/data/models/category.dart';

class NetworkService {
  /// #GET All Categories
  Future<List<Category>> getCategories({
    String domain = AppConstants.baseUrl,
    String endpoint = AppConstants.apiGetCategories,
  }) async {
    try {
      final response = await http.get(Uri.parse("$domain$endpoint"));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> jsonList = json.decode(response.body)['data'];
        final List<Category> categories =
            jsonList.map((json) => Category.fromJson(json)).toList();
        return categories;
      } else {
        throw Exception('Failed to fetch categories: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch categories: $e');
    }
  }

  /// #GET All Banners
  Future<List<BannerModel>> getBanners({
    String domain = AppConstants.baseUrl,
    String endpoint = AppConstants.apiGetBanners,
  }) async {
    try {
      final response = await http.get(Uri.parse("$domain$endpoint"));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> jsonList = json.decode(response.body)['data'];
        final List<BannerModel> banners =
            jsonList.map((json) => BannerModel.fromJson(json)).toList();
        return banners;
      } else {
        throw Exception('Failed to fetch banners: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch banners: $e');
    }
  }
}
