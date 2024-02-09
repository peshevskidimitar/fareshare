import 'package:fareshare/application_state.dart';
import 'package:fareshare/service/blocs/post/post_bloc.dart';
import 'package:fareshare/presentation/pages/splash/splash_page.dart';
import 'package:fareshare/repository/post/post_repository.dart';
import 'package:fareshare/repository/reservation/reservation_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
    create: (context) => ApplicationState(),
    builder: (context, child) => const App(),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => PostRepository()),
        RepositoryProvider(create: (context) => ReservationRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                PostBloc(postRepository: context.read<PostRepository>())
                  ..add(LoadPosts()),
          ),
        ],
        child: MaterialApp(
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          supportedLocales: const [
            Locale('mk'),
          ],
          debugShowCheckedModeBanner: false,
          title: 'FareShare',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromRGBO(72, 40, 61, 1.0)),
            useMaterial3: true,
          ),
          home: const SplashPage(),
        ),
      ),
    );
  }
}
