import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weathermobileapp/Provider/theme_provider.dart';
import 'package:weathermobileapp/Utils/screen_size.dart';

import '../Provider/weather_api_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final String city = "Dhaka";
  @override
  Widget build(BuildContext context) {
    ScreenSize.of(context);

    final themeMode = ref.watch(themeNotifierProvider);
    final notifier = ref.read(themeNotifierProvider.notifier);
    final isDark = themeMode == ThemeMode.dark;
    // 🟩 IMPORTANT: Call your weather providers here
    final currentWeather = ref.watch(currentWeatherProvider(city));
    final forecast = ref.watch(next7DaysProvider(city));
    final history = ref.watch(past7daysProvider(city));

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(ScreenSize.screenHeight * 0.12),
        child: Padding(
          padding: EdgeInsets.only(top: ScreenSize.screenHeight * 0.02),
          child: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            actions: [
              SizedBox(width: 25),
              SizedBox(
                height: 50,
                width: 300,
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    labelText: "search city",
                    labelStyle: TextStyle(
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: notifier.toggleTheme,
                child: Icon(
                  isDark ? Icons.dark_mode : Icons.light_mode,
                  color: isDark ? Colors.black : Colors.white,
                ),
              ),
              SizedBox(width: 25),
            ],
          ),
        ),
      ),

        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // ---- CURRENT WEATHER ----
            currentWeather.when(
              data: (data) {
                return Text(
                  "Current Temp: ${data.current?.tempC ?? 'N/A'} °C",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text(
                "Current Weather Error: $e",
                style: const TextStyle(color: Colors.white),
              ),
            ),

            const SizedBox(height: 20),

            // ---- NEXT 7 DAYS FORECAST ----
            forecast.when(
              data: (data) {
                final days = data.forecast?.forecastday?.length ?? 0;
                return Text(
                  "Next 7 Days Forecast: $days days",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text(
                "Forecast Error: $e",
                style: const TextStyle(color: Colors.white),
              ),
            ),

            const SizedBox(height: 20),

            // ---- PAST 7 DAYS HISTORY ----
            history.when(
              data: (data) {
                return Text(
                  "Past 7 Days History: ${data.length} records",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text(
                "History Error: $e",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        )

    );
  }
}
