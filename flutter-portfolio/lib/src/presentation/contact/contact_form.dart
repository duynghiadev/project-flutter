import 'package:flutter/material.dart';
import 'package:portfolio/src/service/send_email.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({Key? key}) : super(key: key);

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  late ColorScheme colorScheme;

  @override
  void didChangeDependencies() {
    colorScheme = Theme.of(context).colorScheme;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: colorScheme.surfaceContainerHighest,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 30,
          right: 30,
          top: 25,
          bottom: 20,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: _oneLineTextField(
                    hintText: 'Your Name',
                    isRequired: true,
                    controller: SendEmail.clientNameController,
                    errorText: () {
                      if (_validated == null) {
                        return null;
                      }
                      if (SendEmail.clientNameController.text.isEmpty) {
                        return 'required';
                      }
                      return null;
                    }(),
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                    flex: 1,
                    child: _oneLineTextField(
                      hintText: 'Email',
                      isRequired: true,
                      controller: SendEmail.clientEmailController,
                      errorText: () {
                        if (_validated == null) {
                          return null;
                        }
                        if (SendEmail.clientEmailController.text.isEmpty) {
                          return 'required';
                        }
                        return null;
                      }(),
                    ))
              ],
            ),
            const SizedBox(height: 10),
            _oneLineTextField(
                hintText: 'Subject',
                isRequired: true,
                controller: SendEmail.subjectController,
                errorText: () {
                  if (_validated == null) {
                    return null;
                  }
                  if (SendEmail.subjectController.text.isEmpty) {
                    return 'required';
                  }
                  return null;
                }()),
            const SizedBox(height: 20),
            _multipleLineTextField(
              hintText: "Message",
              controller: SendEmail.bodyController,
            ),
            const SizedBox(height: 30),
            _submitButton('Send', onPressed: () {
              if (SendEmail.clientNameController.text.isEmpty ||
                  SendEmail.clientEmailController.text.isEmpty ||
                  SendEmail.subjectController.text.isEmpty) {
                setState(() {
                  _validated = false;
                });
              } else {
                SendEmail.sendGmail(
                  clientEmail: SendEmail.clientEmailController.text,
                  clientName: SendEmail.clientNameController.text,
                  subject: SendEmail.subjectController.text,
                  body: SendEmail.bodyController.text,
                );
                setState(() {
                  _validated = true;
                });
              }
            }),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  final textFieldBackgroundOpacity = 0.7;

  bool? _validated;

  Widget _oneLineTextField({
    required TextEditingController controller,
    String hintText = "",
    bool isRequired = false,
    String? errorText,
  }) {
    return TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: () {
            var rs = hintText;
            if (isRequired) {
              rs += " (*)";
            }
            return rs;
          }(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: colorScheme.primary),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          filled: true,
          fillColor:
              colorScheme.surface.withOpacity(textFieldBackgroundOpacity),
          errorText: errorText,
        ));
  }

  Widget _multipleLineTextField({
    TextEditingController? controller,
    String hintText = "",
    bool isRequired = false,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: () {
          var rs = hintText;
          if (isRequired) {
            rs += " (*)";
          }
          return rs;
        }(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.primary),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        filled: true,
        fillColor: colorScheme.surface.withOpacity(textFieldBackgroundOpacity),
        alignLabelWithHint: true,
      ),
      keyboardType: TextInputType.multiline,
      maxLines: 7,
      minLines: 7,
    );
  }

  double _elevation = 2;

  Widget _submitButton(String text, {Function()? onPressed}) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          _elevation = 10;
        });
      },
      onExit: (e) {
        setState(() {
          _elevation = 2;
        });
      },
      child: SizedBox(
        width: 150,
        child: FloatingActionButton(
          backgroundColor: colorScheme.primaryContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          elevation: _elevation,
          onPressed: onPressed,
          child: const Text('Submit'),
        ),
      ),
    );
  }
}
