import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dart:io';

class ApiService {
  // Use the host's local IP which is more reliable than 10.0.2.2 in some setups
  static String get baseUrl {
    if (Platform.isAndroid) {
      // Hardcoding the known local IP for now to ensure connection
      return 'http://192.168.100.166:8080';
    }
    return 'http://127.0.0.1:8080';
  }

  Future<List<dynamic>> getExpenses() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/expenses'));
      if (response.statusCode == 200) return jsonDecode(response.body);
    } catch (e) {
      print('API Error (getExpenses): $e');
    }
    return [];
  }

  Future<void> addExpense(Map<String, dynamic> data) async {
    try {
      await http.post(
        Uri.parse('$baseUrl/expenses'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
    } catch (e) {
      print('API Error (addExpense): $e');
    }
  }

  Future<List<dynamic>> getBudgets() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/budgets'));
      if (response.statusCode == 200) return jsonDecode(response.body);
    } catch (e) {
      print('API Error (getBudgets): $e');
    }
    return [];
  }

  Future<void> addBudget(Map<String, dynamic> data) async {
    try {
      await http.post(
        Uri.parse('$baseUrl/budgets'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
    } catch (e) {
      print('API Error (addBudget): $e');
    }
  }

  Future<List<dynamic>> getWorkouts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/budgets'));
      if (response.statusCode == 200) return jsonDecode(response.body);
    } catch (e) {
      print('API Error (getWorkouts): $e');
    }
    return [];
  }

  Future<void> addWorkout(Map<String, dynamic> data) async {
    try {
      await http.post(
        Uri.parse('$baseUrl/budgets'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
    } catch (e) {
      print('API Error (addWorkout): $e');
    }
  }

  Future<List<dynamic>> getWeights() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/savings'));
      if (response.statusCode == 200) return jsonDecode(response.body);
    } catch (e) {
      print('API Error (getWeights): $e');
    }
    return [];
  }

  Future<void> addWeight(Map<String, dynamic> data) async {
    try {
      await http.post(
        Uri.parse('$baseUrl/savings'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
    } catch (e) {
      print('API Error (addWeight): $e');
    }
  }

  Future<bool> login(String username, String password) async {
    print('ApiService: Attempting login for $username at $baseUrl/login');
    try {
      final url = '$baseUrl/login';
      print('ApiService: Attempting POST to $url');
      final response = await http
          .post(
            Uri.parse(url),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'username': username, 'password': password}),
          )
          .timeout(const Duration(seconds: 10));

      print('ApiService: Login status code: ${response.statusCode}');
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 401) {
        throw Exception('INVALID_CREDENTIALS');
      } else {
        throw Exception('SERVER_ERROR_${response.statusCode}');
      }
    } on SocketException catch (e) {
      print('ApiService: SocketException: $e');
      throw Exception('CONNECTION_ERROR');
    } on TimeoutException catch (e) {
      print('ApiService: TimeoutException: $e');
      throw Exception('TIMEOUT_ERROR');
    } catch (e) {
      print('ApiService: Unexpected error: $e');
      if (e.toString().contains('INVALID_CREDENTIALS') ||
          e.toString().contains('CONNECTION_ERROR') ||
          e.toString().contains('TIMEOUT_ERROR') ||
          e.toString().contains('SERVER_ERROR'))
        rethrow;
      throw Exception('UNKNOWN_ERROR: $e');
    }
  }
}

final apiServiceProvider = Provider((ref) => ApiService());
