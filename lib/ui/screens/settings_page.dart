import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/cubit/theme_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<ThemeCubit>();
    final isDark = themeCubit.state == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(title: const Text(" Settings")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SwitchListTile(
              value: isDark,
              title: const Text("Enable Dark Mode"),
              onChanged: (_) {
                context.read<ThemeCubit>().toggleTheme();
              },
            ),
          ],
        ),
      ),
    );
  }
}
