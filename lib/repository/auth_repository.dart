// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:docu_sync/constants.dart';
import 'package:docu_sync/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';

final AuthRepositoryProvider = Provider((ref) => AuthRepository(googleSignIn: GoogleSignIn(), client: Client()));




class AuthRepository {
  final GoogleSignIn _googleSignIn;
  final Client _client;
  AuthRepository({
    required  GoogleSignIn googleSignIn,
    required Client client
  }): _googleSignIn = googleSignIn, _client = client;

  

  void signInWithGoogle() async {
    try {
    final user = await  _googleSignIn.signIn();
    if(user != null){
      final useracc = UserModel(name: user.displayName! , email: user.email, profilePic: user.photoUrl!, uid: '', token: '');

      var res = await _client.post(Uri.parse("$host/api/signup"), 
      body: useracc.toJson(),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      }
      );

      switch(res.statusCode){
        case 200:
        final newUser = useracc.copyWith(
          uid: jsonDecode(res.body)['user']['_id']
        );
        break;
        

        default:
        throw 'some error occured';
      }
    }
    
    } catch (e) {
      print(e);
    }
  }
}
