import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:googleapis/servicecontrol/v1.dart' as servicecontrol;

class NotificationScreen {
  static Future<String> getAccessToken() async {
    final Map<String, String> servicecontrol = <String, String>{
      "type": "service_account",
      "project_id": "walletmyproject",
      "private_key_id": "fb8fbe6e34bbbbdd92bcf448f70cc9f9097934bb",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQClU1200Yj4QW0a\nR5SXe+PZ+xiM7wR9EblsmtTzPA8fru18+EVX5d5/gGvLjTbbfO+/eO0uuTPhIUUs\nlatoI1U2v30owT+cVRrnip0ESVOBesvTh2DSUWjbXoHhPTNu/rYnTuAKR85luJbU\nz1rRM2uiMTtRjHa2x8pF91lyF9b7TnCQxT2oOF5Kx+RfOQmQB2w8oGBsj3r2lbUW\nOqs+nNH7ECIZHHbsO+gGvx5AS+44r2imi44ENmi4UhR25erqgSBDIxy+/2eVWKze\nbnrOKSdvwY8VvsnxACu5liYflESO+IFhDjO96xvxedaZTKllVxyx1koMb51NLDpx\nW+iSbCS9AgMBAAECggEAJ2ed4523tFg/zW43O/3y+n8vRFQp8Td6xyiGTi1H+4jB\noTI5sPAgnqo4xyzy4NDAAhasDaFl/Khl6PEJiEo3otN0XPTmmPft8DcpIp7pkOh4\nUYQobyipQfQeJ9Xi/vcl6muR2dFwn+0lwjZkEo3bfy6V0WOV3g3zp8aDYr7M5lvT\nNDLOXuEaaj426CxKvJZk4XpiF88TBquGWbcmbv7mHdKutFBzcxa/0yG8OyS/B0mm\nfZaKj7CEfmBgQxe9cmctC6BtB7pPj95vREHCsvvzmVLAi7eVGMQwPezBUiYq8y0r\nJDHEPekzZNlKq6DGl07w/UxmWg/bZtAZyLnIMvS7UQKBgQDVkuWUIL59OYUyqGWG\n5qgGI+N4K5rhzUThna+NHWeR3UcExmC1p1cH+wh4ywFtL01QKiU/vTri6ToMM2W8\nB1tSawa41JA69tHXxiips7xsPZMHf/fxbmBjJT8dLB0Re69NrjivdT3wU3OoXrAj\no5xjMMk1TmfSex8m93J6Y5FyyQKBgQDGKto0Ij5PPjy8BC1+gDfrPZ3M34vebrib\nd3hPJ3ijl51MgaCPzqu2dhmQDFzU/tm6jusZ4w8nQ6DE8Hecd9cr/g84Kd6SZgCG\nTYs3Lz5/TqB3Vg4n9xow04S/TTwqbLWEmo5AXbqL+VSy2QirBfizrqNc9bdEUt3L\nBC6wu9TIVQKBgFi35NZbo8WxFzur6EDZoAKs9dj9hCE4e9yc/EfKZzOYj9/T6GiN\nUwHlrec/rSAF/j/GwiJwIP4RlCNtVl19UNozy18MLb3QuerATjPwjd0I1wLOjdik\n2TVWS5l6sbiJgJDsRm/cbBZhFDJk4xZq6JPruCmEoGw26QHu2IcuxUTBAoGAeDln\nSFm+E7Veg3LFZwnC4yTup2y4HqpttWQ1yU/ZEObat5+tGZH4+ymLOKlHaLF0xooO\neBYZC2ksEE8TQgoysK3h7eD49ziK+O/ylfhDoljBYaUD0ZtIeHbbAnSJG/P37AsY\nYlR66JDLofWqHJfy2pAI7Ezmcr0TcieHbBGIdkECgYA/I2PX7rE+CPlcFpEYKl7N\nZi9kmW2OpNUrNWbc2rJ62LEh5jFmF5WHu0+s3aiRms5uu8MNuXJKd9C8rDOHt+5D\nlwiPlWve/8DJLam4KB0qBm4g7PW8RZXytfuJEy7tPxZJEr02KEMve+koNiprufLW\n235OOWRwVlsR19DKbNmzfQ==\n-----END PRIVATE KEY-----\n",
      "client_email": "testing@walletmyproject.iam.gserviceaccount.com",
      "client_id": "114291914418479513193",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/testing%40walletmyproject.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };

    List<String> scopes = <String>[
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];
    http.Client client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(servicecontrol),
      scopes,
    );
    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
            auth.ServiceAccountCredentials.fromJson(servicecontrol),
            scopes,
            client);
    client.close();
    return credentials.accessToken.data;
  }

  static Future<void> sendNotification(
      String deviceToken, String title, String body) async {
    final String accessToken = await getAccessToken();
    String endpointFCM =
        'https://fcm.googleapis.com/v1/projects/walletmyproject/messages:send';
    final Map<String, dynamic> message = {
      "message": {
        "token": deviceToken,
        "notification": {"title": title, "body": body},
        "data": {
          "route": "serviceScreen",
        }
      }
    };
    final http.Response response = await http.post(
      Uri.parse(endpointFCM),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(message),
    );

    print('Sending notification to: $deviceToken');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Failed to send notification: ${response.body}');
    }
  }
}
