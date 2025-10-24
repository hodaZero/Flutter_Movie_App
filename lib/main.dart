import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/movie_repo.dart';
import 'logic/cubit/movie_cubit.dart';
import 'logic/cubit/wishlist_cubit.dart';
import 'logic/cubit/theme_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ui/screens/navigation_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  const MyApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MovieCubit(MovieRepo())..getNowPlaying()),
        BlocProvider(create: (_) => WishlistCubit(prefs)),
        BlocProvider(create: (_) => ThemeCubit(prefs)),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Movies App',
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: themeMode,
            home: const NavigationScreen(),
          );
        },
      ),
    );
  }
}
