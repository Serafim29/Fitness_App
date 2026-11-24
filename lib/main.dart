import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/lab3_repository.dart';
import 'data/lab3_remote_data_source.dart';
import 'domain/usecases/load_lab3_data.dart';
import 'screens/home_screen.dart';
import 'state/lab3_cubit.dart';
import 'theme/app_colors.dart';
import 'theme/app_text_styles.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) => Lab3Cubit(
        LoadLab3Data(Lab3RepositoryImpl(Lab3RemoteDataSource())),
      )..load(),
      child: const FitnessApp(),
    ),
  );
}

/// Aplicația de fitness după designul Figma „Laboratoare 2026” — varianta 3.
class FitnessApp extends StatelessWidget {
  const FitnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: AppTextStyles.fontFamily,
        scaffoldBackgroundColor: AppColors.greyscale0,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary500,
          primary: AppColors.primary500,
          surface: AppColors.greyscale0,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
