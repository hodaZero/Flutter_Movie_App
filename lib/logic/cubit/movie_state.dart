// import 'package:equatable/equatable.dart';
// import '../../data/models/movie_model.dart';

// abstract class MovieState extends Equatable {
//   @override
//   List<Object?> get props => [];
// }

// class MovieInitial extends MovieState {}

// class MovieLoading extends MovieState {}

// class MovieLoaded extends MovieState {
//   final List<Movie> movies;
//   MovieLoaded(this.movies);

//   @override
//   List<Object?> get props => [movies];
// }

// class MovieError extends MovieState {
//   final String message;
//   MovieError(this.message);

//   @override
//   List<Object?> get props => [message];
// }

//الكود دا بيعرّف الحالات اللي بيمر بيها Cubit أثناء تحميل الأفلام:

//MovieInitial: قبل التحميل.

//MovieLoading: أثناء التحميل.

//MovieLoaded: بعد النجاح.

//MovieError: لو حصل فشل.
//وEquatable عشان يسهّل مقارنة الحالات بدل ما يعتمد على عنوان الذاكرة.
import 'package:equatable/equatable.dart';
import '../../data/models/movie_model.dart';

// الكلاس الأساسي اللي كل الحالات هتورّث منه
abstract class MovieState extends Equatable {
  @override
  List<Object?> get props => []; // لتسهيل مقارنة الحالات
}

// الحالة المبدئية قبل ما أي حاجة تتحمّل
class MovieInitial extends MovieState {}

// الحالة اللي بتظهر وقت تحميل البيانات (loading spinner مثلاً)
class MovieLoading extends MovieState {}

// الحالة اللي بتظهر لما الأفلام تتحمّل بنجاح
class MovieLoaded extends MovieState {
  final List<Movie> movies; // قائمة الأفلام اللي جت من الـ API
  MovieLoaded(this.movies);

  @override
  List<Object?> get props => [movies]; // عشان لو حصل تغيير في البيانات
}

// الحالة اللي بتظهر لو حصل خطأ أثناء التحميل
class MovieError extends MovieState {
  final String message; // رسالة الخطأ اللي هتتعرض للمستخدم
  MovieError(this.message);

  @override
  List<Object?> get props => [message];
}
