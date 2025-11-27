import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weathermobileapp/Provider/theme_provider.dart';
import 'package:weathermobileapp/Utils/screen_size.dart';
import 'package:weathermobileapp/common/widgets/first_launcher_widget.dart';

import '../Provider/search_provider.dart';
import '../Provider/weather_api_provider.dart';
import '../Provider/location_notifier.dart';
import '../common/widgets/glass_card_widget.dart';

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
                          onPressed: () => ref
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
            colors: Theme.of(context).brightness == Brightness.light
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
          child: city.isEmpty
              ? first_launcher_widget(pulseController: _pulseController, cs: cs)
              : _weatherScreen(city, cs, textTheme),
        ),
      ),
    );
  }


  Widget _weatherScreen(String city, ColorScheme cs, TextTheme textTheme) {
    final weather = ref.watch(currentWeatherProvider(city));
    final forecast = ref.watch(next7DaysProvider(city));
    final location = ref.watch(locationProvider(city));

    return RefreshIndicator(
      onRefresh: () async {
        ref.read(currentLocationProvider.notifier).detectCurrentLocation();
        await Future.delayed(const Duration(milliseconds: 800));
      },
      color: cs.secondary,
      backgroundColor: cs.surface.withOpacity(0.2),
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.only(top: 16, left: 24, right: 24, bottom: 40,
              ),
              child: Column(
                children: [
                  // City name & country
                  Text(
                    location.value?.location.name ?? city,
                    style: textTheme.titleLarge
                        ?.copyWith(color: cs.onBackground),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    location.value?.location.country ?? "",
                    style: TextStyle(fontSize: 16, color: cs.onSurface),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),

                  // Current weather
                  weather.when(
                    data: (data) => Column(
                      children: [
                        Text(
                          "${data.current!.tempC!.toInt()}°C",
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.w500,
                            color: cs.onBackground,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          data.current!.condition!.text!,
                          style:
                          TextStyle(fontSize: 20, color: cs.onSurface),
                        ),
                        const SizedBox(height: 12),

                        // Weather icon
                        ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image.network(
                            "https:${data.current!.condition!.icon!}",
                            width: 150,
                            height: 150,
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) => Icon(
                              Icons.cloud,
                              size: 120,
                              color: cs.onSurface,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Details card (humidity, wind, feels-like)
                        GlassCard(cs: cs, child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: [
                                _detail(Icons.water_drop,
                                    "${data.current!.humidity}%", "Humidity", cs.primary),
                                _detail(Icons.air,
                                    "${data.current!.windKph!.toInt()} km/h", "Wind", cs.secondary),
                                _detail(
                                    Icons.thermostat,
                                    "${data.current!.feelslikeC!.toInt()}°",
                                    "Feels",
                                    Colors.orangeAccent),
                              ],
                            ),
                          )),
                        const SizedBox(height: 28),

                        // Hourly forecast card
                        GlassCard(cs: cs, child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Today",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: cs.onBackground,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                forecast.when(
                                  data: (f) {
                                    final now = DateTime.now();
                                    final todayHours =
                                    f.forecast!.forecastday![0].hour!;
                                    final tomorrowHours =
                                    f.forecast!.forecastday![1].hour!;

                                    // Find first hour >= now
                                    int currentIndex = todayHours.indexWhere((h) =>
                                    DateTime.parse(h.time!).hour >= now.hour);
                                    if (currentIndex == -1) {
                                      currentIndex = todayHours.length;
                                    }

                                    var hourlyList = todayHours
                                        .skip(currentIndex)
                                        .toList();

                                    if (hourlyList.length < 5) {
                                      final needed = 5 - hourlyList.length;
                                      hourlyList.addAll(
                                          tomorrowHours.take(needed));
                                    }

                                    final next5 = hourlyList.take(5).toList();

                                    return Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: next5.map((h) {
                                        final time = DateTime.parse(h.time!);
                                        final label = time.hour == 0
                                            ? "12A"
                                            : time.hour == 12
                                            ? "12P"
                                            : time.hour < 12
                                            ? "${time.hour}A"
                                            : "${time.hour - 12}P";

                                        final isCurrentHour = time.hour ==
                                            now.hour &&
                                            time.day == now.day;

                                        return Column(
                                          children: [
                                            Text(
                                              label,
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: isCurrentHour
                                                    ? cs.secondary
                                                    : cs.onSurface,
                                                fontWeight: isCurrentHour
                                                    ? FontWeight.bold
                                                    : FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Image.network(
                                              "https:${h.condition!.icon!}",
                                              width: 42,
                                              height: 42,
                                              errorBuilder: (_, __, ___) =>
                                                  Icon(Icons.cloud,
                                                      size: 36,
                                                      color: cs.onSurface),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              "${h.tempC!.toInt()}°",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: isCurrentHour
                                                    ? cs.secondary
                                                    : cs.onBackground,
                                              ),
                                            ),
                                          ],
                                        );
                                      }).toList(),
                                    );
                                  },
                                  loading: () => const SizedBox(
                                    height: 100,
                                    child: Center(
                                        child: CircularProgressIndicator()),
                                  ),
                                  error: (_, __) => Text("—",
                                      style:
                                      TextStyle(color: cs.onSurface)),
                                ),
                              ],
                            ),
                          )),
                      ],
                    ),
                    loading: () =>
                    const Center(child: CircularProgressIndicator()),
                    error: (_, __) => Center(
                      child: Text(
                        "No connection",
                        style: TextStyle(color: cs.error, fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _detail(IconData icon, String value, String label, Color color) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      children: [
        Icon(icon, color: color, size: 30),
        const SizedBox(height: 12),
        Text(
          value,
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: cs.onSurface,
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 14, color: cs.onSurface),
        ),
      ],
    );
  }
}


