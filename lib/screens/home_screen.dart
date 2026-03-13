import 'package:docu_sync/colors.dart';
import 'package:docu_sync/common/widgets/loader.dart';
import 'package:docu_sync/models/document.dart';
import 'package:docu_sync/models/error_model.dart';
import 'package:docu_sync/repository/auth_repository.dart';
import 'package:docu_sync/repository/document_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
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

  void navigateToDocument(BuildContext context, String documentId){
    Routemaster.of(context).push('/document/$documentId');
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) { 
      return Scaffold(
      
      appBar: AppBar(
        title: Row(
          children: [
            GestureDetector( onTap: () {
                    Routemaster.of(context).replace('/');
                  }, child: Image.asset('assets/images/docs-logo.png', height: 50)),
                  SizedBox(width: 8,),
                   Text("My Documents", style:  GoogleFonts.roboto(fontSize: 15, ),),
          ],
        ),
      backgroundColor: kWhiteColor,
      elevation: 0,
        actions: [
          IconButton(onPressed: ()=> createDocument(ref, context), icon: Icon(Icons.add, color: kBlackColor, )),
          IconButton(onPressed: ()=> signOut(ref), icon: Icon(Icons.logout, color: kRedColor,)),

        ],
      ),
      body: FutureBuilder<ErrorModel>(future: ref.watch(documentRepositoryProvider).getDocuments(ref.watch(userProvider)!.token),
       builder: (context, snapshot) {
         if(snapshot.connectionState  == ConnectionState.waiting){
            return Loader();
         }

         return Container(
          margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          width: 600,
           child: 
           GridView.builder(
           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
             crossAxisCount: 3, // number of columns
             crossAxisSpacing: 10,
             mainAxisSpacing: 10,
             childAspectRatio: 1, // makes cards square
           ),
           itemCount: snapshot.data!.data.length,
           itemBuilder: (context, index) {
             DocumentModel docc = snapshot.data!.data[index];

               String formattedDate =
        DateFormat('dd MMM yyyy, hh:mm a').format(docc.createdAt);

             return InkWell(
              borderRadius: BorderRadius.circular(15),
               onTap: () => navigateToDocument(context, docc.id),
               child: Card(
                 elevation: 3,
                 color: kWhiteColor,
                 child: Padding(
                   padding: const EdgeInsets.all(10),
                   child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
         
            /// Title (top-left)
            Text(
              docc.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),

              /// Created at line
              Text(
                formattedDate,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            const Spacer(),
         
            /// Buttons (bottom-right)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
         
                IconButton(
                  icon: const Icon(Icons.share, size: 20),
                  onPressed: () {
                    // share logic
                    Clipboard.setData(ClipboardData(text: 'http://localhost:3000/#/document/${docc.id}')).then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("link copied")));
                },);
                  },
                ),
         
                IconButton(
                  icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                  onPressed: () {
                    // delete logic
                  },
                ),
              ],
            ),
          ],
                   ),
                 ),
               ),
             );
           },
         )
           
         
         
         
         
          //  ListView.builder(itemBuilder: (context, index) {
          //    DocumentModel docc = snapshot.data!.data[index];
           
          //    return InkWell(
          //     onTap: () =>navigateToDocument(context, docc.id),
          //      child: SizedBox(
          //       height: 50,
          //        child: Card(
          //         child: Center(child: Text(docc.title, style: TextStyle(fontSize: 17),),),
          //        ),
          //      ),
          //    );
          //  }, itemCount: snapshot.data!.data.length,),
         
         
         
         
         );
       },),
    );
  }
}

