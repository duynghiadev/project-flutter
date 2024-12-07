import 'package:flutter/material.dart';
import 'package:portfolio/src/presentation/about/about_provider.dart';
import 'package:portfolio/src/presentation/main_provider.dart';
import 'package:portfolio/utils/lib/provider/provider_ext.dart';

import '../../../routes.dart';
import '../../../utils/const.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  late AboutProvider aboutProvider;
  late MainProvider mainProvider;
  late ColorScheme colorScheme;

  @override
  void didChangeDependencies() {
    aboutProvider = context.provider();
    mainProvider = context.provider();
    colorScheme = Theme.of(context).colorScheme;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Material(
      // color: colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            const Text(
              'Hi, my name is',
              style: TextStyle(
                letterSpacing: Const.letterSpacingS,
              ),
            ),
            Text(
              "${aboutProvider.get().fullName}.",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  letterSpacing: Const.letterSpacingL),
            ),
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  colors: [
                    Color(0xffc1488d),
                    Color(0xff964bc6),
                  ],
                ).createShader(bounds);
              },
              child: Text(
                "${aboutProvider.get().shortIntro}.",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white,
                    letterSpacing: Const.letterSpacingM),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              aboutProvider.get().longIntro,
              style: const TextStyle(
                letterSpacing: Const.letterSpacingS,
              ),
            ),
            const SizedBox(height: 100),
            _getInTouchButton(),
            const SizedBox(height: 150)
          ],
        ),
      ),
    );
  }

  Widget _getInTouchButton() {
    return OutlinedButton(
      onPressed: () {
        mainProvider.navigateToRoute(Routes.CONTACT_SCREEN);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: const Text('Get In Touch',
            style: TextStyle(
              fontSize: 15,
              letterSpacing: Const.letterSpacingS,
            )),
      ),
    );
  }
}
