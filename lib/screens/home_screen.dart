import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/lab3_data.dart';
import '../state/lab3_cubit.dart';
import '../widgets/lab3_cards.dart';
import 'gym_json_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<Lab3Cubit, Lab3State>(
    builder: (context, state) {
      if (state.status == LoadStatus.loading) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }
      if (state.status == LoadStatus.error) {
        return Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Nu am putut încărca datele.'),
                  const SizedBox(height: 12),
                  Text(state.error ?? ''),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: context.read<Lab3Cubit>().load,
                    child: const Text('Reîncearcă'),
                  ),
                ],
              ),
            ),
          ),
        );
      }
      final data = state.data!;
      return Scaffold(
        appBar: AppBar(
          title: const Text('Fitness'),
          actions: [
            IconButton(
              tooltip: 'Sală de fitness',
              onPressed: () => _openGym(context, data.gym),
              icon: const Icon(Icons.location_on_outlined),
            ),
          ],
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.only(bottom: 24),
            children: [
              _challenge(context, data.challenge),
              _heading(context, 'Featured Plans'),
              SizedBox(
                height: 170,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: data.featuredPlans.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 12),
                  itemBuilder: (context, i) => FeaturedPlanCard(
                    plan: data.featuredPlans[i],
                    onTap: () => _openGym(context, data.gym),
                  ),
                ),
              ),
              _heading(context, 'Workout Programs'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search programs',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: context.read<Lab3Cubit>().setQuery,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 42,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: data.filters
                      .map(
                        (filter) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(filter),
                            selected: state.category == filter,
                            onSelected: (_) =>
                                context.read<Lab3Cubit>().setCategory(filter),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    const Text('Sort by:'),
                    const SizedBox(width: 8),
                    DropdownButton<ProgramSort>(
                      value: state.sort,
                      items: const [
                        DropdownMenuItem(
                          value: ProgramSort.name,
                          child: Text('Name'),
                        ),
                        DropdownMenuItem(
                          value: ProgramSort.calories,
                          child: Text('Calories'),
                        ),
                        DropdownMenuItem(
                          value: ProgramSort.duration,
                          child: Text('Duration'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          context.read<Lab3Cubit>().setSort(value);
                        }
                      },
                    ),
                    const Spacer(),
                    const Text('Favorites'),
                    Switch(
                      value: state.favoritesOnly,
                      onChanged: context.read<Lab3Cubit>().setFavoritesOnly,
                    ),
                  ],
                ),
              ),
              if (state.visiblePrograms.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(40),
                  child: Center(child: Text('No programs found')),
                )
              else
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.visiblePrograms.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          mainAxisExtent: 190,
                        ),
                    itemBuilder: (context, i) {
                      final item = state.visiblePrograms[i];
                      return WorkoutProgramCard(
                        program: item,
                        isFavorite: state.favoriteIds.contains(item.id),
                        onFavorite: () =>
                            context.read<Lab3Cubit>().toggleFavorite(item.id),
                        onTap: () => _openGym(context, data.gym),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      );
    },
  );

  Widget _challenge(BuildContext context, ChallengeData data) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 12, 20, 10),
    child: Card(
      color: Colors.black87,
      child: ListTile(
        title: Text(data.title, style: const TextStyle(color: Colors.white70)),
        subtitle: Text(
          data.activity,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
        trailing: CircularProgressIndicator(
          value: data.completed / data.total,
          backgroundColor: Colors.white24,
          color: Colors.greenAccent,
        ),
      ),
    ),
  );

  Widget _heading(BuildContext context, String text) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
    child: Text(
      text,
      style: Theme.of(context).textTheme.titleLarge
          ?.copyWith(fontWeight: FontWeight.bold),
    ),
  );

  void _openGym(BuildContext context, GymData gym) => Navigator.of(context)
      .push(
        MaterialPageRoute<void>(builder: (_) => GymJsonDetailScreen(gym: gym)),
      );
}
