import 'package:hooks_riverpod/hooks_riverpod.dart';

final loadingNotifierProvider = StateNotifierProvider<LoadingStateNotifier, bool>((ref) => LoadingStateNotifier());

class LoadingStateNotifier extends StateNotifier<bool> {
  LoadingStateNotifier() : super(false);

  void switchLoading(bool isLoading) {
    state = isLoading;
  }
}
