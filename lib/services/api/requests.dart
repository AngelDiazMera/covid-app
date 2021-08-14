import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:covserver/models/user.dart';
import 'package:covserver/services/api/api.dart';
import 'package:covserver/services/firebase/push_notification_service.dart';
import 'package:covserver/services/preferences/preferences.dart';

/// Sign un a new user and sign the user, so Bearer token is saved on
/// the preferences.
Future<bool> signUp(User newUser) async {
  // TODO: Hash the password with Bcrypt (10 salt rounds)
  //  The hash function must be saved on the utils folder
  //  (if not exists, create it ) which is located in the path
  //  ../lib/utils/hashing.dart

  try {
    Map body = newUser.toJson();
    body['mobileToken'] = PushNotificationService.token;
    final http.Response response = await Api.post('/user/signup', body: body);
    // If the user is signed up successfully
    if (response.statusCode == 200) {
      // Save the token
      await Preferences.myPrefs.setToken(json.decode(response.body)['token']);
      return true;
    }
  } catch (error) {
    print(error);
    return false;
  }
  // return User.fromJson(json.decode(response.body));
  return false;
}

/// Sign an user with email and password
/// Once is signed, returns the user
/// Also, when user is signed, the Bearer token is saved on the preferences
/// If something goes wrong, the return will be null and the callback
///  onError will be excecuted
Future<User?> signIn(String email, String password, {Function? onError}) async {
  print('Peticion');
  try {
    print('Haciendo POST');
    http.Response response = await Api.post('/user/signin', body: {
      'email': email,
      'password': password,
      'mobileToken': PushNotificationService.token
    });
    Map? resMap = json.decode(response.body);
    print(resMap);
    // When the user logged successfully
    if (response.statusCode == 200) {
      User newUser = User(
        name: resMap!['user']['name'],
        lastName: resMap['user']['lastName'],
        gender: resMap['user']['gender'],
        email: resMap['user']['email'],
      );
      await Preferences.myPrefs.setToken(resMap['token']);
      return newUser;
    }
    // Otherwise, onError will be called
    if (onError != null) {
      onError(json.decode(response.body)['msg']);
      return null;
    }
  } catch (error) {
    if (onError != null) onError('Ocurrió un problema con el servidor');
    return null;
  }
  return null;
}

/// Gets the current user data from api
Future<User?> getMyData({Function? onError}) async {
  try {
    http.Response response = await Api.get('/user/mine');
    Map? resMap = json.decode(response.body);
    // When the user logged successfully
    if (response.statusCode == 200) {
      User newUser = new User(
          name: resMap!['name'],
          lastName: resMap['lastName'],
          gender: resMap['gender'],
          email: resMap['email'],
          healthCondition: resMap['healthCondition']);
      await Preferences.myPrefs.setHealthCondition(resMap['healthCondition']);
      return newUser;
    }
    // Otherwise, onError will be called
    if (onError != null) {
      onError(json.decode(response.body)['msg']);
      return null;
    }
  } catch (error) {
    if (onError != null) onError('Ocurrió un problema con el servidor');
    return null;
  }
  return null;
}

/// Gets the alerts data from the API
Future<Map?> getAlertData(String? userRef, String? groupRef, String anonym,
    {Function? onError}) async {
  try {
    http.Response response = await Api.post('/groups/getAlertData', body: {
      'userRef': userRef,
      'groupRef': groupRef,
      'anonym': anonym.toLowerCase() == 'true',
      'mobileToken': PushNotificationService.token
    });
    print('Petición a serivdor');
    Map resMap = json.decode(response.body);
    print(resMap);
    // When the user logged successfully
    if (response.statusCode == 200) {
      return resMap;
    }
    // Otherwise, onError will be called
    if (onError != null) {
      onError(json.decode(response.body)['msg']);
    }
  } catch (error) {
    if (onError != null) onError('Ocurrió un problema con el servidor: $error');
  }
  return null;
}

