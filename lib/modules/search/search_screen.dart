import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/componants/componants.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController(); // Search controller

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder:(context, state)
      {
        final cubit = AppCubit.get(context);

        var list = cubit.search;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Search',
            ),
            centerTitle: true,
          ),
          body: Column(
            children:
            [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: defaultFormField(
                    validation: null,
                    hintText: 'Search anything?',
                    controller: searchController,
                    type: TextInputType.text,
                    prefix: Icons.search,
                    actionBtn: TextInputAction.done,
                    onChanged: (value)
                    {
                      cubit.getSearch(value);
                    }
                ),
              ),
              Expanded(child: articleBuilder(list, context,isSearch: true))
            ],
          ),
        );
      }
    );
  }
}
