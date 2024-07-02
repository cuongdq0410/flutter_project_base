import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_base/ui/base/base_screen.dart';
import 'package:flutter_bloc_base/ui/dashboard/home/bloc/home_bloc.dart';
import 'package:flutter_bloc_base/ui/widget/common_refresher.dart';
import 'package:flutter_bloc_base/ui/widget/custom_cache_image_network.dart';

import '../../../utils/debouncer.dart';

class HomeScreen extends BaseScreen {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen, HomeBloc> {
  Debouncer _debouncer = Debouncer();

  @override
  afterBuild() {
    bloc.add(const HomeEvent.getPhoto());
  }

  @override
  Widget buildContent(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (value) {
                      _debouncer.call(
                        () {
                          bloc.add(HomeEvent.getPhoto(query: value));
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: CommonRefresher(
                      enablePullDown: true,
                      enablePullUp: state.photos.photos.length <
                          state.photos.pagination.totalResults,
                      onRefresh: () {
                        bloc.add(const HomeEvent.getPhoto());
                      },
                      onLoading: () {
                        bloc.add(
                          const HomeEvent.getPhoto(isRefresh: false),
                        );
                      },
                      controller: bloc.refreshController,
                      child: state.photos.photos.isEmpty &&
                              state.listStatus == ListStatus.loading
                          ? const Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: state.photos.photos.length,
                              itemBuilder: (context, index) {
                                final photo = state.photos.photos[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: CustomCacheImageNetwork(
                                    radius: 20,
                                    height: 300,
                                    width: double.infinity,
                                    imageUrl: photo.originalSrcUrl,
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }
}
