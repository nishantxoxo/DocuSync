// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:docu_sync/constants.dart';
import 'package:docu_sync/models/error_model.dart';
import 'package:docu_sync/models/user_model.dart';
import 'package:docu_sync/tokens.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_riverpod/legacy.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';

final AuthRepositoryProvider = Provider((ref) => AuthRepository(googleSignIn: GoogleSignIn( 
  clientId: kIsWeb ?webtoken:null,
    scopes: ['email', 'profile'],
    
    ), client: Client()));





final userProvider = StateProvider<UserModel?>((ref) => null);


class AuthRepository {
  final GoogleSignIn _googleSignIn;
  final Client _client;
  AuthRepository({
    required  GoogleSignIn googleSignIn,
    required Client client
  }): _googleSignIn = googleSignIn, _client = client;

  

  Future<ErrorModel> signInWithGoogle() async {
    debugPrint('signInWithGoogle() CALLED');
    ErrorModel error = ErrorModel(error: 'some unexpected error occured', data: null);
    try {


      GoogleSignInAccount? user;
      if(kIsWeb){
        _googleSignIn.requestScopes(['https://www.googleapis.com/auth/user.email.read']);
        // user = await  _googleSignIn.signInSilently();
        user = await  _googleSignIn.signIn() ;

      }
      else{

    user = await  _googleSignIn.signIn();
      }
        
  if (user == null) {
  debugPrint('User is null');
  return error;
}
      if(user != null){
        debugPrint(" name - ${user.displayName??"no name"}");
        print("EMAILL - ${user.email??"no email"}");
        print("EMAILL - ${user.photoUrl??"no photo"}");
       

        
          final googleAuth = await user.authentication;
     final String? token = kIsWeb
    ? googleAuth.accessToken  
    : googleAuth.idToken;     
      final useracc = UserModel(name: user.displayName! , email: user.email, profilePic: user.photoUrl??"", uid: '', token: '');


       debugPrint("PRE POST ");
       print("PRE POST ");

        print(useracc.toJson().toString());

      var res = await _client.post(Uri.parse("$host/api/signup"), 
      body: useracc.toJson(),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      }
      );
       debugPrint("  2 POST ");
       print(res.body);

      switch(res.statusCode){
        case 200:
        final newUser = useracc.copyWith(
          uid: jsonDecode(res.body)['user']['_id']
        );
        error = ErrorModel(error: null, data: newUser);
       debugPrint("  3 POST ");
       print("  3 POST ");

        break;
        

        default:
        throw 'some error occured';
      }
    }
    
    
    } catch (e) {
       error = ErrorModel(error: e.toString(), data: null);
    }
    return error;
  }
}
