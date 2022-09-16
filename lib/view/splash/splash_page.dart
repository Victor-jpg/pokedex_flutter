import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      Get.toNamed("/home");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).splashColor,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Image.asset("assets/imagens/pokemon-logo.png"),
        ),
      ),
    );
  }
}
