
import '../core/string_manager.dart';

class OnBoardingModel {
  final String image;
  final String title;
  final String description;

  OnBoardingModel({
    required this.image,
    required this.title,
    required this.description,
  });
}


List<OnBoardingModel> onBoardingList = [
  OnBoardingModel(
    image:"assets/images/img.png",
    title: StringManager.onBoardingTitle1,
    description: StringManager.onBoardingDescription1,
  ),
  OnBoardingModel(
    image: "assets/images/img_1.png",
    title: StringManager.onBoardingTitle2,
    description: StringManager.onBoardingDescription2,
  ),
  OnBoardingModel(
    image: "assets/images/img_2.png",
    title: StringManager.onBoardingTitle3,
    description: StringManager.onBoardingDescription3,
  ),
];


