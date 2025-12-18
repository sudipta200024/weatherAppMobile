import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weathermobileapp/Provider/weather_api_provider.dart';
import 'package:weathermobileapp/Provider/location_notifier.dart';
import 'package:weathermobileapp/common/widgets/glass_card_widget.dart';

import '../../View/weekly_forecast_screen.dart';

class WeatherScreen extends ConsumerWidget {
  final String city;
  final ColorScheme cs;
  final TextTheme textTheme;

  const WeatherScreen({
    super.key,
    required this.city,
    required this.cs,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              padding: const EdgeInsets.only(
                top: 16,
                left: 24,
                right: 24,
                bottom: 40,
              ),
              child: Column(
                children: [
                  // City name & country
                  Text(
                    location.value?.location.name ?? city,
                    style: textTheme.titleLarge?.copyWith(
                      color: cs.onBackground,
                    ),
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
                    data:
                        (data) => Column(
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
                              style: TextStyle(
                                fontSize: 20,
                                color: cs.onSurface,
                              ),
                            ),
                            const SizedBox(height: 12),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: Image.network(
                                "https:${data.current!.condition!.icon!}",
                                width: 150,
                                height: 150,
                                fit: BoxFit.contain,
                                errorBuilder:
                                    (_, __, ___) => Icon(
                                      Icons.cloud,
                                      size: 120,
                                      color: cs.onSurface,
                                    ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            GlassCard(
                              cs: cs,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _detail(
                                      Icons.water_drop,
                                      "${data.current!.humidity}%",
                                      "Humidity",
                                      cs.primary,
                                    ),
                                    _detail(
                                      Icons.air,
                                      "${data.current!.windKph!.toInt()} km/h",
                                      "Wind",
                                      cs.secondary,
                                    ),
                                    _detail(
                                      Icons.thermostat,
                                      "${data.current!.feelslikeC!.toInt()}°",
                                      "Feels",
                                      Colors.orangeAccent,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 28),
                            GlassCard(
                              cs: cs,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10,right: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Today",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: cs.onBackground,
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) => const WeeklyForecastScreen(),
                                                ),
                                              );
                                            },
                                            style: TextButton.styleFrom(
                                              minimumSize: Size.zero,
                                              padding: EdgeInsets.zero,
                                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                              splashFactory: NoSplash.splashFactory, // removes ripple box completely
                                            ),
                                            child: Text(
                                              "Weekly forecast",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color: cs.primary,
                                                decorationColor: cs.primary.withOpacity(0.7),
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Divider(
                                      height: 1,
                                      thickness: 0.7,
                                      color: cs.onSurface.withOpacity(0.15),
                                      endIndent: 0,
                                    ),

                                    const SizedBox(height: 15),
                                    forecast.when(
                                      data: (f) {
                                        final now = DateTime.now();
                                        final todayHours =
                                            f.forecast!.forecastday![0].hour!;
                                        final tomorrowHours =
                                            f.forecast!.forecastday![1].hour!;

                                        // Find first hour >= now
                                        int currentIndex = todayHours
                                            .indexWhere(
                                              (h) =>
                                                  DateTime.parse(
                                                    h.time!,
                                                  ).hour >=
                                                  now.hour,
                                            );
                                        if (currentIndex == -1) {
                                          currentIndex = todayHours.length;
                                        }

                                        var hourlyList =
                                            todayHours
                                                .skip(currentIndex)
                                                .toList();

                                        if (hourlyList.length < 5) {
                                          final needed = 5 - hourlyList.length;
                                          hourlyList.addAll(
                                            tomorrowHours.take(needed),
                                          );
                                        }

                                        final next5 =
                                            hourlyList.take(5).toList();

                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children:
                                              next5.map((h) {
                                                final time = DateTime.parse(
                                                  h.time!,
                                                );
                                                final label =
                                                    time.hour == 0
                                                        ? "12A"
                                                        : time.hour == 12
                                                        ? "12P"
                                                        : time.hour < 12
                                                        ? "${time.hour}A"
                                                        : "${time.hour - 12}P";

                                                final isCurrentHour =
                                                    time.hour == now.hour &&
                                                    time.day == now.day;

                                                return Column(
                                                  children: [
                                                    Text(
                                                      label,
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        color:
                                                            isCurrentHour
                                                                ? cs.secondary
                                                                : cs.onSurface,
                                                        fontWeight:
                                                            isCurrentHour
                                                                ? FontWeight
                                                                    .bold
                                                                : FontWeight
                                                                    .w500,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Image.network(
                                                      "https:${h.condition!.icon!}",
                                                      width: 42,
                                                      height: 42,
                                                      errorBuilder:
                                                          (_, __, ___) => Icon(
                                                            Icons.cloud,
                                                            size: 36,
                                                            color: cs.onSurface,
                                                          ),
                                                    ),
                                                    const SizedBox(height: 8),
                                                    Text(
                                                      "${h.tempC!.toInt()}°",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            isCurrentHour
                                                                ? cs.secondary
                                                                : cs.onBackground,
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }).toList(),
                                        );
                                        // Your full hourly logic here (same as before)
                                        // ... keep everything exactly as you had
                                      },
                                      loading:
                                          () => const SizedBox(
                                            height: 100,
                                            child: Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          ),
                                      error:
                                          (_, __) => Text(
                                            "—",
                                            style: TextStyle(
                                              color: cs.onSurface,
                                            ),
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                    loading:
                        () => const Center(child: CircularProgressIndicator()),
                    error:
                        (_, __) => Center(
                          child: Text(
                            "No connection",
                            style: TextStyle(color: cs.error, fontSize: 18),
                          ),
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _detail(IconData icon, String value, String label, Color color) {
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
        Text(label, style: TextStyle(fontSize: 14, color: cs.onSurface)),
      ],
    );
  }
}
