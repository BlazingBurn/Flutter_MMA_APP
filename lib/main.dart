import 'package:flutter/material.dart';
import 'package:flutter_mma_app/events.dart';
import 'package:flutter_mma_app/fighters.dart';
import 'package:flutter_mma_app/home.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

final _router = GoRouter(routes: [
  GoRoute(path: "/", builder: (context, state) => Home()),
  GoRoute(path: "/fighters", builder: (context, state) => Fighters()),
  GoRoute(path: "/events", builder: (context, state) => Events()),
]);


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}
