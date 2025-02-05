import 'package:flutter/cupertino.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class SendEmail {
  static const String _senderEmail = 'task.listener@gmail.com';
  static const String _smtpPassword = 'jetwukprtgqegikq';
  static TextEditingController clientNameController = TextEditingController();
  static TextEditingController clientEmailController = TextEditingController();
  static TextEditingController subjectController = TextEditingController();
  static TextEditingController bodyController = TextEditingController();

  static void sendGmail({
    required String clientEmail,
    required String clientName,
    String receiverEmail = 'tridonguyen392@gmail.com',
    required String subject,
    required String body,
  }) async {
    // Create an SMTP server object
    final smtpServer = gmail(
      _senderEmail,
      _smtpPassword,
    );

    // Create a message object
    final message = Message()
      ..from = Address(clientEmail, clientName)
      ..recipients.add(receiverEmail)
      ..subject = subject
      ..text = body;

    // Send the message
    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: $sendReport');
    } catch (e) {
      print('Error sending message: $e');
    }
  }
}
