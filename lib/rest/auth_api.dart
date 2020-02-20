import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:monsieur_people/models/user_model.dart';

class UserAPI {
  static final String userUrl = 'http://3.92.227.229/login';
  static Future<User> getRandomCat() async {
    var response = await http.post((userUrl));

    if (response.statusCode != 200) {
      print(response);
      return null;
    }
    return User.fromJSON(jsonDecode(response.body));
  }
}
