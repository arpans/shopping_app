import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/bloc/auth/auth_bloc.dart';
import 'package:shopping_app/bloc/profile/profile_bloc.dart';
import 'package:shopping_app/repositories/product_repository.dart';
import 'package:shopping_app/repositories/user_repository.dart';
import 'package:shopping_app/screens/login_screen.dart';
import 'package:shopping_app/screens/product_listing_screen.dart';
import 'package:shopping_app/screens/product_detail_screen.dart';
import 'package:shopping_app/screens/register_screen.dart';
import 'package:shopping_app/screens/profile_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyAwGekadYEJib1QGqsQDh3miWRw5NyMvWc',
    appId: '1:384330695975:android:83675fd998e584b5ab5502',
    messagingSenderId: '384330695975',
    projectId: 'shopping-app-62ee6',
    storageBucket: 'shopping-app-62ee6.appspot.com"',
  ));
  final userRepository = UserRepository();
  runApp(MyApp(userRepository: userRepository));
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;

  const MyApp({super.key, required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => ProductRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => AuthBloc()..add(CheckAuthStatusEvent())),
          BlocProvider<ProfileBloc>(
            create: (context) => ProfileBloc(userRepository: userRepository),
          ),
        ],
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AuthAuthenticated) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                initialRoute: '/productListing',
                routes: {
                  '/login': (context) => LoginScreen(),
                  '/register': (context) => RegisterScreen(),
                  '/productListing': (context) => ProductListingScreen(),
                  '/productDetail': (context) => ProductDetailScreen(),
                  '/profile': (context) => ProfileScreen(),
                },
              );
            } else {
              return MaterialApp(
                initialRoute: '/login',
                routes: {
                  '/login': (context) => LoginScreen(),
                  '/register': (context) => RegisterScreen(),
                  '/productListing': (context) => ProductListingScreen(),
                  '/productDetail': (context) => ProductDetailScreen(),
                  '/profile': (context) => ProfileScreen(),
                },
              );
            }
          },
        ),
      ),
    );
  }
}
