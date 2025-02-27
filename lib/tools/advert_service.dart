// Ad Service (services/ad_service.dart)
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '/constants/app_urls.dart';
import '/models/advert_model.dart';

class AdvertService {
  // Get all ads (for admin)
  static Future<AdvertResponse> getAllAds(int page, int pageSize) async {
    final response = await http.get(
      Uri.parse(AppUrls.getAds + "?page=$page&pageSize=$pageSize"),
    );
    final Map<String, dynamic> responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      // var adsData = responseData;
      // log(adsData.toString());
      return advertResponseFromJson(response.body);
    } else {
      return Future.error(responseData['message'] ?? 'Failed to load ads');
    }
  }

  // Create a new ad (admin only)
  static Future<AdvertModel> createAd({
    required String title,
    required String description,
    required Stream<List<int>> imageStream,
    required int size,
    required String filename,
    required String type,
    required String targetUrl,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final request = await http.MultipartRequest(
      "POST",
      Uri.parse(AppUrls.createAd),
    );

    request.fields['title'] = title;
    request.fields['description'] = description;
    request.fields['targetUrl'] = targetUrl;
    request.fields['startDate'] = startDate.toIso8601String();
    request.fields['endDate'] = endDate.toIso8601String();
    request.fields['name'] = "Adverts";
    // handle image
    request.files.add(
      http.MultipartFile(
        "image",
        imageStream,
        size,
        filename: filename,
        contentType: MediaType("image", type),
      ),
    );
    var response = await request.send();
    final Map<String, dynamic> responseData =
        json.decode(await response.stream.bytesToString());

    if (response.statusCode == HttpStatus.ok) {
      return AdvertModel.fromJson(responseData['data']);
    } else {
      throw Exception(responseData['message'] ?? 'Failed to create ad');
    }
  }

  // Update an ad (admin only)
  static Future<String> updateAd(
    String id,
    Map<String, dynamic> updates,
  ) async {
    final request = await http.MultipartRequest(
      "PUT",
      Uri.parse(AppUrls.updateAd + id),
    );
    // handle updating data
    request.headers['Content-Type'] = "application/json";
    request.headers['Accept'] = "application/json";
    request.fields['title'] = updates['title'];
    request.fields['description'] = updates['description'];
    request.fields['startDate'] = updates['startDate'].toIso8601String();
    request.fields['endDate'] = updates['endDate'].toIso8601String();
    request.fields['isActive'] = updates['isActive'];
    request.fields['name'] = "Adverts";
    var response = await request.send();
    var responseMessage = json.decode(await response.stream.bytesToString());
    if (response.statusCode == HttpStatus.ok) {
      return Future.value(responseMessage["message"]);
    } else {
      return Future.error(responseMessage["message"]);
    }
  }

  // Delete an ad (admin only)
  static Future<String> deleteAd({
    required String id,
  }) async {
    final response = await http.delete(
      Uri.parse(AppUrls.deleteAd + id),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    final Map<String, dynamic> responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      return Future.value(responseData['message']);
    } else {
      return Future.error('Failed to delete ad: ${response.statusCode}');
    }
  }

  // Toggle ad status (admin only)
  static Future<String> toggleAdStatus(
    String id,
  ) async {
    final response = await http.put(
      Uri.parse(
        AppUrls.toggleAd + id,
      ),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    log("Urls: " + AppUrls.toggleAd + id);
    final Map<String, dynamic> responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      return Future.value(responseData['message']);
    } else {
      return Future.error(
          responseData['message'] ?? 'Failed to toggle ad status');
    }
  }
}
