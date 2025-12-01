import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weathermobileapp/Provider/theme_provider.dart';
import 'package:weathermobileapp/Utils/screen_size.dart';
import 'package:weathermobileapp/common/widgets/first_launcher_widget.dart';

import '../Provider/search_provider.dart';
import '../Provider/location_notifier.dart';
import '../common/widgets/weather_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(searchProvider.notifier).loadCompleted;
      final savedCity = ref.read(searchProvider);
      _searchController.text = savedCity;
      if (savedCity.isEmpty) {
        ref.read(currentLocationProvider.notifier).detectCurrentLocation();
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _search() {
    final city = _searchController.text.trim();
    if (city.isNotEmpty) {
      ref.read(searchProvider.notifier).updateCity(city);
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.of(context); // initialise screen size helper

    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final city = ref.watch(searchProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: Container(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 5,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onSubmitted: (_) => _search(),
                            style: TextStyle(color: cs.primary),
                            decoration: const InputDecoration(
                              hintText: "Search city...",
                              prefixIcon: Icon(Icons.search),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        IconButton(
                          icon: Icon(
                            isDark ? Icons.dark_mode : Icons.light_mode,
                            size: 28,
                          ),
                          color: cs.onBackground,
                          onPressed:
                              () =>
                                  ref
                                      .read(themeNotifierProvider.notifier)
                                      .toggleTheme(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors:
                Theme.of(context).brightness == Brightness.light
                    ? const [
                      Color(0xFF87CEEB), // Sky blue
                      Color(0xFFB3E5FC),
                      Color(0xFFE1F5FE),
                    ]
                    : const [
                      Color(0xFF0F1424), // Deep midnight
                      Color(0xFF1E1B4B),
                      Color(0xFF2D1B69), // Aurora purple
                    ],
          ),
        ),
        child: SafeArea(
          child:
              city.isEmpty
                  ? first_launcher_widget(
                    pulseController: _pulseController,
                    cs: cs,
                  )
                  : WeatherScreen(
                    city: city,
                    cs: cs,
                    textTheme: textTheme,
                  ),
        ),
      ),
    );
  }

}
