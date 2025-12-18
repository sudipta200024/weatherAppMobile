import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Provider/search_provider.dart';
import '../Provider/weather_api_provider.dart';

class WeeklyForecastScreen extends ConsumerWidget {
  const WeeklyForecastScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final city = ref.watch(searchProvider);
    final forecast = ref.watch(next7DaysProvider(city));
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: cs.surface.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(
                      color: cs.outline.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new_rounded),
                        color: cs.onSurface,
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "Forecast • $city",
                          style: textTheme.titleLarge?.copyWith(
                            color: cs.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
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
              Color(0xFF87CEEB),
              Color(0xFFB3E5FC),
              Color(0xFFE1F5FE),
            ]
                : const [
              Color(0xFF0F1424),
              Color(0xFF1E1B4B),
              Color(0xFF2D1B69),
            ],
          ),
        ),
        child: SafeArea(
          top: false,
          child: forecast.when(
            data: (forecastData) {
              final days = forecastData.forecast!.forecastday!;

              // Free plan notice
              if (days.length < 7) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Free plan: Showing 3-day forecast only'),
                      backgroundColor: cs.inverseSurface.withOpacity(0.9),
                      behavior: SnackBarBehavior.floating,
                      margin: const EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      duration: const Duration(seconds: 5),
                    ),
                  );
                });
              }

              return ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 160, 20, 40),
                itemCount: days.length,
                itemBuilder: (context, index) {
                  final day = days[index];
                  final date = DateTime.parse(day.date!);

                  String dayName;
                  if (index == 0) {
                    dayName = "Today";
                  } else if (index == 1) {
                    dayName = "Tomorrow";
                  } else {
                    const weekdays = [
                      "Monday", "Tuesday", "Wednesday", "Thursday",
                      "Friday", "Saturday", "Sunday"
                    ];
                    dayName = weekdays[date.weekday - 1];
                  }

                  final maxTemp = day.day!.maxtempC!.toStringAsFixed(0);
                  final minTemp = day.day!.mintempC!.toStringAsFixed(0);
                  final condition = day.day!.condition!.text!;
                  final iconUrl = "https:${day.day!.condition!.icon!}";

                  return Card(
                    elevation: 4,
                    color: cs.surface.withOpacity(0.7),
                    shadowColor: cs.shadow.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              iconUrl,
                              width: 76,
                              height: 76,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Icon(
                                Icons.wb_cloudy,
                                size: 70,
                                color: cs.onSurfaceVariant,
                              ),
                            ),
                          ),
                          const SizedBox(width: 18),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  dayName,
                                  style: textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: cs.onSurface,
                                  ) ?? const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  condition,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: cs.onSurfaceVariant,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "$maxTemp°",
                                style: TextStyle(
                                  fontSize: 38,
                                  fontWeight: FontWeight.bold,
                                  color: cs.primary,
                                ),
                              ),
                              Text(
                                "$minTemp°",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: cs.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 5,
              ),
            ),
            error: (error, _) => Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.cloud_off, size: 100, color: cs.onSurfaceVariant),
                    const SizedBox(height: 24),
                    Text(
                      "Unable to load forecast",
                      style: textTheme.headlineSmall?.copyWith(
                        color: cs.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Please check your connection",
                      style: TextStyle(color: cs.onSurfaceVariant, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}