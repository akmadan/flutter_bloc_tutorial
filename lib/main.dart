import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_bloc/features/home/bloc/home_bloc.dart';
import 'package:simple_bloc/features/home/ui/home.dart';
import 'package:simple_bloc/features/notify/bloc/notify_bloc.dart';
import 'package:simple_bloc/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:simple_bloc/utils/constants.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    MaterialColor msThemeColor =
        MaterialColor(kThemeColour.value, const <int, Color>{
      50: kThemeColour,
      100: kThemeColour,
      200: kThemeColour,
      300: kThemeColour,
      400: kThemeColour,
      500: kThemeColour,
      600: kThemeColour,
      700: kThemeColour,
      800: kThemeColour,
      900: kThemeColour,
    });
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => WishlistBloc(),
            ),
            BlocProvider(
              create: (context) => HomeBloc(),
            ),
            BlocProvider(
              create: (context) => NotifyBloc(),
            ),
            BlocProvider(
              create: (context) => NotifyCartBloc(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primaryColor: kThemeColour,
              primarySwatch: msThemeColor,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
            ),
            home: const Home(),
          ),
        );
      },
    );
  }
}
