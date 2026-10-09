import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/base_button.dart';
import '../../core/widgets/base_container.dart';
import '../../core/widgets/base_text.dart';
import '../../data/models/entity.dart';
import '../bloc/entity_bloc.dart';

/// Универсальный экран: Grid в 2 колонки + сортировка по алфавиту.
class EntitiesScreen<T extends Entity> extends StatefulWidget {
  const EntitiesScreen({super.key, required this.title, required this.neon});
  final String title;
  final Color neon;

  @override
  State<EntitiesScreen<T>> createState() => _EntitiesScreenState<T>();
}

class _EntitiesScreenState<T extends Entity> extends State<EntitiesScreen<T>> {
  final _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<EntityBloc<T>>().add(FetchEntities());
    _scroll.addListener(() {
      if (_scroll.position.pixels > _scroll.position.maxScrollExtent - 300) {
        context.read<EntityBloc<T>>().add(FetchEntities());
      }
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: BaseText(widget.title, size: 20, color: widget.neon),
        actions: [
          BlocBuilder<EntityBloc<T>, EntityState<T>>(
            builder: (c, s) => Padding(
              padding: const EdgeInsets.only(right: 12),
              child: BaseButton(
                label: s.ascending ? 'A → Z' : 'Z → A',
                icon: Icons.sort_by_alpha,
                color: widget.neon,
                onTap: () => c.read<EntityBloc<T>>().add(ToggleSort()),
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<EntityBloc<T>, EntityState<T>>(
        builder: (context, s) {
          if (s.items.isEmpty) {
            return Center(
              child: s.status == LoadStatus.failure
                  ? BaseButton(
                      label: 'Повторить',
                      icon: Icons.refresh,
                      onTap: () => context.read<EntityBloc<T>>().add(FetchEntities()))
                  : CircularProgressIndicator(color: widget.neon),
            );
          }
          final list = s.sorted;
          return GridView.builder(
            controller: _scroll,
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 18,
              crossAxisSpacing: 18,
              childAspectRatio: 0.72,
            ),
            itemCount: list.length,
            itemBuilder: (_, i) => EntityCard(entity: list[i], neon: widget.neon),
          );
        },
      ),
    );
  }
}

class EntityCard extends StatelessWidget {
  const EntityCard({super.key, required this.entity, required this.neon});
  final Entity entity;
  final Color neon;

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      neonColor: neon,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        if (entity.imageUrl != null)
          Expanded(
            flex: 3,
            child: Image.network(entity.imageUrl!, fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.broken_image)),
          ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BaseText(entity.name, size: 14, maxLines: 2),
                const SizedBox(height: 6),
                BaseText(entity.subtitle, size: 11, color: neon, maxLines: 1),
                const SizedBox(height: 4),
                BaseText(entity.caption, size: 10, color: AppColors.textSecondary,
                    weight: FontWeight.w500, maxLines: 2),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
