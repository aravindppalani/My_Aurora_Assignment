import 'package:flutter/material.dart';

class HomeState {
  final bool isLoading;
  final String? imageUrl;
  final Color backgroundColor;
  final String? error;

  const HomeState({
    required this.isLoading,
    this.imageUrl,
    required this.backgroundColor,
    this.error,
  });

  factory HomeState.initial(Color fallbackColor) => HomeState(
    isLoading: false,
    backgroundColor: fallbackColor,
  );

  HomeState copyWith({
    bool? isLoading,
    String? imageUrl,
    Color? backgroundColor,
    String? error,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      imageUrl: imageUrl ?? this.imageUrl,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      error: error,
    );
  }
}