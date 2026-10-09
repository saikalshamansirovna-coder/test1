import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/entity.dart';
import '../../data/repository/entity_repository.dart';
import '../bloc/entity_bloc.dart';
import 'entities_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => EntityBloc<Character>(EntityRepository('character', Character.fromJson))),
        BlocProvider(create: (_) => EntityBloc<LocationModel>(EntityRepository('location', LocationModel.fromJson))),
        BlocProvider(create: (_) => EntityBloc<Episode>(EntityRepository('episode', Episode.fromJson))),
      ],
      child: Scaffold(
        body: IndexedStack(index: _index, children: const [
          EntitiesScreen<Character>(title: 'Персонажи', neon: AppColors.neonGreen),
          EntitiesScreen<LocationModel>(title: 'Локации', neon: AppColors.neonPink),
          EntitiesScreen<Episode>(title: 'Эпизоды', neon: AppColors.neonBlue),
        ]),
        bottomNavigationBar: NavigationBar(
          backgroundColor: AppColors.surface,
          selectedIndex: _index,
          onDestinationSelected: (i) => setState(() => _index = i),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.person), label: 'Персонажи'),
            NavigationDestination(icon: Icon(Icons.public), label: 'Локации'),
            NavigationDestination(icon: Icon(Icons.movie), label: 'Эпизоды'),
          ],
        ),
      ),
    );
  }
}
