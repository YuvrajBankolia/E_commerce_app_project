import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class SmtpConfig {
  static final SmtpServer smtpServer = SmtpServer(
    'smtp.gmail.com',
    port: 465,
    username: 'yuvrajbankolia@gmail.com',
    password: 'pxes txpw iqrn mvld',
    ssl: true,
  );
}

class SendOtp {
  Future<void> sendOtp(String recipientMail, String otp) async {
    print('hello');
    final message = Message()
      ..from = Address('yuvrajbankolia@gmail.com', 'ecommerce_app')
      ..recipients.add(recipientMail)
      ..subject = 'Your OTP Code'
      ..text = 'Your OTP is: $otp';

    try {
      print('hello22222222');

      final sendReport = await send(message, SmtpConfig.smtpServer);
      print('hello3333333');
      print('OTP sent successfully! Message ID: ${sendReport.toString()}');
    } catch (e) {
      print('Error sending OTP: $e');
    }
  }
}
