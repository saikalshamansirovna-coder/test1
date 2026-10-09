import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/entity.dart';
import '../../data/repository/entity_repository.dart';

abstract class EntityEvent {}
class FetchEntities extends EntityEvent {}
class ToggleSort extends EntityEvent {}


enum LoadStatus { initial, loading, success, failure }

class EntityState<T extends Entity> {
  const EntityState({
    this.items = const [],
    this.status = LoadStatus.initial,
    this.ascending = true,
    this.page = 0,
    this.hasMore = true,
  });
  final List<T> items;
  final LoadStatus status;
  final bool ascending;
  final int page;
  final bool hasMore;

  List<T> get sorted {
    final list = [...items]..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    return ascending ? list : list.reversed.toList();
  }

  EntityState<T> copyWith({List<T>? items, LoadStatus? status, bool? ascending, int? page, bool? hasMore}) =>
      EntityState<T>(
        items: items ?? this.items,
        status: status ?? this.status,
        ascending: ascending ?? this.ascending,
        page: page ?? this.page,
        hasMore: hasMore ?? this.hasMore,
      );
}

class EntityBloc<T extends Entity> extends Bloc<EntityEvent, EntityState<T>> {
  EntityBloc(this._repo) : super(EntityState<T>()) {
    on<FetchEntities>(_onFetch);
    on<ToggleSort>((_, emit) => emit(state.copyWith(ascending: !state.ascending)));
  }
  final EntityRepository<T> _repo;

  Future<void> _onFetch(FetchEntities e, Emitter<EntityState<T>> emit) async {
    if (state.status == LoadStatus.loading || !state.hasMore) return;
    emit(state.copyWith(status: LoadStatus.loading));
    try {
      final r = await _repo.fetch(state.page + 1);
      emit(state.copyWith(
        items: [...state.items, ...r.items],
        page: state.page + 1,
        hasMore: r.hasNext,
        status: LoadStatus.success,
      ));
    } catch (_) {
      emit(state.copyWith(status: LoadStatus.failure));
    }
  }
}
