import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_base/domain/entites/pagination/pagination.dart';
import 'package:flutter_bloc_base/domain/entites/photo/photo_list.dart';
import 'package:flutter_bloc_base/domain/usecases/photo_usecase.dart';
import 'package:flutter_bloc_base/ui/base/cubit_mixin.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> with BlocMixin {
  final PhotoUseCase _photoUseCase;

  HomeBloc(this._photoUseCase) : super(const HomeState()) {
    on<_GetPhoto>(getPhoto);
  }

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  Future<void> getPhoto(_GetPhoto event, Emitter<HomeState> emit) async {
    emit(state.copyWith(listStatus: ListStatus.loading));
    try {
      final result = await _photoUseCase.searchPhoto(
        query: event.query,
        page: event.isRefresh ? 1 : state.photos.pagination.page + 1,
      );
      emit(
        state.copyWith(
          listStatus: ListStatus.success,
          photos: event.isRefresh
              ? result
              : PhotoList(
                  pagination: result.pagination,
                  photos: state.photos.photos + result.photos,
                ),
        ),
      );
    } on Exception catch (error) {
      emit(
        state.copyWith(listStatus: ListStatus.failure),
      );
      setThrowable(error);
    } finally {
      resetRefreshController();
    }
  }

  @override
  Future<void> close() {
    refreshController.dispose();
    return super.close();
  }

  void resetRefreshController() {
    refreshController.refreshCompleted();
    refreshController.loadComplete();
  }
}
