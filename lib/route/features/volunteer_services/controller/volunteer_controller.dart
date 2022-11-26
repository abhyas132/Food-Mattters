import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods_matters/route/features/volunteer_services/repository/volunteer_repository.dart';

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
    print(listOfSelectedPosts);
    print(volunteerFirebaseId);
    await volunteerRepository.sendTargetPostRequest(
        listOfSelectedPosts, volunteerFirebaseId);
  }
}
