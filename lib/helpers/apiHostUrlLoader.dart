
import 'dart:convert';

import 'package:flutter/services.dart';

Future<String> loadApiHostUrl() async {
  final config = await rootBundle.loadString('./config.json');
  final decodedConfig = json.decode(config);

  return decodedConfig['apiHostUrl'];
}
