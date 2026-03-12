import 'package:docu_sync/colors.dart';
import 'package:docu_sync/models/document.dart';
import 'package:docu_sync/models/error_model.dart';
import 'package:docu_sync/repository/auth_repository.dart';
import 'package:docu_sync/repository/document_repository.dart';
import 'package:docu_sync/repository/socket_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DocumentScreen extends ConsumerStatefulWidget {
  final String id;

  const DocumentScreen({super.key, required this.id});

  @override
  ConsumerState<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends ConsumerState<DocumentScreen> {
  quill.QuillController _controller = quill.QuillController.basic();
  TextEditingController titleController = TextEditingController(
    text: "Untitled Document",
  );
  ErrorModel? err;

  SocketRepository socketRepository = SocketRepository();





  @override
  void initState() {
  
    super.initState();
    socketRepository.joinRoom(widget.id);
    fetchDocData();
  }

void fetchDocData() async {
   err = await ref.read(documentRepositoryProvider).getDocumentbyId(ref.read(userProvider)!.token, widget.id);


   if (err!.data!=null){
    titleController.text = (err!.data as DocumentModel).title;
    setState(() {
      
    });
   }
}

  void updateTitle(WidgetRef ref,  String title){
      ref.read(documentRepositoryProvider).updateDocumentTitle(token: ref.read(userProvider)!.token, id: widget.id, title: title);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.all(10),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: kBlueColor),
              onPressed: () {},
              label: Text("Share"),
              icon: Icon(Icons.lock, size: 16),
            ),
          ),
        ],
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 9),
          child: Row(
            children: [
              Image.asset('assets/images/docs-logo.png', height: 40),
              SizedBox(width: 10),
              SizedBox(
                width: 200,
                child: TextField(
                  onSubmitted: (value) => updateTitle(ref, value),
                  controller: titleController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kBlueColor),
                    ),
                    contentPadding: EdgeInsets.only(left: 10),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: kGreyColor, width: 0.1),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 10,),
            quill.QuillSimpleToolbar(
              controller: _controller,
              config: const quill.QuillSimpleToolbarConfig(),
            ),
            const SizedBox(height: 10,),

            Expanded(
              child: SizedBox(
                width: 750,
                child: Card(
                  color: kWhiteColor,
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: quill.QuillEditor.basic(
                      controller: _controller,
                      config: const quill.QuillEditorConfig(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
