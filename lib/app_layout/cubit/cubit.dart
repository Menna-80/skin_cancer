import 'package:bloc/bloc.dart';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skin_cancer_app/app_layout/cubit/states.dart';
import '../../components/constants.dart';
import '../../shared/dio_helper.dart';
import '../../shared/end_points.dart';
import '../../shared/login_model.dart';


class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopinitState());
  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;








  ShopLoginModel? userModel;
   void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromjson(value?.data);
      emit(ShopGetUserDataSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopGetUserDataErrorState());
    });
  }
}
