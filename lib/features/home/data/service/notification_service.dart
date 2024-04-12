import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:melbook/config/core/constants/app_constants.dart';
import 'package:melbook/features/home/data/models/notification.dart';

class NotificationService {
  /// GET All Notifications
  /// GET All Notifications
  Future<List<Notification>> getAllNotifications({
    required String token,
    String domain = AppConstants.baseUrl,
    String endpoint = AppConstants.apiGetNotifications,
  }) async {
    try {
      final response = await http.get(
        Uri.parse("$domain$endpoint"),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> jsonList = json.decode(response.body)['data'];
        final List<Notification> notifications =
            jsonList.map((json) => Notification.fromJson(json)).toList();
        return notifications;
      } else {
        throw Exception(
            'Failed to fetch notifications: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch notifications: $e');
    }
  }

  /// POST Mark Notification as Read
  Future<Notification> markNotificationAsRead({
    required String notificationId,
    String domain = AppConstants.baseUrl,
    String endpoint = AppConstants.apiGetNotifications,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$domain$endpoint/$notificationId/read"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonData =
            json.decode(response.body)['data'];
        final Notification notification = Notification.fromJson(jsonData);
        return notification;
      } else {
        throw Exception(
            'Failed to mark notification as read: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to mark notification as read: $e');
    }
  }

  /// POST Mark All Notifications as Read
  Future<void> markAllNotificationsAsRead({
    String domain = AppConstants.baseUrl,
    String endpoint = AppConstants.apiReadAllNotifications,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$domain$endpoint"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Notifications Marked As Read successfully
      } else {
        throw Exception(
            'Failed to mark all notifications as read: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to mark all notifications as read: $e');
    }
  }
}
