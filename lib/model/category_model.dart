import 'dart:convert';

List<String> categoryResponseModelFromJson(String str) =>
    List<String>.from(json.decode(str).map((x) => x));

String categoryResponseModelToJson(List<String> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x)));
