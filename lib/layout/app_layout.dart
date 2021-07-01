import 'package:flutter/material.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:news_app/shared/componants/componants.dart';
import 'package:news_app/shared/cubit/cubit.dart';

class AppLayout extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    final cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.search, size: 30,),
                onPressed: ()
                {
                  navigateTo(context, SearchScreen(),);
                },
              ),
              IconButton(
                icon: Icon(Icons.brightness_4_outlined, size: 30,),
                onPressed: () {
                  cubit.toggleAppMode();
                },
              ),
            ],
          ),

          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index)
            {
              cubit.changeBottomNavIndex(index);
            },
            items: cubit.bottomItems,
            currentIndex: cubit.currentIndex,
          ),
        );
      }

}
