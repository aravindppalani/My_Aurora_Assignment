import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../controller/home_state.dart';

class ImageBox extends StatelessWidget {
  final double side;
  final HomeState state;

  const ImageBox({super.key, required this.side, required this.state});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderRadius = BorderRadius.circular(20);
    final placeholderColor = theme.colorScheme.surfaceVariant.withOpacity(0.4);

    Widget content;

    if (state.imageUrl == null) {
      content = ClipRRect(
        borderRadius: borderRadius,
        child: Shimmer(
          duration: const Duration(seconds: 2),
          interval: const Duration(seconds: 0),
          color: placeholderColor,
          colorOpacity: 0.3,
          enabled: true,
          direction: const ShimmerDirection.fromLTRB(),
          child: Container(
            width: side,
            height: side,
            color: placeholderColor,
          ),
        ),
      );
    } else {
      content = ClipRRect(
        borderRadius: borderRadius,
        child: CachedNetworkImage(
          key: ValueKey(state.imageUrl),
          imageUrl: state.imageUrl!,
          fit: BoxFit.cover,
          memCacheWidth: side.toInt(),
          memCacheHeight: side.toInt(),
          fadeInDuration: const Duration(milliseconds: 400),
          placeholder: (_, _) => ClipRRect(
            borderRadius: borderRadius,
            child: Shimmer(
              duration: const Duration(seconds: 2),
              interval: const Duration(seconds: 0),
              color: placeholderColor,
              colorOpacity: 0.3,
              enabled: true,
              direction: const ShimmerDirection.fromLTRB(),
              child: Container(
                width: side,
                height: side,
                color: placeholderColor,
              ),
            ),
          ),
          errorWidget: (_, _, _) => Container(
            color: placeholderColor,
            alignment: Alignment.center,
            child: Icon(
              Icons.broken_image,
              size: 36,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      );
    }

    return Semantics(
      label: 'Fetch image',
      child: SizedBox(
        height: side,
        width: side,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 350),
          child: content,
        ),
      ),
    );
  }
}
