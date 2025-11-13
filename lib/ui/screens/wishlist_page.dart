// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../logic/cubit/wishlist_cubit.dart';
// import '../../../data/models/movie_model.dart';
// import 'movie_details_page.dart';

// class WishlistPage extends StatelessWidget {
//   const WishlistPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final wishlist = context.watch<WishlistCubit>().state;

//     return Scaffold(
//       appBar: AppBar(title: const Text("❤️ My Wishlist")),
//       body: wishlist.isEmpty
//           ? const Center(child: Text("No movies added yet"))
//           : ListView.builder(
//               itemCount: wishlist.length,
//               itemBuilder: (context, index) {
//                 final movie = wishlist[index];
//                 final cubit = context.read<WishlistCubit>();

//                 return ListTile(
//                   leading: Image.network(
//                     'https://image.tmdb.org/t/p/w200${movie.posterPath}',
//                     width: 50,
//                     fit: BoxFit.cover,
//                   ),
//                   title: Text(movie.title),
//                   subtitle: Text('⭐ ${movie.voteAverage}'),
//                   trailing: IconButton(
//                     icon: const Icon(
//                       Icons.favorite,
//                       color: Colors.red,
//                     ),
//                     onPressed: () {
//                       cubit.toggleWishlist(movie); // delete from wishlist
//                     },
//                   ),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => MovieDetailsPage(movie: movie),
//                       ),
//                     );
//                   },
//                 ); 
//               },
//             ),
//     );
//   }
// }



// استدعاء مكتبة واجهة المستخدم من Flutter
import 'package:flutter/material.dart';
// استدعاء مكتبة flutter_bloc لإدارة الحالة
import 'package:flutter_bloc/flutter_bloc.dart';
// استدعاء الكيوبت المسؤول عن المفضلة
import '../../../logic/cubit/wishlist_cubit.dart';
// استدعاء موديل الفيلم اللي بيحمل بيانات الفيلم
import '../../../data/models/movie_model.dart';
// استدعاء صفحة تفاصيل الفيلم
import 'movie_details_page.dart';

// صفحة المفضلة اللي بتعرض الأفلام اللي المستخدم أضافها
class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    // بنجيب الحالة الحالية للمفضلة (القائمة فيها الأفلام اللي المستخدم اختارها)
    final wishlist = context.watch<WishlistCubit>().state;

    return Scaffold( // الهيكل الأساسي للصفحة
      appBar: AppBar(title: const Text("❤️ My Wishlist")), // عنوان الصفحة

      // لو المفضلة فاضية يعرض رسالة "No movies added yet"
      body: wishlist.isEmpty
          ? const Center(child: Text("No movies added yet"))

          // لو فيها أفلام نعرضها في ليست
          : ListView.builder(
              itemCount: wishlist.length, // عدد عناصر القائمة
              itemBuilder: (context, index) {
                final movie = wishlist[index]; // بنجيب الفيلم الحالي
                final cubit = context.read<WishlistCubit>(); // عشان نقدر نعمل تعديل على المفضلة

                // عنصر واحد في القائمة (كل فيلم بيظهر في شكل ListTile)
                return ListTile(
                  // صورة الفيلم على الشمال
                  leading: Image.network(
                    'https://image.tmdb.org/t/p/w200${movie.posterPath}', // رابط الصورة من API
                    width: 50,
                    fit: BoxFit.cover, // الصورة تملأ المساحة كويس
                  ),

                  // اسم الفيلم في النص
                  title: Text(movie.title),

                  // تقييم الفيلم يظهر تحت العنوان
                  subtitle: Text('⭐ ${movie.voteAverage}'),

                  // أيقونة المفضلة (القلب الأحمر)
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      // لما نضغط على القلب بيتشال الفيلم من المفضلة
                      cubit.toggleWishlist(movie); // حذف الفيلم
                    },
                  ),

                  // لو ضغطنا على الفيلم كله يفتح صفحة التفاصيل
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MovieDetailsPage(movie: movie),
                      ),
                    );
                  },
                ); 
              },
            ),
    );
  }
}
