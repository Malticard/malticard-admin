// Ad Service (services/ad_service.dart)
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:malticard/exports/exports.dart';
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
  static Future<String> createAd({
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
    try {
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
        return Future.value("Added new advert");
      } else {
        throw Exception(responseData['message'] ?? 'Failed to create ad');
      }
    } on Exception catch (e, stack) {
      stack.toString();
      return throw Exception(e.toString());
    }
  }

  // Update an ad (admin only)
  static Future<String> updateAd(
    String id,
    Map<String, dynamic> updates,
  ) async {
    try {
      final request = await http.MultipartRequest(
        "PUT",
        Uri.parse(AppUrls.updateAd + id),
      );
      // handle updating data
      request.fields['title'] = updates['title'];
      request.fields['targetUrl'] = updates['targetUrl'];
      request.fields['startDate'] = updates['startDate'];
      request.fields['endDate'] = updates['endDate'];
      request.fields['name'] = "Adverts";
      // handle image
      if (updates["image"] != null) {
        request.files.add(
          MultipartFile(
            "image",
            updates["image"],
            updates["size"],
            filename: updates["name"],
            contentType: MediaType(
              "image",
              updates["type"],
            ),
          ),
        );
      }
      var response = await request.send();
      var responseMessage = json.decode(await response.stream.bytesToString());
      if (response.statusCode == HttpStatus.ok) {
        return Future.value("Updated advert successfully");
      } else {
        return Future.error(
            responseMessage["message"] ?? "Error updating advert");
      }
    } catch (e) {
      throw Exception(e);
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
      return Future.value("Toggled scuccessfully");
    } else {
      return Future.error(
          responseData['message'] ?? 'Failed to toggle ad status');
    }
  }
}
