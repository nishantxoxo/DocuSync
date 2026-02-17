import 'dart:convert';

import 'package:docu_sync/constants.dart';
import 'package:docu_sync/models/document.dart';
import 'package:docu_sync/models/error_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';


final documentRepositoryProvider = Provider((ref)=> DocumentRepository(client: Client()));


class DocumentRepository {
  final Client _client;

  DocumentRepository({required Client client}): _client = client ;

  Future<ErrorModel> createDocument(String token) async {
     debugPrint('createDocument()  CALLED');
    ErrorModel error = ErrorModel(error: 'some unexpected error occured', data: null);
    try {
    
          var res = await _client.post(Uri.parse("$host/doc/create"), 
       
         headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token,
          },
          body: jsonEncode( {
            'createdAt': DateTime.now().millisecondsSinceEpoch
          })
      );

switch(res.statusCode){
        case 200:

        error = ErrorModel(error: null, data: DocumentModel.fromJson(res.body));
      
        break;
        
        default:
        error = ErrorModel(error: res.body, data: null);
      }

    }
  
    catch (e) {
       error = ErrorModel(error: e.toString(), data: null);
    }
    return error;
  }

}