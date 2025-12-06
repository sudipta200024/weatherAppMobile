import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
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
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(color: cs.background),
        child: forecast.when(
          data: (forecast) {
            final days = forecast.forecast!.forecastday!;
            if (days.length < 7) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Free plan active: Showing 3-days forecast only',
                    ),
                    duration: Duration(seconds: 4),
                    backgroundColor: Colors.orange,
                  ),
                );
              });
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: days.length,
              itemBuilder: (context, index) {
                final day = days[index];
                final date = DateTime.parse(day.date!);
                final isToday = index == 0; //making index 7days including today in 0 index
                final dayName = isToday
                        ? 'Today'
                        : index == 1
                        ? 'Tomorrow'
                        : [
                          "Monday",
                          "Tuesday",
                          "Wednesday",
                          "Thursday",
                          "Friday",
                          "Saturday",
                          "Sunday",
                        ][date.weekday - 1];
                return null;
              },
            );
          },
          error: (Object error, StackTrace stackTrace) {},
          loading: () {},
        ),
      ),
    );
    throw UnimplementedError();
  }
}
