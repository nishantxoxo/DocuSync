import 'package:docu_sync/screens/document_screen.dart';
import 'package:docu_sync/screens/home_screen.dart';
import 'package:docu_sync/screens/login_screen.dart';
import 'package:routemaster/routemaster.dart';
import 'package:flutter/material.dart';
final loggedOutRoute = RouteMap(routes: {
    '/': (route) => const MaterialPage(child: LoginScreen())
});


final loggedInRoute = RouteMap(routes: {
    '/': (route) => const MaterialPage(child: HomeScreen()),
    '/document/:id' :  (route)=>  MaterialPage(child: DocumentScreen(id: route.pathParameters['id'] ?? ''))
});