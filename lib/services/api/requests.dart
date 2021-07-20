import 'package:http/http.dart' as http;
import 'package:persistencia_datos/models/user.dart';
import 'package:persistencia_datos/services/api/api.dart';

Future<bool> signUp(User newUser) async {
  try {
    final http.Response response =
        await Api.post('/user/signup', body: newUser.toJson());
    if (response.statusCode == 200) return true;
  } catch (error) {
    print(error);
    return false;
  }
  // return User.fromJson(json.decode(response.body));
  return false;
}
