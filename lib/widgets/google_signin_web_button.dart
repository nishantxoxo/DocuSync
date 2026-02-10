// import 'dart:ui' as ui;
// import 'dart:html' as html;
// import 'package:flutter/foundation.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:google_sign_in_web/google_sign_in_web.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:google_sign_in_web/google_sign_in_web.dart';

// class GoogleSignInWebButton extends StatefulWidget {
//   const GoogleSignInWebButton({super.key});

//   @override
//   State<GoogleSignInWebButton> createState() => _GoogleSignInWebButtonState();
// }

// class _GoogleSignInWebButtonState extends State<GoogleSignInWebButton> {
//   final String _buttonId = 'google-sign-in-button';

//   @override
//   void initState() {
//     super.initState();

//     if (kIsWeb) {
//       GoogleSignInPlatform.instance.renderButton(
//         _buttonId,
//          GSIButtonConfiguration(
//           type: GSIButtonType.standard,
//           size: GSIButtonSize.large,
//           theme: GSIButtonTheme.outline,
//           text: GSIButtonText.signin,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (!kIsWeb) {
//       return const SizedBox.shrink();
//     }

//     // Register HTML view
//     // ignore: undefined_prefixed_name
//     ui.platformViewRegistry.registerViewFactory(
//       _buttonId,
//       (int viewId) => html.DivElement()..id = _buttonId,
//     );

//     return const SizedBox(
//       height: 50,
//       width: 250,
//       child: HtmlElementView(viewType: 'google-sign-in-button'),
//     );
//   }
// }
