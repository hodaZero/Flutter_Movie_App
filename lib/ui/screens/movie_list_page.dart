// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../logic/cubit/movie_cubit.dart';
// import '../../../logic/cubit/movie_state.dart';
// import '../../../logic/cubit/wishlist_cubit.dart';
// import '../../../data/models/movie_model.dart';
// import 'movie_details_page.dart';
// import 'wishlist_page.dart';

// class MovieListPage extends StatelessWidget {
//   const MovieListPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Movies"),
//         actions: [
//           BlocBuilder<WishlistCubit, List<Movie>>(
//             builder: (context, wishlist) {
//               final hasFavorites = wishlist.isNotEmpty;
//               return IconButton(
//                 icon: Icon(
//                   Icons.favorite,
//                   color: hasFavorites ? Colors.red : Colors.grey,
//                 ),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (_) => const WishlistPage()),
//                   );
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//       body: BlocBuilder<MovieCubit, MovieState>(
//         builder: (context, state) {
//           if (state is MovieLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is MovieLoaded) {
//             return Padding(
//               padding: const EdgeInsets.all(8),
//               child: GridView.builder(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   crossAxisSpacing: 8,
//                   mainAxisSpacing: 8,
//                   childAspectRatio: 0.6,
//                 ),
//                 itemCount: state.movies.length,
//                 itemBuilder: (context, index) {
//                   final movie = state.movies[index];
//                   return MovieGridCard(movie: movie, index: index);
//                 },
//               ),
//             );
//           } else if (state is MovieError) {
//             return Center(child: Text(state.message));
//           }
//           return const Center(child: Text("No Data"));
//         },
//       ),
//     );
//   }
// }

// class MovieGridCard extends StatefulWidget {
//   final Movie movie;
//   final int index;

//   const MovieGridCard({super.key, required this.movie, required this.index});

//   @override
//   State<MovieGridCard> createState() => _MovieGridCardState();
// }

// class _MovieGridCardState extends State<MovieGridCard>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;
//   late Animation<double> _opacityAnimation;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 500),
//     );

//     final curved = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

//     _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(curved);
//     _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(curved);

//     Future.delayed(Duration(milliseconds: 50 * widget.index), () {
//       if (mounted) _controller.forward();
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isFav = context.watch<WishlistCubit>().isInWishlist(widget.movie);

//     return FadeTransition(
//       opacity: _opacityAnimation,
//       child: ScaleTransition(
//         scale: _scaleAnimation,
//         child: GestureDetector(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => MovieDetailsPage(movie: widget.movie),
//               ),
//             );
//           },
//           child: Stack(
//             children: [
//               Column(
//                 children: [
//                   Expanded(
//                     child: Hero(
//                       tag: widget.movie.id,
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(8),
//                         child: Image.network(
//                           'https://image.tmdb.org/t/p/w200${widget.movie.posterPath}',
//                           width: double.infinity,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 6),
//                   Text(
//                     widget.movie.title,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(
//                         fontSize: 14, fontWeight: FontWeight.w600),
//                   ),
//                   const SizedBox(height: 4),
//                 ],
//               ),
//               Positioned(
//                 top: 8,
//                 right: 8,
//                 child: CircleAvatar(
//                   radius: 16,
//                   backgroundColor: Colors.white70,
//                   child: IconButton(
//                     padding: EdgeInsets.zero,
//                     icon: Icon(
//                       isFav ? Icons.favorite : Icons.favorite_border,
//                       color: isFav ? Colors.red : Colors.grey,
//                       size: 18,
//                     ),
//                     onPressed: () {
//                       context.read<WishlistCubit>().toggleWishlist(widget.movie);
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// استدعاء مكتبة واجهة المستخدم الأساسية من فلاتر
import 'package:flutter/material.dart';
// استدعاء مكتبة BLoC لإدارة الحالة
import 'package:flutter_bloc/flutter_bloc.dart';
// استدعاء الكيوبت الخاص بالأفلام
import '../../../logic/cubit/movie_cubit.dart';
// استدعاء الحالات المختلفة للأفلام
import '../../../logic/cubit/movie_state.dart';
// استدعاء الكيوبت الخاص بالمفضلة
import '../../../logic/cubit/wishlist_cubit.dart';
// استدعاء الموديل اللي بيحمل بيانات الفيلم
import '../../../data/models/movie_model.dart';
// استدعاء صفحة تفاصيل الفيلم
import 'movie_details_page.dart';
// استدعاء صفحة المفضلة
import 'wishlist_page.dart';

