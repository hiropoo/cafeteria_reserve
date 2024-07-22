import 'package:flutter_dotenv/flutter_dotenv.dart';

const String flavor = String.fromEnvironment('FLAVOR');

final devVariables = {
  'serverIP': dotenv.env['SERVER_IP_DEV'],
  'port': dotenv.env['SERVER_PORT_DEV'],
  'locationRadius': dotenv.env['LOCATION_RADIUS_DEV'],
};

final prodVariables = {
  'serverIP': dotenv.env['SERVER_IP_PROD'],
  'port': dotenv.env['SERVER_PORT_PROD'],
  'locationRadius': dotenv.env['LOCATION_RADIUS_PROD'],
};

Map<String, dynamic> get environment {
  if (flavor == 'dev') {
    return devVariables;
  } else {
    return prodVariables;
  }
}
