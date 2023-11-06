import 'package:chat_x/model/auth/UserModel.dart';
import 'package:chat_x/util/constant.dart';
import 'package:get_storage/get_storage.dart';

class PrefHelper {


  static saveUserProfileData(UserModel userModel) async {
    GetStorage storage = GetStorage();
    await storage.write(Constant.USER_PROFILE, userModel);
  }

  static UserModel getUserProfileData() {
    GetStorage storage=GetStorage();
    return storage.read(Constant.USER_PROFILE) as UserModel;
  }

  static setWelcomePageFlag(bool value) async{
    GetStorage storage=GetStorage();
    await storage.write(Constant.ISWELCOME, value);
  }

  static bool getWelcomeFlag(){
    GetStorage storage=GetStorage();
    if(storage.hasData(Constant.ISWELCOME)){
      return storage.read(Constant.ISWELCOME) as bool;
    }
    return false;
  }

  static void setEmailAndPassword(String email,String pwd) async{
    GetStorage storage=GetStorage();
    setPasswordFlag(true);
    await storage.write("email", email);
    await storage.write("password", pwd);
  }

  static String? getEmail(){
    GetStorage storage=GetStorage();
    if(storage.hasData("email")){
      return storage.read("email");
    }
    return null;
  }

  static String? getPassword(){
    GetStorage storage=GetStorage();
    if(storage.hasData("password")){
      return storage.read("password");
    }
    return null;
  }

  static Future<void> setPasswordFlag(bool value) async {
    GetStorage storage=GetStorage();
    await storage.write(Constant.ISPASSWORD_SAVED, value);
  }

  static bool getIsPasswordSaved(){
    GetStorage storage=GetStorage();
    if(storage.hasData(Constant.ISPASSWORD_SAVED)){
      return storage.read(Constant.ISPASSWORD_SAVED) as bool;
    }
    return false;
  }


}