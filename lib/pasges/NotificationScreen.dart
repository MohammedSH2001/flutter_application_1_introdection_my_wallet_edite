import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:googleapis/servicecontrol/v1.dart' as servicecontrol;

class NotificationScreen {
  static Future<String> getAccessToken() async {
    final Map<String, String> servicecontrol = <String, String>{
      "type": "service_account",
      "project_id": "walletmyproject",
      "private_key_id": "b71af4e249b44f592391cb47d0b6c17331f78c9c",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC+aDcoEajwKg7F\nQ6eDS7O3cGdjfRLs12Nk1h659CHH8sKlPejvSw/oYY4NfVxukkSQ2DYTt3yHcQXc\nAbvSmRUkxeqcNM4D7SkxwROYiiWte6Ja3NIfGAY7GcotCw2ReBUJ/CbGLPb6lC3E\n74xniwu6796ULVGlUtbRrFcttJTdRrTlocr9/WHNsifkUMTiPCVMyHXjAwKrmt6J\nlAUMbUcfZPn6GEYKzt3gvtS8zrZJg6EmgLNeDKHnimyaJjyRCsCCI82EykWA4Qdh\nkW6tEDkytkJSq1qoiSp2FTrDa5e/Fk636BtLXqsbVf4ddQaYWX5ZZ4bSsIL334TT\nqc5nCUm1AgMBAAECggEAE/Ud9OX2+GdcIXqQJA+rAGr4d0HcmjUQTrkvwstvQAM2\nujW1ROGwAuo4xrqxVcighbMX5fSpSZQD6nXHD1Gq2O4iw2k4f8pbs0Ka0HYIcXjg\nQVhccNRmkMrI+XQrYag9wkxq7wI3B/hAnOAD7jVxjxBF2u+uG19Fs3f2Mkz3foLU\ng0Q4vG4KTUHbuRcs6CpZhizGlTPL6TaQ1yhFUX7chJg1KtIeimafLed6ZDYaqViQ\nmApbqDXjrOz/ciS9NzWucraSTjy9skRJUFC35HaHTTfo8STf/KuWKF8fb3DSvRB/\n49SR9UWKZEEWTWvNLUuC8/7wHW5HS5J0Tmcj/oAIcQKBgQDzGXcLuegfA6aTZtgH\n9k4EXqms15+rO/2LwVolhTux/yRjPC8d0bdhei3DeZ5bE2dsapLakAsvtQ9+kVQK\nQ4hOvVJEuB6ZpPFPYQMIou3CF8lGJgx6lwLgILQk6tQeV5ZDy8nM8fj60qfyZC5v\ns+Pen6ar/t1cyXTOqzx/1lKXsQKBgQDIgusQ7p5I9Ir61oa0PoPJuSSBb4yOIpL4\nZmnM1BkM+H+BW8izx6Swi9jTCYlDQm/yyQfJfDYEJMvqvYZChBw92+xzPO/yqspd\nR6b1n+gOopS6xIxsRsu3hQZPDwVGvkcu9QIX1SwMXGnv8MNiqu4U/NRjXwqo980h\nXQEO0F2XRQKBgQDMk/GK/LhK4VedVD8Y9D5TjxZbTlogUCvfIKgsSyMheAW3PT6p\naYNZlOhOSFrrajjvFADhzbacP1L6wHJo8MwU9130Vr3prtUkaA+VhQdw/3NyhTKb\nN9pDo0H2j2hS4IKkKyt4PWm6Ku0LHyO0/T4Wa2Rn+eNv4llaUuBm9IYtAQKBgQCe\n/zFnO9BICaIrRfGK/AeE7ksEWHAcRU5FqvA6e/VhU6vH6AA+jxEI7dwBfI5bx1L+\nMmr6WoR6xLLucVsFY70BUGMu/iNHSict0KOUIjjhYgqOD01Kjtj7rYBTMJX+guPv\nWFlQjLlhE+btXP2SP/iKq/G+2p6ZXeZLjnRISvHsAQKBgEiWQ+EuoYBedaP30TR2\n3MCSmg2Qq2iyzWIAMeg3tNVlrqis1W7chlwQOAp32QxgoC4kB15Ema8z0okTj0yc\n/B8qG/9GdRyD65yCxJM4E+ePqCqkNWTWXDm9fR9XzV2Z2QAKwn55MV7lX/RtHxfJ\nzGyLT1F00iRBHZdLUlpAMOn5\n-----END PRIVATE KEY-----\n",
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


