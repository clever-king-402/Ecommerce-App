import 'package:ecommerce_app/common/custom_theme.dart';
import 'package:ecommerce_app/common/repository/repository.dart';
import 'package:ecommerce_app/common/routes.dart';
import 'package:ecommerce_app/features/auth/ui/cubit/login_cubit.dart';
import 'package:ecommerce_app/features/auth/ui/cubit/register_cubit.dart';
import 'package:ecommerce_app/features/dashboard/ui/screens/dashboard_screens.dart';
import 'package:ecommerce_app/features/homepage/ui/screens/homepage_screens.dart';
import 'package:ecommerce_app/features/splash/ui/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => EcommerceRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                RegisterCubit(repository: EcommerceRepository()),
          ),
          BlocProvider(
            create: (context) => LoginCubit(repository: EcommerceRepository()),
          ),
        ],
        child: MaterialApp(
          title: 'Ecommerce',
          theme: ThemeData(
            primaryColor: CustomTheme.primaryColor,
            useMaterial3: false,
            textTheme: GoogleFonts.poppinsTextTheme(),
          ),
          home: const SplashPage(),
          onGenerateRoute: (settings) {
            if (settings.name == Routes.homePage) {
              return PageTransition(
                  child: DashboardScreens(),
                  type: PageTransitionType.bottomToTop);
            }
          },
        ),
      ),
    );
  }
}
