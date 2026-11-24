class Lab3Data {
  const Lab3Data({
    required this.challenge,
    required this.featuredPlans,
    required this.filters,
    required this.programs,
    required this.gym,
  });

  final ChallengeData challenge;
  final List<FeaturedPlanData> featuredPlans;
  final List<String> filters;
  final List<WorkoutData> programs;
  final GymData gym;

}

class ChallengeData {
  const ChallengeData({
    required this.title,
    required this.activity,
    required this.completed,
    required this.total,
  });
  final String title, activity;
  final int completed, total;
}

class FeaturedPlanData {
  const FeaturedPlanData({
    required this.title,
    required this.duration,
    required this.frequency,
    required this.imageUrl,
  });
  final String title, duration, frequency, imageUrl;
}

class WorkoutData {
  const WorkoutData({
    required this.id,
    required this.title,
    required this.calories,
    required this.minutes,
    required this.isPro,
    required this.imageUrl,
  });
  final String id, title, imageUrl;
  final int calories, minutes;
  final bool isPro;
}

class GymData {
  const GymData({
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.rating,
    required this.reviews,
    required this.description,
    required this.amenities,
    required this.price,
    required this.currency,
    required this.period,
  });
  final String name, location, imageUrl, description, currency, period;
  final List<String> amenities;
  final double rating, price;
  final int reviews;
}
