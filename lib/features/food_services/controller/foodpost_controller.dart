import 'package:foods_matters/features/food_services/repository/foodpost_repository.dart';
import 'package:riverpod/riverpod.dart';
import 'package:image_picker/image_picker.dart';

final foodControllerProvider = Provider((ref) {
  final foodPostRepositoryProvider = ref.watch(foodRepostitoryProvider);
  return FoodPostController(foodPostRepositoryProvider);
});

class FoodPostController {
  final foodPostRepository;
  FoodPostController(this.foodPostRepository);
  late String base64image = "";

  Future<void> selectImage(bool useCamera) async {
    base64image = await foodPostRepository.getImage(true) ?? "";
  }
  
}
