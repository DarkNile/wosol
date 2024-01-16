class ProfileCustomModel {
  final String imagePath;
  final String title;
  final String subTitle;
  final void Function() onTap;

  ProfileCustomModel({
    required this.imagePath,
    required this.title,
    required this.subTitle,
    required this.onTap,
  });
}
