abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppBottomNavigationState extends AppStates {}
/// Home News
class NewsGetHomeLoadingState extends AppStates {}

class NewsGetHomeSuccessState extends AppStates {}

class NewsGetHomeErrorState extends AppStates {
  final String error;

  NewsGetHomeErrorState(this.error);
}
/// Home News end

/// Trending News
class NewsGetTrendingLoadingState extends AppStates {}

class NewsGetTrendingSuccessState extends AppStates {}

class NewsGetTrendingErrorState extends AppStates {
  final String error;

  NewsGetTrendingErrorState(this.error);
}
/// Trending News end

/// Sports News
class NewsGetSportLoadingState extends AppStates {}

class NewsGetSportSuccessState extends AppStates {}

class NewsGetSportErrorState extends AppStates {
  final String error;

  NewsGetSportErrorState(this.error);
}
/// Sports News end

// Toggle App Mode
class AppModeState extends AppStates{}

/// Search News
class NewsGetSearchLoadingState extends AppStates {}

class NewsGetSearchSuccessState extends AppStates {}

class NewsGetSearchErrorState extends AppStates {
  final String error;

  NewsGetSearchErrorState(this.error);
}
/// Search News end

// Scroll end state
class AppScrollState extends AppStates {}
