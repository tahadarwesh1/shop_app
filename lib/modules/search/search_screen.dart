import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Search',
              ),
              centerTitle: true,
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultTextField(
                      keyboardType: TextInputType.text,
                      controller: searchController,
                      label: 'Search',
                      prefixIcon: Icons.search,
                      validator: (value) {},
                      onFieldSubmitted: (text) {
                        SearchCubit.get(context).getSearch(text: text);
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    if (state is LoadingSearchState) LinearProgressIndicator(),
                    SizedBox(
                      height: 20.0,
                    ),
                    if (state is SuccessSearchState)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => buildProductItem(
                            SearchCubit.get(context)
                                .searchModel!
                                .data
                                .data[index],
                            context,
                            isOldPrice: false,
                          ),
                          separatorBuilder: (context, index) => SizedBox(
                            height: 5.0,
                          ),
                          itemCount: SearchCubit.get(context)
                              .searchModel!
                              .data
                              .data
                              .length,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
