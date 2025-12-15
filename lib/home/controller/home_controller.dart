import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:palette_generator/palette_generator.dart';
import 'home_state.dart';
import '../../network/api_service.dart';

class HomeController {
  final ApiService api;
  final Color fallbackBackground;
  final ValueNotifier<HomeState> state;

  HomeController({
    required this.api,
    required this.fallbackBackground,
  }) : state = ValueNotifier(HomeState.initial(fallbackBackground));

  Future<void> fetchImage() async {
    state.value = state.value.copyWith(isLoading: true, error: null);
    try {
      final url = await api.fetchImage();
      state.value = state.value.copyWith(
        imageUrl: url,
        isLoading: false,
      );
      _getBackground(url);
    } catch (_) {
      state.value = state.value.copyWith(
        isLoading: false,
        error: 'Failed to load image. Tap Another.',
      );
    }
  }

  Future<void> _getBackground(String url) async {
    try {
      final palette = await PaletteGenerator.fromImageProvider(
        CachedNetworkImageProvider(
          url,
          maxWidth: 64,
          maxHeight: 64,
        ),
        size: const Size(64, 64),
        maximumColorCount: 6,
      );
      state.value = state.value.copyWith(
        backgroundColor: palette.dominantColor?.color ?? fallbackBackground,
      );
    } catch (_) {}
  }

  void dispose() => state.dispose();
}