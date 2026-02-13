import 'package:docu_sync/models/error_model.dart';
import 'package:docu_sync/repository/auth_repository.dart';
import 'package:docu_sync/router.dart';
import 'package:docu_sync/screens/home_screen.dart';
import 'package:docu_sync/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  // This widget is the root of your application.
  ErrorModel? errorModel;
  
  @override
  void initState() {
    // TODO: implement initState
    
    
    super.initState();
    getUserData();
  }
  void getUserData( ) async {
    errorModel = await ref.read(AuthRepositoryProvider).getUserData();
    if(errorModel != null && errorModel!.data != null){
      ref.read(userProvider.notifier).update( (state)=> errorModel!.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp.router(
      routeInformationParser: RoutemasterParser()  ,
      routerDelegate: RoutemasterDelegate(routesBuilder: (context){
          final user = ref.watch(userProvider);
          if(user!=null && user.token.isNotEmpty){
              return loggedInRoute;
          }
          return loggedOutRoute;


      }),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: user == null ? LoginScreen() : HomeScreen(),
    );
  }
}


//flutter run -d chrome --web-hostname localhost --web-port 3000