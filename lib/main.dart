import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:elisoft_test/main_controller/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pages/pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp(
      connection: Connectivity(),
    ));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.connection}) : super(key: key);
  final Connectivity connection;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                ConnectivityCubit(internetAdaptor: connection)),
        BlocProvider(create: (context) => AccountBloc()),
        BlocProvider(
            create: (context) =>
                LoginBloc(accountController: context.read<AccountBloc>())),
      ],
      child: MaterialApp(
        initialRoute: '/LoginScreen',
        routes: {
          '/LoginScreen': (context) => LoginPage(),
        },
        title: 'Elisoft Test',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        builder: (context, child) {
          final mediaQueryData = MediaQuery.of(context);
          final scale = mediaQueryData.textScaleFactor.clamp(0.8, 0.8);
          return MediaQuery(
            child: child!,
            data: MediaQuery.of(context).copyWith(textScaleFactor: scale),
          );
        },
      ),
    );
  }
}
