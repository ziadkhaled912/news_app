import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/home/home_screen.dart';
import 'package:news_app/modules/settings/settings_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/modules/trending/trending_screen.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class AppCubit extends Cubit<AppStates>
{
  // Cubit Constructor
  AppCubit() : super(AppInitialState());
  // Cubit methode
  static AppCubit get(context) => BlocProvider.of(context);
  // Current navigation index
  int currentIndex = 0;
  // bottom bar items
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
        icon: Icon(
            Icons.home_work,
        ),
      label: 'Home',
      tooltip: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.trending_up,
      ),
      label: 'Trending',
      tooltip: 'Trending',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sports',
      tooltip: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
      ),
      label: 'Settings',
      tooltip: 'Settings',
    ),
  ];
  // Change Bottom navigation function
  void changeBottomNavIndex(int index) {
      currentIndex = index;
      if(index == 1) {
        getTrending();
      }
      if(index == 2) {
        getSports();
      }
      emit(AppBottomNavigationState());
  }

  // List Of Screens
  List<Widget> screens = [
    HomeScreen(),
    TrendingScreen(),
    SportScreen(),
    SettingScreen(),
  ];
  // List Of Screens
  List<String> titles = [
    'Home',
    'Trending',
    'Sports',
    'Settings',
  ];
  // List of home content
  List<dynamic> home = [];

  void getHome()
  {
    emit(NewsGetHomeLoadingState()); // Emit loading state

    DioHelper.getData(
      url: 'v2/everything',
      query:
      {
        'q' : 'egypt',
        'sortBy' : 'publishedAt',
        'apiKey' : 'dbdb4d7862f446d098e5fc4138215105',
      },
    ).then((value) {
      home = value.data['articles']; // Save the data in the [home] map
      emit(NewsGetHomeSuccessState()); // Emit success state
    }).catchError((error){
      print(error.toString());
      emit(NewsGetHomeErrorState(error.toString())); // Emit Error State
    });
  }

  // List of trending content
  List<dynamic> trending = [];

  void getTrending()
  {
    emit(NewsGetTrendingLoadingState()); // Emit loading state

    if(trending.length == 0){
      DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'country' : 'eg',
          'apiKey' : 'dbdb4d7862f446d098e5fc4138215105',
        },
      ).then((value) {
        trending = value.data['articles']; // Save the data in the [home] map
        emit(NewsGetTrendingSuccessState()); // Emit success state
      }).catchError((error){
        print(error.toString());
        emit(NewsGetTrendingErrorState(error.toString())); // Emit Error State
      });
    } else {
      emit(NewsGetTrendingSuccessState()); // Emit success state
    }
  }

  // List of sports content
  List<dynamic> sports = [];

  void getSports()
  {
    emit(NewsGetSportLoadingState()); // Emit loading state

    if(sports.length == 0)
    {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'category' : 'sports',
          'country' : 'eg',
          'apiKey' : 'dbdb4d7862f446d098e5fc4138215105',
        },
      ).then((value) {
        sports = value.data['articles']; // Save the data in the [home] map
        emit(NewsGetSportSuccessState()); // Emit success state
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSportErrorState(error.toString())); // Emit Error State
      });
    } else {
      emit(NewsGetSportSuccessState()); // Emit success state
    }
  }

  // Theme mode toggle
  bool isDark = false;

  void toggleAppMode({bool fromShared}) {
    if(fromShared != null)
      isDark = fromShared;
    else
      isDark = !isDark;
    CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
      emit(AppModeState());
    });
  }

  // List of sports content
  List<dynamic> search = [];

  void getSearch(String value)
  {
    emit(NewsGetSearchLoadingState()); // Emit loading state

    search = [];
    if(search.length == 0)
    {
      DioHelper.getData(
        url: 'v2/everything',
        query:
        {
          'q'      : '$value',
          'apiKey' : 'dbdb4d7862f446d098e5fc4138215105',
        },
      ).then((value) {
        search = value.data['articles']; // Save the data in the [home] map
        emit(NewsGetSearchSuccessState()); // Emit success state
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSearchErrorState(error.toString())); // Emit Error State
      });
    } else {
      emit(NewsGetSearchSuccessState()); // Emit success state
    }
  }
  int itemsNumber = 0;
  // Scroll controller
  ScrollController scrollController = ScrollController();

  void addData(index) {
    index = index + 5;
    print(index);
    emit(AppScrollState());
  }
  void getMoreData() {
    if(currentIndex == 0){
      home = [];
      getHome();
    }
    if(currentIndex == 1) {
      trending = [];
      getTrending();
    }
    if(currentIndex == 2) {
      sports = [];
      getSports();
    }
  }
}