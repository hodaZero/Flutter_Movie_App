import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/movie_repo.dart';
import 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  final MovieRepo repo;
  MovieCubit(this.repo) : super(MovieInitial());

  void getNowPlaying() async {
    emit(MovieLoading());
    try {
      final movies = await repo.fetchNowPlaying();
      emit(MovieLoaded(movies));
    } catch (e) {
      emit(MovieError('فشل تحميل الأفلام'));
    }
  }
}