Future<User?> updateUser(
    String name, String lastName, String email, String password,
    {Function? onError}) async {
  try {
    http.Response response = await Api.update('/user/update', body: {
      'name': name,
      'lastName': lastName,
      'email': email,
      'password': password,
    });
    Map resMap = json.decode(response.body);
    print(resMap);
    // When the user logged successfully
    if (response.statusCode == 200) {
      User newUser = User(
        name: resMap['user']['name'],
        lastName: resMap['user']['lastName'],
        email: resMap['user']['email'],
        password: resMap['user']['password'],
      );
      await Preferences.myPrefs.setToken(resMap['token']);
      return newUser;
    }
    // Otherwise, onError will be called
    if (onError != null) {
      onError(json.decode(response.body)['msg']);
      return null;
    }
  } catch (error) {
    if (onError != null) onError('Ocurrió un problema con el servidor: $error');
    return null;
  }
  return null;
}

/// API request: Updates the health condition
Future<Map?> setHealthState(String? healthCondition,
    {Function? onError}) async {
  try {
    http.Response response = await Api.put('/user/healthCondition',
        body: {'healthCondition': healthCondition});
    Map resMap = json.decode(response.body);
    print(resMap);
    // The healthCondition is updated successfully
    if (response.statusCode == 200) return resMap;

    // Otherwise, onError will be called
    if (onError != null) {
      onError(json.decode(response.body)['msg']);
      return null;
    }
  } catch (error) {
    if (onError != null) onError('Ocurrió un problema con el servidor');
    return null;
  }
}

/// Assign a user to a group as a member or a visitor
Future<Map?> assignToGroup(String code, {Function? onError}) async {
  try {
    http.Response response = await Api.post('/groups/assign', body: {
      'code': code.toUpperCase(),
      'mobileToken': PushNotificationService.token,
    });
    Map resMap = json.decode(response.body);
    // When the user logged successfully
    if (response.statusCode == 200 || response.statusCode == 400) return resMap;
  } catch (error) {
    if (onError != null) onError('Ocurrió un problema con el servidor');
    print('HUBO UN PROBLEMA CON EL SERVIDOR');
    return null;
  }
  return null;
}

/// Gets the scanned group by their code
Future<Map?> getGroup(String code, {Function? onError}) async {
  try {
    http.Response response = await Api.get('/groups/$code');
    Map? resMap = json.decode(response.body);
    // When the user logged successfully
    if (response.statusCode == 200 || response.statusCode == 400)
      return resMap!;

    // Otherwise, onError will be called
    if (onError != null) {
      onError(json.decode(response.body)['msg']);
      return null;
    }
  } catch (error) {
    if (onError != null) onError('Ocurrió un problema con el servidor');
    return null;
  }
  return null;
}

/// Notyfy by FCM to visitors and members who may have had been with the
/// infected user
Future<bool> notifyInfected({
  required bool anonym,
  required DateTime symptomsDate,
  Function? onError,
}) async {
  try {
    http.Response response = await Api.post('/groups/notifyInfected', body: {
      'anonym': anonym,
      'symptomsDate': symptomsDate.toUtc().toString(),
      'mobileToken': PushNotificationService.token
    });

    Map resMap = json.decode(response.body);
    print(resMap);
    // When the user logged successfully
    if (response.statusCode == 200) return true;

    // Otherwise, onError will be called
    if (onError != null) onError(json.decode(response.body)['msg']);
  } catch (error) {
    if (onError != null) onError('Ocurrió un problema con el servidor: $error');
  }
  return false;
}

/// Save symtoms on server's database
Future<bool> saveSymptoms({
  /* AQUÍ PONES LOS ARGUMENTOS QUE NECESITES (PASA EL OBJETO O CADA VARIABLE INDIVIDUALMENTE) */
  Function? onError,
}) async {
  try {
    http.Response response = await Api.post('/symptoms/mine', body: {
      'symptoms': '',
      'symptomsDate': '',
      'remarks': '',
      'isCovid': '',
      'covidDate': ''
    }); // NOTA: AQUÍ PUEDES UTILIZAR TU MÉTODO TOJSON DEL OBJETO SYMPTOMS

    Map resMap = json.decode(response.body);
    print(resMap);
    // When the user logged successfully
    if (response.statusCode == 200) return true;

    // Otherwise, onError will be called
    if (onError != null) onError(json.decode(response.body)['msg']);
  } catch (error) {
    if (onError != null) onError('Ocurrió un problema con el servidor: $error');
  }
  return false;
}
