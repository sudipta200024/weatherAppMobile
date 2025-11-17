import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchNotifier extends Notifier<String> {
  @override
  String build() {
    return 'Dhaka';
  }
  void updateCity(String city) {
    state = city.trim();
  }
}
final searchProvider = NotifierProvider<SearchNotifier, String>(() {
  return SearchNotifier();
});