import 'package:flutter/services.dart';
import 'dart:convert';

class AuthRepository {
  Future<List<String>> getEmailList() async {
    final String response = await rootBundle.loadString('assets/json/email_list.json');
    Map<String, dynamic> data = await jsonDecode(response) ?? {};
    List list = data["emails"] ?? [];

    return list.cast<String>();
  }
}