import 'package:foods_matters/models/request_model.dart';
import 'package:foods_matters/route/features/food_services/repository/foodpost_repository.dart';
import 'package:foods_matters/models/food_model.dart';
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

  Future<List<Food>> getMyActiveReq() async {
    return await foodPostRepository.getMyActiveReq();
  }

  Future<int> toggleFoodPostAvailablity(String newValue, String foodId) async {
    return await foodPostRepository.toggleFoodPostAvailablity(newValue, foodId);
  }

  Future<List<Food>> getAllMyFoodReq() async {
    return await foodPostRepository.getAllMyReq();
  }

  Future<List<Food>> getFoodFeedToConsumer() async {
    return await foodPostRepository.getFoodFeedToConsumer();
  }

  Future<int> reqForFood(String postId) async {
    return await foodPostRepository.reqForFood(postId);
  }

  Future<List<Request>> getAllMyFoodPostReq(String foodPostId) async {
    return await foodPostRepository.getAllMyFoodPostReq(foodPostId);
  }

  Future<int> CancelReq({
    required String requestId,
    required String newStatus,
  }) async {
    return foodPostRepository.CancelReq(
        requestId: requestId, newStatus: newStatus);
  }

  Future<List<Request>> getAllMyRequestSentAsConsumer() async {
    return await foodPostRepository.getAllMyRequestSentAsConsumer();
  }
}
