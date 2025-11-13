// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../data/movie_repo.dart';
// import 'movie_state.dart';

// class MovieCubit extends Cubit<MovieState> {
//   final MovieRepo repo;
//   MovieCubit(this.repo) : super(MovieInitial());

//   void getNowPlaying() async {
//     emit(MovieLoading());
//     try {
//       final movies = await repo.fetchNowPlaying();
//       emit(MovieLoaded(movies));
//     } catch (e) {
//       emit(MovieError('Failed to fetch now playing movies'));
//     }
//   }
// }


import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/movie_repo.dart';
import 'movie_state.dart';

// MovieCubit مسؤول عن إدارة حالات الأفلام (تحميل - نجاح - فشل)
class MovieCubit extends Cubit<MovieState> {
  final MovieRepo repo; // مصدر البيانات (اللي بيجيب الأفلام من الـ API)

  // الحالة المبدئية MovieInitial
  MovieCubit(this.repo) : super(MovieInitial());

  // دالة لجلب الأفلام اللي بتتعرض حالياً
  void getNowPlaying() async {
    emit(MovieLoading()); // نبدأ بعرض حالة التحميل

    try {
      // بنستدعي الميثود اللي بتجيب البيانات من الريبو
      final movies = await repo.fetchNowPlaying();
      emit(MovieLoaded(movies)); // نعرض حالة النجاح مع البيانات
    } catch (e) {
      // لو حصل خطأ أثناء الجلب
      emit(MovieError('Failed to fetch now playing movies'));
    }
  }
}
