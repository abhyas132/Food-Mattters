import 'package:foods_matters/features/food_services/repository/foodpost_repository.dart';
import 'package:riverpod/riverpod.dart';
import 'package:image_picker/image_picker.dart';

final foodControllerProvider = Provider((ref) {
  final foodPostRepositoryProvider = ref.watch(foodRepostitoryProvider);
  return FoodPostController(foodPostRepositoryProvider);
});

class FoodPostController {
  final FoodPostRepository foodPostRepository;
  FoodPostController(this.foodPostRepository);
  late String base64image = "";

  Future<void> selectImage(bool useCamera) async {
    base64image = await foodPostRepository.getImage(true) ?? "";
  }

  Future<int> addFoodPost({
    required String pushedBy,
    required bool isAvailable,
    required List<String> food,
    required num foodQuantity,
    required String foodType,
    required num foodLife,
  }) async {
    return await foodPostRepository.addFoodPost(
      pushedBy: pushedBy,
      isAvailable: isAvailable,
      food: food,
      foodQuantity: foodQuantity,
      foodType: foodType,
      foodLife: foodLife,
      photo: base64image,
    );
  }
}
