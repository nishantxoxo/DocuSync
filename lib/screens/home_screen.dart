import 'package:docu_sync/colors.dart';
import 'package:docu_sync/models/error_model.dart';
import 'package:docu_sync/repository/auth_repository.dart';
import 'package:docu_sync/repository/document_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void signOut(WidgetRef ref){
    ref.read(AuthRepositoryProvider).signOut();
    ref.read(userProvider.notifier).update(( state ) => null);
  }

void createDocument(WidgetRef ref, BuildContext ct) async{
  String token = ref.read(userProvider)!.token;

  final navigator = Routemaster.of(ct);
  final snackBar = ScaffoldMessenger.of(ct);

  final ErrorModel =  await ref.read(documentRepositoryProvider).createDocument(token);

  if(ErrorModel.data != null){
    navigator.push('/document/${ErrorModel.data.id}');

  }

  else{
    snackBar.showSnackBar(SnackBar(content: Text(ErrorModel.error!)));
  }


}

  @override
  Widget build(BuildContext context, WidgetRef ref) { 
      return Scaffold(
      
      appBar: AppBar(
      backgroundColor: kWhiteColor,
      elevation: 0,
        actions: [
          IconButton(onPressed: ()=> createDocument(ref, context), icon: Icon(Icons.add, color: kBlackColor, )),
          IconButton(onPressed: ()=> signOut(ref), icon: Icon(Icons.logout, color: kRedColor,)),

        ],
      ),
      body: Center(child: Text(ref.watch(userProvider)!.uid ?? "wtf"),),
    );
  }
}

