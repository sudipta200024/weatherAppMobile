// providers/location_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weathermobileapp/Provider/search_provider.dart';

final currentLocationProvider = AsyncNotifierProvider<LocationNotifier, String>(
  LocationNotifier.new,
);

class LocationNotifier extends AsyncNotifier<String> {
  @override
  Future<String> build() async {
    final currentCity = ref.read(searchProvider);

    // If user already has a city (from storage or search) → don't override
    if (currentCity.isNotEmpty) {
      return currentCity;
    }

    // First launch + no saved city → auto-detect!
    await detectCurrentLocation();
    return ref.read(searchProvider).isNotEmpty
        ? ref.read(searchProvider)
        : "Earth"; // fallback
  }

// In location_notifier.dart → replace the whole method
  Future<void> detectCurrentLocation() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      // 1. Check if location service is enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw "Please enable location services in settings";
      }

      // 2. Check permission
      LocationPermission permission = await Geolocator.checkPermission();

      // If denied → request
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw "Location permission denied";
        }
      }

      // If permanently denied → open settings
      if (permission == LocationPermission.deniedForever) {
        await Geolocator.openAppSettings();
        throw "Location permission permanently denied. Please enable in settings.";
      }

      // 3. Get position
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 15),
      ).catchError((e) {
        throw "Failed to get location. Try again.";
      });

      // 4. Reverse geocode
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      final city = placemarks.first.locality ??
          placemarks.first.subAdministrativeArea ??
          placemarks.first.administrativeArea ??
          "Unknown City";

      ref.read(searchProvider.notifier).updateCity(city);
      return city;
    });
  }
}