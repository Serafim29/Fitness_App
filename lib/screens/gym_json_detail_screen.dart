import 'package:flutter/material.dart';

import '../models/lab3_data.dart';

class GymJsonDetailScreen extends StatelessWidget {
  const GymJsonDetailScreen({super.key, required this.gym});
  final GymData gym;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 290,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(gym.name, maxLines: 1, overflow: TextOverflow.ellipsis),
            background: Image.network(
              gym.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(color: Colors.blueGrey),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${gym.rating} ★  (${gym.reviews} reviews)',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 6),
                Text(
                  gym.location,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 20),
                Text(
                  gym.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 20),
                Text(
                  'Amenities',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Wrap(
                  spacing: 8,
                  children: gym.amenities
                      .map((item) => Chip(label: Text(item)))
                      .toList(),
                ),
                const SizedBox(height: 18),
                Text(
                  '${gym.currency} ${gym.price.toStringAsFixed(2)} / ${gym.period}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Reservation saved')),
                    ),
                    child: const Text('Reserve'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
