import 'dart:math';
import 'package:flutter/material.dart';
import 'controller/home_controller.dart';
import 'controller/home_state.dart';
import 'widgets/image_box.dart';
import 'widgets/action_button.dart';
import '../../network/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController? controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    controller ??= HomeController(
      api: ApiService(),
      fallbackBackground: Theme.of(context).colorScheme.surface,
    )..fetchImage();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<HomeState>(
        valueListenable: controller!.state,
        builder: (_, state, _) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
            color: state.backgroundColor,
            child: SafeArea(
              child: Center(
                child: LayoutBuilder(
                  builder: (_, constraints) {
                    final side = max(
                      220.0,
                      min(constraints.maxWidth, constraints.maxHeight) * 0.6,
                    );

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ImageBox(side: side, state: state),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: side,
                          child: ActionButton(
                            isLoading: state.isLoading,
                            onPressed: controller!.fetchImage,
                          ),
                        ),
                        if (state.error != null) ...[
                          const SizedBox(height: 12),
                          Text(
                            state.error!,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}