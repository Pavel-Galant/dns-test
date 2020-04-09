import 'dart:async';
import 'dart:convert' as convert;

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

abstract class API {
  Future<String> getToken({@required Map <String, String>params});
  Future<void> summary({@required Map <String, String>params, @required String token});
  Future<void> testSummary({@required Map <String, String>params, @required String token});

  factory API.getAPI() => _DnsApi();
}

class _DnsApi implements API {
  @override
  Future<String> getToken({Map <String, String>params}) async {
    try {
      final response = await post("https://vacancy.dns-shop.ru/api/candidate/token",
          headers: {"Content-Type": "application/json"},
          body: convert.jsonEncode(params)        
      );
      final data = convert.jsonDecode(response.body);
      if (data['code'] > 0) throw Exception(data['message']);
      return data['data'];
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<void> testSummary({Map <String, String>params, String token}) async {
    try {
      print(params);
      final response = await post("https://vacancy.dns-shop.ru/api/candidate/test/summary",
          headers: {"Content-Type": "application/json", "Authorization": "Bearer $token"},
          body: convert.jsonEncode(params)        
      );
      final data = convert.jsonDecode(response.body);
      if (data['code'] > 0) throw Exception(data['message']);
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<void> summary({Map <String, String>params, token}) async {
    try {
      final response = await post("https://vacancy.dns-shop.ru/api/candidate/summary",
          headers: {"Content-Type": "application/json", "Authorization": "Bearer $token"},
          body: convert.jsonEncode(params)        
      );
      final data = convert.jsonDecode(response.body);
      print(data);
      if (data['code'] > 0) throw Exception(data['message']);
    } catch (error) {
      throw error;
    }
  }
}
