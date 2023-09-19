
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skin_cancer_app/shared/cubit/cubit.dart';
import 'package:skin_cancer_app/shared/cubit/states.dart';
import 'package:skin_cancer_app/shared/shared_pref.dart';
import 'package:skin_cancer_app/themes/themes.dart';

import 'app_layout/cubit/cubit.dart';
import 'components/constants.dart';
import 'shared/dio_helper.dart';
import 'home_view.dart';
import 'login/shop_login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CachHelper.init();
  Widget widget;
  token = CachHelper.getData(key: 'token');
  print(token);
  if (token != null) {
    widget = ClassificationScreen();
  } else
    widget = ShopLoginScreen();

  runApp(MyApp(startwidget: widget));
}

class MyApp extends StatelessWidget {
  final Widget startwidget;
  MyApp({required this.startwidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit(),
        ),
        BlocProvider(
          create: (context) => ShopCubit()..getUserData(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        builder: (BuildContext context, state) {
          return MaterialApp(
            theme: lighttheme,
            debugShowCheckedModeBanner: false,
            home: startwidget,
          );
        },
        listener: (BuildContext context, Object? state) {},
      ),
    );
  }
}
