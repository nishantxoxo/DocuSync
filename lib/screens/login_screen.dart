import 'package:docu_sync/colors.dart';
import 'package:docu_sync/repository/auth_repository.dart';
import 'package:docu_sync/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});


  void signInWithGoogle(WidgetRef ref, BuildContext ct) async{
    final sMessanger = ScaffoldMessenger.of(ct);
    final navigator = Routemaster.of(ct);
    final errormodel = await    ref.read(AuthRepositoryProvider).signInWithGoogle();
    if(errormodel.error == null){
      ref.read(userProvider.notifier).update((state)=> errormodel.data);

      navigator.push('/');
   
    
    }else{
    sMessanger.showSnackBar(SnackBar(content: Text(errormodel.error!)));

    }


      }


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    


    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(150, 50),
            backgroundColor: kWhiteColor
          ),
          onPressed: ()=> signInWithGoogle(ref, context),
          label: Text("Sign in with Google", style:  TextStyle( color: kBlackColor),),
          icon: Image.asset('assets/images/g-logo-2.png', height: 20,),
        ),
      ),
    );
  }
}
