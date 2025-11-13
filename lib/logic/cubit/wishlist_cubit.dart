// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../data/models/movie_model.dart';
// import '../../data/wishlist_helper.dart';

// class WishlistCubit extends Cubit<List<Movie>> {
//   final SharedPreferences prefs;

//   WishlistCubit(this.prefs) : super(WishlistHelper.getWishlist(prefs));

//   void toggleWishlist(Movie movie) {
//     final current = List<Movie>.from(state);
//     if (current.any((m) => m.id == movie.id)) {
//       current.removeWhere((m) => m.id == movie.id);
//     } else {
//       current.add(movie);
//     }
//     WishlistHelper.saveWishlist(prefs, current);
//     emit(current);
//   }

//   bool isInWishlist(Movie movie) {
//     return state.any((m) => m.id == movie.id);
//   }

//   void clearWishlist() {
//     WishlistHelper.saveWishlist(prefs, []);
//     emit([]);
//   }
// }



//ملخص بسيط تقولي للمُعيدة:
//الكود ده Cubit بيتحكم في حالة قائمة المفضلة، بيضيف أو يحذف فيلم منها، ويحفظها محليًا باستخدام SharedPreferences عشان لما أقفل التطبيق ترجع تاني بنفس البيانات.
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/movie_model.dart';
import '../../data/wishlist_helper.dart';

// Cubit مسؤول عن إدارة حالة الـ wishlist (المفضلة)
class WishlistCubit extends Cubit<List<Movie>> {
  final SharedPreferences prefs; // لتخزين البيانات محلياً على الجهاز

  // عند إنشاء الـ Cubit، يتم تحميل قائمة المفضلة المخزّنة
  WishlistCubit(this.prefs) : super(WishlistHelper.getWishlist(prefs));

  // إضافة أو إزالة فيلم من المفضلة
  void toggleWishlist(Movie movie) {
    final current = List<Movie>.from(state); // نسخة من الحالة الحالية

    // لو الفيلم موجود بالفعل → نحذفه، غير كده → نضيفه
    if (current.any((m) => m.id == movie.id)) {
      current.removeWhere((m) => m.id == movie.id); // حذف الفيلم
    } else {
      current.add(movie); // إضافة الفيلم
    }

    // نحفظ القائمة الجديدة في SharedPreferences
    WishlistHelper.saveWishlist(prefs, current);

    // نحدث الحالة علشان الـ UI يتغير
    emit(current);
  }

  // نتحقق هل الفيلم موجود في المفضلة ولا لا
  bool isInWishlist(Movie movie) {
    return state.any((m) => m.id == movie.id);
  }

  // مسح كل الأفلام من المفضلة
  void clearWishlist() {
    WishlistHelper.saveWishlist(prefs, []); // نحذف من التخزين
    emit([]); // نرجع الحالة فاضية
  }
}
