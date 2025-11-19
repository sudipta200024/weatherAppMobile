// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// class SearchNotifier extends Notifier<String> {
//   @override
//   String build() {
//     return '';
//   }
//   void updateCity(String city) {
//     state = city.trim();
//   }
// }
// final searchProvider = NotifierProvider<SearchNotifier, String>(() {
//   return SearchNotifier();
// });
// providers/search_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final searchProvider = NotifierProvider<SearchNotifier, String>(() {
  return SearchNotifier();
});

class SearchNotifier extends Notifier<String> {
  static const _key = 'last_city';

  @override
  String build() {
    // First launch: try to load last saved city
    _loadFromStorage();
    return ""; // temporary, will be replaced instantly
  }

  Future<void> _loadFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_key);
    if (saved != null && saved.isNotEmpty) {
      state = saved;
    }
  }

  void updateCity(String city) async {
    final trimmed = city.trim();
    if (trimmed.isEmpty) return;

    state = trimmed;

    // Save to storage so it survives app restart (pro feature #4)
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, trimmed);
  }
}