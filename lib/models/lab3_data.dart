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

  factory Lab3Data.fromJson(Map<String, dynamic> json) {
    final home = json['fitnessHomePage'] as Map<String, dynamic>;
    final challenge = home['todaysChallenge'] as Map<String, dynamic>;
    final plans = home['featuredPlans'] as List<dynamic>;
    final workouts = home['workoutPrograms'] as Map<String, dynamic>;
    final gym =
        (json['fitnessGymDetailsPage'] as Map<String, dynamic>)['gym']
            as Map<String, dynamic>;
    final pricing = gym['pricing'] as Map<String, dynamic>;
    return Lab3Data(
      challenge: ChallengeData(
        title: challenge['title'] as String,
        activity: challenge['activity'] as String,
        completed: challenge['completed'] as int,
        total: challenge['total'] as int,
      ),
      featuredPlans: plans
          .map(
            (item) => FeaturedPlanData.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
      filters: (workouts['filters'] as List<dynamic>)
          .map((item) => (item as Map<String, dynamic>)['name'] as String)
          .toList(),
      programs: (workouts['items'] as List<dynamic>)
          .map((item) => WorkoutData.fromJson(item as Map<String, dynamic>))
          .toList(),
      gym: GymData(
        name: gym['name'] as String,
        location: gym['location'] as String,
        imageUrl: gym['heroImageUrl'] as String,
        rating: (gym['rating'] as num).toDouble(),
        reviews: gym['reviewCount'] as int,
        description: gym['description'] as String,
        amenities: (gym['amenities'] as List<dynamic>)
            .map((item) => (item as Map<String, dynamic>)['name'] as String)
            .toList(),
        price: (pricing['amount'] as num).toDouble(),
        currency: pricing['currency'] as String,
        period: pricing['period'] as String,
      ),
    );
  }
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
  factory FeaturedPlanData.fromJson(Map<String, dynamic> json) =>
      FeaturedPlanData(
        title: json['title'] as String,
        duration: json['duration'] as String,
        frequency: json['frequency'] as String,
        imageUrl: json['imageUrl'] as String,
      );
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
  factory WorkoutData.fromJson(Map<String, dynamic> json) => WorkoutData(
    id: json['id'] as String,
    title: json['title'] as String,
    calories: json['calories'] as int,
    minutes: json['durationMinutes'] as int,
    isPro: json['isPro'] as bool,
    imageUrl: json['imageUrl'] as String,
  );
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
