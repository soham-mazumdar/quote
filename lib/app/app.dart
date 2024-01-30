import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quote/di/di.dart';
import 'package:quote/app/router/app_router.dart';
import 'package:quote/features/blocs/quote/quote_cubit.dart';
import 'package:quote/features/home/views/home_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<QuoteCubit>(
            create: (context) => getItInstance<QuoteCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Started Kit',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        onGenerateRoute: AppRouter().onGenerateRoute,
        home: const HomeScreen(),
      ),
    );
  }
}
