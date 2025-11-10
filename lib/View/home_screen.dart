import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weathermobileapp/Provider/theme_provider.dart';
import 'package:weathermobileapp/Utils/screen_size.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenSize.of(context);

    final themeMode = ref.watch(themeNotifierProvider);
    final notifier = ref.read(themeNotifierProvider.notifier);
    final isDark = themeMode == ThemeMode.dark;

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
    );
  }
}
