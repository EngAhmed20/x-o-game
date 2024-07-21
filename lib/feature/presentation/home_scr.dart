import 'package:flutter/material.dart';

import 'widgets/home_content.dart';

class HomeScr extends StatelessWidget {
  const HomeScr({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeContent(),
    );
  }
}
