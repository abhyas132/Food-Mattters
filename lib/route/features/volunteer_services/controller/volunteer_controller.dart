import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods_matters/route/features/volunteer_services/repository/volunteer_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../../models/food_model.dart';

final volunteerControllerProvider = Provider(
  (ref) {
    final volunteerRepository = ref.watch(volunteerRepositoryProvider);
    return VolunteerController(volunteerRepository: volunteerRepository);
  },
);

class VolunteerController {
  final VolunteerRepository volunteerRepository;
  VolunteerController({required this.volunteerRepository});
  Future<void> sendTargetPostRequest(
      List<String> listOfSelectedPosts, String volunteerFirebaseId) async {
    await volunteerRepository.sendTargetPostRequest(
        listOfSelectedPosts, volunteerFirebaseId);
  }

  Future<List<Food>> getAllSelectedPosts(String volunteerFirebaseId) async {
    return await volunteerRepository.getAllSelectedPosts(
        volunteerFirebaseId: volunteerFirebaseId);
  }
}
