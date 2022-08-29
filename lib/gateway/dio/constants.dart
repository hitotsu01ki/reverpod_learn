import 'dart:io';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum Flavor { dev, stg, prd }

@immutable
class Constants {
  const Constants._({
    required this.endpoint,
    required this.apiKey,
    required this.contentType,
  });

  factory Constants.of() {
    final flavor = EnumToString.fromString(
      Flavor.values,
      const String.fromEnvironment('FLAVOR'),
    );

    switch (flavor) {
      case Flavor.dev:
        return Constants._dev();
      case Flavor.stg:
        return Constants._stg();
      case Flavor.prd:
      default:
        return Constants._prd();
    }
  }

  factory Constants._dev() {
    return Constants._(
      endpoint: Platform.isAndroid ? 'http://10.0.2.2:8080' : 'http://localhost:8080',
      contentType: 'application/json',
      apiKey: '', // TODO aws dev apiKey
    );
  }

  factory Constants._stg() {
    return const Constants._(
      endpoint: '', // TODO aws stg endpoint
      contentType: 'application/json',
      apiKey: '', // TODO aws stg apiKey
    );
  }

  factory Constants._prd() {
    return const Constants._(
      endpoint: '', // TODO aws prd endpoint
      contentType: 'application/json',
      apiKey: '', // TODO aws prd apiKey
    );
  }

  static final Constants instance = Constants.of();

  final String endpoint; // AWS
  final String contentType;
  final String apiKey;
  final String googleApiKey = '';
  final String twitterApiKey = '';
  final String twitterBearerToken = '';
  final String twitterAccessToken = '';
  final String twitterAccessTokenSecret = '';
  final String twitterConsumerKey = '';
  final String twitterConsumerSecret = '';
}
