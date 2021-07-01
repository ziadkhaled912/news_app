import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/app_layout.dart';
import 'package:news_app/shared/componants/constants.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

void main() async{
  // To make sure run widgets after initialization (when main is async)
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init(); // Dio Initialize
  await CacheHelper.init(); // Cache Initialize

  bool isDark = CacheHelper.getData(key: 'isDark');
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {

  final bool isDark;

  MyApp(this.isDark);

  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getHome()..toggleAppMode(
        fromShared: isDark,
      ),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder:(context, state)
        {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'News App',
            theme: ThemeData(
              primaryColor: Colors.white,
              accentColor: primaryColor,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                brightness: Brightness.dark,
                backgroundColor: Colors.white,
                titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                  size: 30,
                ),
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.black,
                  statusBarBrightness: Brightness.dark,
                ),
                elevation: 0,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: primaryColor,
                backgroundColor: Colors.white,
                elevation: 20,
              ),

              textTheme: TextTheme(
                bodyText2: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            darkTheme: ThemeData(
              primaryColor: Colors.white,
              scaffoldBackgroundColor: backgroundDarkMode,
              accentColor: primaryColor,
              appBarTheme: AppBarTheme(
                brightness: Brightness.light,
                backgroundColor: backgroundDarkMode,
                // titleTextStyle: TextStyle(
                //     fontSize: 24,
                //     fontWeight: FontWeight.bold
                // ),
                iconTheme: IconThemeData(
                  color: Colors.white,
                  size: 30,
                ),
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: backgroundDarkMode,
                  statusBarBrightness: Brightness.light,
                ),
                elevation: 5,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: primaryColor,
                backgroundColor: backgroundDarkMode,
                elevation: 20,
                unselectedItemColor: Colors.white,
              ),
              textTheme: TextTheme(
                bodyText2: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            themeMode: AppCubit.get(context).isDark ? ThemeMode.dark :ThemeMode.light,
            home: AppLayout(),
          );
        },
      ),
    );
  }
}