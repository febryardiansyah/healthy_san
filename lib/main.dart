import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthy_san/bloc/delete_post/delete_post_cubit.dart';
import 'package:healthy_san/bloc/get_all_forums/get_all_forums_cubit.dart';
import 'package:healthy_san/bloc/get_answers/get_answers_cubit.dart';
import 'package:healthy_san/bloc/get_article_list/get_article_list_cubit.dart';
import 'package:healthy_san/bloc/get_detail_article/get_detail_article_cubit.dart';
import 'package:healthy_san/bloc/get_detail_post/get_detail_post_cubit.dart';
import 'package:healthy_san/bloc/get_my_post/get_my_post_cubit.dart';
import 'package:healthy_san/bloc/get_new_article/get_new_article_cubit.dart';
import 'package:healthy_san/bloc/get_popular_article/get_popular_article_cubit.dart';
import 'package:healthy_san/bloc/get_profile/get_profile_cubit.dart';
import 'package:healthy_san/bloc/login/login_cubit.dart';
import 'package:healthy_san/bloc/post_answer/post_answer_cubit.dart';
import 'package:healthy_san/bloc/post_question/post_question_cubit.dart';
import 'package:healthy_san/bloc/register/register_cubit.dart';
import 'package:healthy_san/bloc/auth/auth_cubit.dart';
import 'package:healthy_san/bloc/save_image_profile/save_image_profile_cubit.dart';
import 'package:healthy_san/ui/splash_screen.dart';
import 'package:healthy_san/utils/routes.dart';
import 'bloc/update_profile/update_profile_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RegisterCubit(),),
        BlocProvider(create: (context) => LoginCubit(),),
        BlocProvider(create: (context) => AuthCubit(),),
        BlocProvider(create: (context) => GetProfileCubit(),),
        BlocProvider(create: (context) => SaveImageProfileCubit(),),
        BlocProvider(create: (context) => UpdateProfileCubit(),),
        BlocProvider(create: (context) => PostQuestionCubit(),),
        BlocProvider(create: (context) => GetAllForumsCubit(),),
        BlocProvider(create: (context) => GetMyPostCubit(),),
        BlocProvider(create: (context) => DeletePostCubit(),),
        BlocProvider(create: (context) => GetDetailPostCubit(),),
        BlocProvider(create: (context) => PostAnswerCubit(),),
        BlocProvider(create: (context) => GetAnswersCubit(),),
        BlocProvider(create: (context) => GetPopularArticleCubit(),),
        BlocProvider(create: (context) => GetNewArticleCubit(),),
        BlocProvider(create: (context) => GetDetailArticleCubit(),),
        BlocProvider(create: (context) => GetArticleListCubit(),),
      ],
      child: MaterialApp(
        title: 'Healthy.San',
        debugShowCheckedModeBanner: false,
        navigatorKey: NAV_KEY,
        onGenerateRoute: generateRoute,
        home: SplashScreen(),
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(textTheme),
        ),
      ),
    );
  }
}
