import 'dart:async';
import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';
import 'dart:typed_data';

import 'text_data_structures.dart';

import 'binary_unpacker.dart';
import 'generated/index.dart';

enum LoadStatus {
  unloaded,
  loading,
  loaded,
  error;
}
