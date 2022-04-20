import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthy_san/bloc/login/login_cubit.dart';
import 'package:healthy_san/bloc/register/register_cubit.dart';
import 'package:healthy_san/bloc/auth/auth_cubit.dart';
import 'package:healthy_san/ui/splash_screen.dart';
import 'package:healthy_san/utils/routes.dart';
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
