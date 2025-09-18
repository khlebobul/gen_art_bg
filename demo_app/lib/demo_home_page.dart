import 'package:flutter/material.dart';

import 'demos.dart';

class DemoHomePage extends StatefulWidget {
  const DemoHomePage({super.key});

  @override
  State<DemoHomePage> createState() => _DemoHomePageState();
}

class _DemoHomePageState extends State<DemoHomePage> {
  int selectedIndex = 0;
  late final PageController _pageController = PageController(
    initialPage: selectedIndex,
  );

  @override
  Widget build(BuildContext context) {
    final demo = demos[selectedIndex];
    return Scaffold(
      appBar: AppBar(title: Text(demo.title), backgroundColor: Colors.white),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  const double sideControlWidth = 56.0;
                  final double totalWidth = constraints.maxWidth;
                  final double maxViewportWidth = 960.0;
                  final double availableForViewport =
                      (totalWidth - 2 * sideControlWidth).clamp(
                        0.0,
                        maxViewportWidth,
                      );
                  final double viewportWidth = availableForViewport;
                  final double viewportHeight = (viewportWidth / 16.0 * 9.0)
                      .clamp(0.0, 540.0);

                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: sideControlWidth,
                        child: IconButton(
                          onPressed: () {
                            final prev =
                                (selectedIndex - 1 + demos.length) %
                                demos.length;
                            _pageController.animateToPage(
                              prev,
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeOut,
                            );
                          },
                          icon: const Icon(Icons.chevron_left, size: 32),
                        ),
                      ),
                      SizedBox(
                        width: viewportWidth,
                        height: viewportHeight,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: ColoredBox(
                            color: Colors.white,
                            child: PageView.builder(
                              controller: _pageController,
                              itemCount: demos.length,
                              onPageChanged: (index) {
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                              itemBuilder: (context, index) {
                                final item = demos[index];
                                return TickerMode(
                                  enabled: index == selectedIndex,
                                  child: RepaintBoundary(
                                    child: Builder(builder: item.builder),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: sideControlWidth,
                        child: IconButton(
                          onPressed: () {
                            final next = (selectedIndex + 1) % demos.length;
                            _pageController.animateToPage(
                              next,
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeOut,
                            );
                          },
                          icon: const Icon(Icons.chevron_right, size: 32),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                children: List.generate(
                  demos.length,
                  (i) => Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: i == selectedIndex
                          ? Colors.black
                          : Colors.black.withValues(alpha: 0.25),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
