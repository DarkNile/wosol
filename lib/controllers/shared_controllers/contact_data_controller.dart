import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:wosol/models/contact_data_model.dart';
import '../../shared/services/network/dio_helper.dart';
import '../../shared/widgets/shared_widgets/snakbar.dart';

class ContactDataController extends GetxController {
  bool isLoading = false;

  ContactDataModel? contactDataModel;
  Future<void> getContactData() async {
    isLoading = true;
    update();
    try {
      Response response = await DioHelper.getData(
        url: 'contact_data/get_data',
      );
      if (response.statusCode == 200) {
        contactDataModel = ContactDataModel.fromJson(response.data['data']);
        isLoading = false;
        update();
      } else {
        defaultErrorSnackBar(
          context: Get.context!,
          message: response.data['data']['error'],
        );
        isLoading = false;
        update();
      }
    } on DioException catch (e) {
      defaultErrorSnackBar(
        context: Get.context!,
        message: e.response!.data['data']['error'],
      );
      isLoading = false;
      update();
    }
  }

  @override
  void onInit() {
    getContactData();
    super.onInit();
  }
}
