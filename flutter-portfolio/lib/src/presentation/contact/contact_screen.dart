import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:portfolio/src/presentation/contact/contact_form.dart';
import 'package:portfolio/src/provider/social_info_list_provider.dart';
import 'package:portfolio/utils/lib/provider/provider_ext.dart';
import 'package:portfolio/utils/open_link.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  late ColorScheme colorScheme;
  late SocialInfoListProvider socialInfoListProvider;

  @override
  void didChangeDependencies() {
    colorScheme = Theme.of(context).colorScheme;
    socialInfoListProvider = context.provider();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  colors: [
                    Color(0xffc1488d),
                    Color(0xff964bc6),
                  ],
                ).createShader(bounds);
              },
              child: const Text(
                "Let's create Awesome stuffs Together",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _socialButtons(),
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 15),
              child: ContactForm(),
            ),
            const SizedBox(height: 200)
          ],
        ),
      ),
    );
  }

  Widget _socialButtons() {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: socialInfoListProvider.get().map((e) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: _socialButton(
              uri: e.logoUri,
              url: e.url,
              semanticsLabel: e.name,
              onPressed: () {
                OpenLink.openInNewTab(e.url);
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _socialButton({
    required String uri,
    required String url,
    double size = 50,
    Function()? onPressed,
    semanticsLabel = '',
  }) {
    return Tooltip(
      message: url,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: colorScheme.primaryContainer),
          child: SvgPicture.asset(
            uri,
            semanticsLabel: semanticsLabel,
          ),
        ),
      ),
    );
  }
}
