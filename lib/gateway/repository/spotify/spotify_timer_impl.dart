import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_app/gateway/dio/constants.dart';
import 'package:riverpod_app/gateway/repository/spotify/spotify_search_repository_impl.dart';
import 'package:riverpod_app/gateway/repository/twitter/twitter_search_repository_impl.dart';
import 'package:riverpod_app/gateway/repository/youtube/youtube_search_repository_impl.dart';
import 'package:riverpod_app/model/home/sub/ui_01_page_model.dart';
import 'package:riverpod_app/pages/utils/debug_provider.dart';
import 'package:riverpod_app/pages/utils/shared_preferences_provider.dart';
import 'package:riverpod_app/pages/utils/timer_provider.dart';
import 'package:spotify/spotify.dart';

abstract class SpotifyTimer {
  void setTimerWithSpotifyPage();
  void cancelTimerWithSpotifyPage();
}