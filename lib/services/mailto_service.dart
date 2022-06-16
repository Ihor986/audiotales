import 'package:url_launcher/url_launcher.dart';

class MailToService {
  const MailToService._();

  static const instance = MailToService._();

  forwardToEMail() async {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'support@audiotale.com',
      query: encodeQueryParameters(<String, String>{'subject': 'Need Support'}),
    );
    if (!await launchUrl(emailLaunchUri)) {
      throw 'Could not launch $emailLaunchUri';
    }

    launchUrl(emailLaunchUri);
  }
}
