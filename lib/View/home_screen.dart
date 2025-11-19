// home_screen.dart — FINAL BEAUTIFUL VERSION
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weathermobileapp/Provider/theme_provider.dart';
import 'package:weathermobileapp/Utils/screen_size.dart';

import '../Provider/search_provider.dart';
import '../Provider/weather_api_provider.dart';
import '../Provider/location_notifier.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    WidgetsBinding.instance.addPostFrameCallback((_) {
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

  void _performSearch() {
    final city = _searchController.text.trim();
    if (city.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a city name"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    ref.read(searchProvider.notifier).updateCity(city);
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.of(context);
    final city = ref.watch(searchProvider);
    final gpsState = ref.watch(currentLocationProvider);
    final themeMode = ref.watch(themeNotifierProvider);
    final isDark = themeMode == ThemeMode.dark;

    final currentWeather =
        city.isNotEmpty ? ref.watch(currentWeatherProvider(city)) : null;
    final forecast =
        city.isNotEmpty ? ref.watch(next7DaysProvider(city)) : null;
    final locationData =
        city.isNotEmpty ? ref.watch(locationProvider(city)) : null;

    ref.listen<String>(searchProvider, (prev, next) {
      if (next.trim() != _searchController.text.trim()) {
        _searchController.text = next;
        _searchController.selection = TextSelection.fromPosition(
          TextPosition(offset: _searchController.text.length),
        );
      }
    });

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(isDark ? 0.15 : 0.25),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onSubmitted: (_) => _performSearch(),
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      decoration: InputDecoration(
                        hintText: "Search city...",
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.white70,
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.send, color: Colors.white),
                          onPressed: _performSearch,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                GestureDetector(
                  onTap:
                      () =>
                          ref
                              .read(themeNotifierProvider.notifier)
                              .toggleTheme(),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      isDark ? Icons.dark_mode : Icons.light_mode,
                      key: ValueKey(isDark),
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors:
                isDark
                    ? [const Color(0xFF0A2540), const Color(0xFF1C2B3A)]
                    : [const Color(0xFF74B9FF), const Color(0xFFE9F4FF)],
          ),
        ),
        child: Stack(
          children: [
            // MAIN WEATHER CONTENT
            if (city.isNotEmpty)
              RefreshIndicator(
                onRefresh:
                    () async =>
                        ref
                            .read(currentLocationProvider.notifier)
                            .detectCurrentLocation(),
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 120, 20, 100),
                  children: [
                    // City Name & Country
                    locationData?.when(
                          data:
                              (data) => Column(
                                children: [
                                  Text(
                                    data.location.name ?? city,
                                    style: const TextStyle(
                                      fontSize: 42,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    data.location.country ?? "",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                  ),
                                ],
                              ),
                          loading: () => const SizedBox(),
                          error: (_, __) => const SizedBox(),
                        ) ??
                        Text(
                          city,
                          style: const TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),

                    const SizedBox(height: 30),

                    // Current Temperature (Big & Beautiful)
                    currentWeather!.when(
                      data:
                          (data) => Column(
                            children: [
                              Text(
                                "${data.current?.tempC?.toStringAsFixed(0) ?? '--'}°",
                                style: const TextStyle(
                                  fontSize: 100,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                data.current?.condition?.text ?? "Loading...",
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                            ],
                          ),
                      loading:
                          () => const SizedBox(
                            height: 200,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          ),
                      error:
                          (e, _) => Text(
                            "Weather unavailable",
                            style: TextStyle(
                              color: Colors.red.shade300,
                              fontSize: 18,
                            ),
                          ),
                    ),

                    const SizedBox(height: 50),

                    // Forecast Card
                    Card(
                      color: Colors.white.withOpacity(0.15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: forecast!.when(
                          data:
                              (data) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "7-Day Forecast",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "${data.forecast?.forecastday?.length ?? 0} days available",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white.withOpacity(0.9),
                                    ),
                                  ),
                                ],
                              ),
                          loading:
                              () => const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                          error:
                              (e, _) => Text(
                                "Forecast unavailable",
                                style: TextStyle(color: Colors.orange.shade300),
                              ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              )
            else
              // First Launch Screen
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RotationTransition(
                      turns: _pulseController,
                      child: const Icon(
                        Icons.location_searching,
                        size: 100,
                        color: Colors.white54,
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "Finding your location...",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

            // GPS Loading / Error Overlay
            if (gpsState.isLoading || gpsState.hasError)
              Container(
                color: Colors.black.withOpacity(0.9),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (gpsState.isLoading)
                        const Column(
                          children: [
                            CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 6,
                            ),
                            SizedBox(height: 30),
                            Text(
                              "Detecting your location...",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        )
                      else ...[
                        const Icon(
                          Icons.location_off,
                          size: 80,
                          color: Colors.red,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Location Error:\n${gpsState.error}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: () => Geolocator.openAppSettings(),
                          icon: const Icon(Icons.settings),
                          label: const Text("Open Settings"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

            // // Floating Location Button
            // Positioned(
            //   bottom: 30,
            //   right: 20,
            //   child: FloatingActionButton.extended(
            //     backgroundColor: Colors.white,
            //     foregroundColor: const Color(0xFF0A2540),
            //     elevation: 12,
            //     onPressed:
            //         () =>
            //             ref
            //                 .read(currentLocationProvider.notifier)
            //                 .detectCurrentLocation(),
            //     icon:
            //         gpsState.isLoading
            //             ? const SizedBox(
            //               width: 20,
            //               height: 20,
            //               child: CircularProgressIndicator(strokeWidth: 3),
            //             )
            //             : const Icon(Icons.my_location),
            //     label:
            //         gpsState.isLoading
            //             ? const Text("Finding...")
            //             : const Text("My Location"),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
