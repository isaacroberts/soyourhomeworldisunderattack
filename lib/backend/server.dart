import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'error_handler.dart';

String getURL() {
  if (kDebugMode) {
    return 'http://127.0.0.1:5000';
  } else {
    return 'https://homeworld.nfshost.com/';
  }
}

String fontUrl(String filename) {
  return "${getURL()}/font/$filename";
}

String _stripLeadingSlashes(String endpoint) {
  if (endpoint.startsWith('/')) {
    endpoint = endpoint.substring(1);
  }
  if (endpoint.endsWith('/')) {
    endpoint = endpoint.substring(0, endpoint.length - 1);
  }
  return endpoint;
}

Future<http.Response> send(String endpoint,
    [Map<String, dynamic>? body]) async {
  endpoint = _stripLeadingSlashes(endpoint);
  return http.post(Uri.parse('${getURL()}/$endpoint/'),
      headers: {
        "Accept": "application/json",
        "Access-Control-Allow-Origin": "*"
      },
      body: body != null ? json.encode(body) : null);
}

Future<http.Response> sendGet(String endpoint,
    [Map<String, dynamic>? body]) async {
  endpoint = _stripLeadingSlashes(endpoint);
  return http.get(Uri.parse('${getURL()}/$endpoint'), headers: {
    "Accept": "application/json",
    "Access-Control-Allow-Origin": "*", // Required for CORS support to work
    // "Access-Control-Allow-Credentials": true, // Required for cookies, authorization headers with HTTPS
    "Access-Control-Allow-Headers":
        "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
    "Access-Control-Allow-Methods": "POST, OPTIONS"
  });
}

Future<Map<String, dynamic>?> sendAndHandleErrors(String endpoint,
    [Map<String, dynamic>? body]) async {
  // dev.log("Sending $endpoint {$body}");
  var response = await send(endpoint, body);
  // dev.log('response = """${response.body}"""');
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    // dev.log("Data = $data");
    return data;
  } else {
    dev.log("HTML Exception: Status code = ${response.statusCode}");
    dev.log(response.body);
    ErrorList.showError(
        HttpException('Exception ${response.statusCode}: ${response.body}'));
    return null;
  }
}

Future<ByteBuffer> getFileFromServer(String path) async {
  var uri = Uri.parse('${getURL()}/$path');
  final client = http.Client();
  final request = http.Request('GET', uri);
  final response = await client.send(request);
  // final stream = response.stream;
  // final response = await http.post(uri,
  //     headers: {
  //       "Content-Type": "*",
  //       "Accept": "*",
  //       "Access-Control-Allow-Origin": "*",
  //     },
  //     body: utf8.encode(json.encode(body)));

  if (response.contentLength == 0) {
    throw Exception('No file data sent. File=$path');
  }
  if (response.statusCode == 200) {
    Uint8List bytes = await response.stream.toBytes();
    return bytes.buffer;
    // return response.bodyBytes.buffer;
  } else {
    throw Exception(
        'Error getting file from server: code ${response.statusCode} ${response.reasonPhrase}');
  }
}
