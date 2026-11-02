import 'package:flutter/material.dart';

import '../models/lab3_data.dart';

class FeaturedPlanCard extends StatelessWidget {
  const FeaturedPlanCard({super.key, required this.plan, required this.onTap});
  final FeaturedPlanData plan;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 280,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            plan.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => Container(color: Colors.blueGrey),
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black87],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  plan.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${plan.duration}  •  ${plan.frequency}',
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 10),
                FilledButton(onPressed: onTap, child: const Text('Start Now')),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class WorkoutProgramCard extends StatelessWidget {
  const WorkoutProgramCard({
    super.key,
    required this.program,
    required this.isFavorite,
    required this.onFavorite,
    required this.onTap,
  });
  final WorkoutData program;
  final bool isFavorite;
  final VoidCallback onFavorite, onTap;

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(14),
    child: Material(
      color: Colors.black,
      child: InkWell(
        onTap: onTap,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              program.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(color: Colors.blueGrey),
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black87],
                ),
              ),
            ),
            Positioned(
              right: 4,
              top: 4,
              child: IconButton(
                onPressed: onFavorite,
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.redAccent : Colors.white,
                ),
              ),
            ),
            if (program.isPro)
              const Positioned(
                left: 10,
                top: 12,
                child: Chip(
                  visualDensity: VisualDensity.compact,
                  label: Text('PRO'),
                ),
              ),
            Positioned(
              left: 12,
              right: 8,
              bottom: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    program.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${program.calories} kcal  •  ${program.minutes} min',
                    style: const TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
