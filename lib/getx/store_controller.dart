import 'package:chat_x/model/auth/UserModel.dart';
import 'package:get/state_manager.dart';

class StoreController extends GetxController{

  Rx<UserModel> userData=UserModel(id: "", name: "", email: "", password: "", colorId: 1, bio: "bio").obs;

  void updateProfileData(UserModel data){
    userData(data);
  }

}