// صفحة عرض قائمة الأفلام الرئيسية
class MovieListPage extends StatelessWidget {
  const MovieListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( // التصميم الأساسي للصفحة
      appBar: AppBar( // شريط علوي
        title: const Text("Movies"), // عنوان الصفحة
        actions: [ // أيقونات إضافية في اليمين
          // BlocBuilder يتابع تغييرات حالة المفضلة
          BlocBuilder<WishlistCubit, List<Movie>>(
            builder: (context, wishlist) {
              final hasFavorites = wishlist.isNotEmpty; // هل المفضلة فيها أفلام؟
              return IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: hasFavorites ? Colors.red : Colors.grey, // لون الأيقونة حسب الحالة
                ),
                onPressed: () {
                  // عند الضغط ينتقل لصفحة المفضلة
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const WishlistPage()),
                  );
                },
              );
            },
          ),
        ],
      ),

      // الجسم الرئيسي للصفحة
      body: BlocBuilder<MovieCubit, MovieState>( // بيتابع حالة عرض الأفلام
        builder: (context, state) {
          if (state is MovieLoading) {
            // أثناء التحميل
            return const Center(child: CircularProgressIndicator());
          } else if (state is MovieLoaded) {
            // بعد التحميل بنجاح
            return Padding(
              padding: const EdgeInsets.all(8),
              child: GridView.builder( // عرض الأفلام في شكل شبكة
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // عدد الأعمدة
                  crossAxisSpacing: 8, // المسافة بين الأعمدة
                  mainAxisSpacing: 8, // المسافة بين الصفوف
                  childAspectRatio: 0.6, // نسبة العرض للطول
                ),
                itemCount: state.movies.length, // عدد الأفلام
                itemBuilder: (context, index) {
                  final movie = state.movies[index]; // الفيلم الحالي
                  return MovieGridCard(movie: movie, index: index); // كارت فيلم واحد
                },
              ),
            );
          } else if (state is MovieError) {
            // لو حصل خطأ في التحميل
            return Center(child: Text(state.message));
          }
          // الحالة المبدئية
          return const Center(child: Text("No Data"));
        },
      ),
    );
  }
}

// ويدجت الكارت اللي بيعرض كل فيلم في الشبكة
class MovieGridCard extends StatefulWidget {
  final Movie movie; // بيانات الفيلم
  final int index; // ترتيبه في القائمة

  const MovieGridCard({super.key, required this.movie, required this.index});

  @override
  State<MovieGridCard> createState() => _MovieGridCardState();
}

// الحالة الداخلية للكارت (عشان فيه أنيميشن)
class _MovieGridCardState extends State<MovieGridCard>
    with SingleTickerProviderStateMixin { // mixin عشان نقدر نستخدم AnimationController
  late AnimationController _controller; // الكنترولر المسؤول عن الحركة
  late Animation<double> _scaleAnimation; // أنيميشن للتكبير
  late Animation<double> _opacityAnimation; // أنيميشن للشفافية

  @override
  void initState() {
    super.initState();

    // إعداد الكنترولر اللي يتحكم في الأنيميشن
    _controller = AnimationController(
      vsync: this, // لازم عشان يمنع استهلاك زائد
      duration: const Duration(milliseconds: 500), // مدة الحركة
    );

    // منحنى الحركة (EaseOut يعني حركة ناعمة)
    final curved = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    // تحديد من إلى لكل أنيميشن
    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(curved);
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(curved);

    // تأخير بسيط لكل كارت حسب ترتيبه عشان الحركة تكون متدرجة
    Future.delayed(Duration(milliseconds: 50 * widget.index), () {
      if (mounted) _controller.forward(); // تشغيل الأنيميشن
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // تنظيف الكنترولر لما الكارت يخرج
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // التحقق هل الفيلم مضاف في المفضلة ولا لا
    final isFav = context.watch<WishlistCubit>().isInWishlist(widget.movie);

    return FadeTransition( // أنيميشن الشفافية
      opacity: _opacityAnimation,
      child: ScaleTransition( // أنيميشن التكبير
        scale: _scaleAnimation,
        child: GestureDetector( // عشان نتحكم في الضغط على الكارت
          onTap: () {
            // لما نضغط على الفيلم يفتح صفحة التفاصيل
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MovieDetailsPage(movie: widget.movie),
              ),
            );
          },
          child: Stack( // عشان نقدر نحط زر المفضلة فوق الصورة
            children: [
              Column( // عرض الصورة والعنوان تحتها
                children: [
                  Expanded(
                    child: Hero( // أنيميشن بين الصفحات عند الانتقال
                      tag: widget.movie.id, // نفس الـ tag في صفحة التفاصيل
                      child: ClipRRect( // قص الزوايا لتكون دائرية
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w200${widget.movie.posterPath}', // رابط الصورة
                          width: double.infinity,
                          fit: BoxFit.cover, // الصورة تملأ الكارت
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.movie.title, // اسم الفيلم
                    maxLines: 2, // سطرين فقط
                    overflow: TextOverflow.ellipsis, // لو العنوان طويل
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
              Positioned( // لتحديد مكان زر المفضلة فوق الصورة
                top: 8,
                right: 8,
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.white70, // خلفية شبه شفافة
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border, // شكل القلب
                      color: isFav ? Colors.red : Colors.grey, // اللون حسب الحالة
                      size: 18,
                    ),
                    onPressed: () {
                      // عند الضغط نضيف أو نحذف الفيلم من المفضلة
                      context.read<WishlistCubit>().toggleWishlist(widget.movie);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
