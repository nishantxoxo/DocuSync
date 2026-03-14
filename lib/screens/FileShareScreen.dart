import 'package:docu_sync/colors.dart';
import 'package:docu_sync/repository/socket_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class FileShareScreen extends StatefulWidget {
  final String documentId;

  const FileShareScreen({super.key, required this.documentId});

  @override
  State<FileShareScreen> createState() => _FileShareScreenState();
}

class _FileShareScreenState extends State<FileShareScreen> {
  List files = [];

  SocketRepository socketRepository = SocketRepository();
  @override
  void initState() {
    super.initState();
    socketRepository.joinRoom(widget.documentId);

    socketRepository.fileListener((data) {
      if (!mounted) return;

      setState(() {
        files.add(data);
      });
    });
  }

  Future<void> uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result == null) return;

    final file = result.files.single;

    var request = http.MultipartRequest(
      "POST",
      Uri.parse("http://localhost:3001/files/upload/${widget.documentId}"),
    );

    request.files.add(
      http.MultipartFile.fromBytes("file", file.bytes!, filename: file.name),
    );

    await request.send();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Shared Files"), backgroundColor: kWhiteColor, bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: kGreyColor, width: 0.1),
            ),
          ),
        ),),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.upload),
        onPressed: uploadFile,
      ),

      body:
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 3, // square cards
          ),
          itemCount: files.length,
          itemBuilder: (context, index) {
            final file = files[index];
        
            final url = Uri.parse(
        "http://localhost:3001/uploads/${file["path"]}",
            );
        
            return InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () async {
          if (await canLaunchUrl(url)) {
            await launchUrl(url);
          }
        },
        child: Card(
          color: kWhiteColor,
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getFileIcon(file["name"]),
                    
                const SizedBox(width: 10),
                    
                /// file name
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      file["name"],
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 3,),
                    Text(
                      formatFileSize(file["size"]),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                    
                const Spacer(),
                Center(
                  child: IconButton(
                            icon: const Icon(Icons.download),
                            onPressed: () async {
                              if (await canLaunchUrl(url)) {
                                await launchUrl(
                                  url,
                                  mode: LaunchMode.externalApplication,
                                );
                              }
                            },
                          ),
                ),
              ],
            ),
          ),
        ),
            );
          },
        ),
      )
      
      
      //  ListView.builder(
      //   itemCount: files.length,
      //   itemBuilder: (context, index) {
      //     final file = files[index];

      //     return ListTile(
      //       leading: const Icon(Icons.insert_drive_file),
      //       title: Text(file["name"]),
      //       trailing: IconButton(
      //         icon: const Icon(Icons.download),
      //         onPressed: () async {
      //           final url = Uri.parse(
      //             "http://localhost:3001/uploads/${file["path"]}",
      //           );

      //           if (await canLaunchUrl(url)) {
      //             await launchUrl(url);
      //           }
      //         },
      //       ),
      //     );
      //   },
      // ),




    );
  }
}


String formatFileSize(int bytes) {
  if (bytes >= 1024 * 1024) {
    return "${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB";
  } else if (bytes >= 1024) {
    return "${(bytes / 1024).toStringAsFixed(2)} KB";
  } else {
    return "$bytes B";
  }
}



Icon getFileIcon(String fileName) {
  String ext = fileName.split('.').last.toLowerCase();

  if (["png", "jpg", "jpeg", "gif", "webp"].contains(ext)) {
    return const Icon(Icons.image, size: 45, color: Colors.green);
  }

  if (["pdf"].contains(ext)) {
    return const Icon(Icons.picture_as_pdf, size: 45, color: Colors.red);
  }

  if (["doc", "docx"].contains(ext)) {
    return const Icon(Icons.description, size: 45, color: Colors.blue);
  }

  if (["xls", "xlsx"].contains(ext)) {
    return const Icon(Icons.table_chart, size: 45, color: Colors.green);
  }

  if (["ppt", "pptx"].contains(ext)) {
    return const Icon(Icons.slideshow, size: 45, color: Colors.orange);
  }

  if (["zip", "rar", "7z"].contains(ext)) {
    return const Icon(Icons.archive, size: 45, color: Colors.brown);
  }

  return const Icon(Icons.insert_drive_file, size: 45, color: kBlueColor);
}