import 'package:docu_sync/colors.dart';
import 'package:docu_sync/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void signOut(WidgetRef ref){
    ref.read(AuthRepositoryProvider).signOut();
    ref.read(userProvider.notifier).update(( state ) => null);
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) { 
      return Scaffold(
      
      appBar: AppBar(
      backgroundColor: kWhiteColor,
      elevation: 0,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.add, color: kBlackColor, )),
          IconButton(onPressed: ()=> signOut(ref), icon: Icon(Icons.logout, color: kRedColor,)),

        ],
      ),
      body: Center(child: Text(ref.watch(userProvider)!.uid ?? "wtf"),),
    );
  }
}

