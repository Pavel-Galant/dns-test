import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

abstract class API {
  Future<String> getToken({@required Map <String, String>params});

  //Future<String> searchArticles({@required String keyWord});

  factory API.getAPI() => _DnsApi();
}

class _DnsApi implements API {
  @override
  Future<String> getToken({Map <String, String>params}) async {
    try {
      final response = await post("https://vacancy.dns-shop.ru/api/candidate/token",
          headers: {"Content-Type": "application/json"},
          body: json.encode(params)        
      );
      final jsonData = response.body;
      return jsonData;
    } catch (error) {
      throw error;
    }
  }
}
