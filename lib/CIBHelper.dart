import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasksflutter_app/model/ToDoList.dart';

import 'method.dart';

class CIBHelper {
  static SharedPreferences prefs;
  static const String _IS_LOGGED_IN = "is_logged_in";
  static const String _USER_DATA = "user_data";
  static const String _EMAIL_DATA = "email_data";
  static const String EMAIL = "username";
  static const String PASSWORD = "password";
  static const String _ACCESS_TOKEN = "access_token";
  static const String _FOLDERS = "folders_data";

  static bool isMocking = false;

  _CIBHelper() {}

  static CIBHelper _cibHelper = null;

  static CIBHelper getInstance() {
    if (_cibHelper == null) {
      _cibHelper = CIBHelper();
      return _cibHelper;
    }
    return _cibHelper;
  }

  static int requestCount = 0;
  int nMaxRetries = 2;
  int interval = 2;





  Future<Map> getFolder(String email,String userId) async {
    if (email.isEmpty) {
      return {'status': 500, 'msg': 'Email required'};
    }
    var response = null;

    try {

    String apiPathGmailLoginUrl = 'emails/allfolders';
    var body = {'name': email,"userId":2};

    response = await cibpost(apiPathGmailLoginUrl, body);
    print('Response for getfolder $response');

    if (response['status'] >= 200) {

      prefs.setString(_FOLDERS, json.encode(response['body']));
      return {"status": 200, "msg": response['body']};

    }else if (response['body']['created'] == false) {

      return {"status": 500, "msg": response["body"]["error"]};
    }}catch (e) {
      // response['body']['success']=false;
      return {"status": 500, "msg": "failed to create user"};
    }
    return {"status": 500, "msg": response['body']};
  }

  Future<Map> createFolder(String code,String lable) async {
    String pathForSendAuthCode = "emails/folder";
    var payload = {"name": '$code',"lable":'$lable',"userId":2};

    var mockedresponse = {
      "body": {
        "created": false,
        "error": "Successfully created new user.",
        "user": {
          "id": 47,
          "email": "cibdevtest2@gmail.com",
          "password": "",
          "phone": 1234567890,
          "updatedAt": "2021-01-09T23:50:59.113Z",
          "createdAt": "2021-01-09T23:50:59.113Z"
        },
        "token": "Bearer eg",
        "success": false
      },
      "status": 200
    };

    var mockedResponseError = {
      "body": {
        "success": false,
        "error": {
          "created": false,
          "userid": 1,
          "error":
          "Email or phone number exists: Validation error - cibdevtest1@gmail.com"
        }
      },
      "status": 200
    };

    var response = null;
    try {
      response =  await cibpost(pathForSendAuthCode, payload);

      if (response['status'] >= 500) {
        return {"status": 500, "msg": "Failed to create a subuser mail"};
      } else if (response['status'] >= 200) {
        response['body']['success']=true;
          return response;
      }
      return {"status": 500, "msg": "Failed to create a folder"};


    } catch (e) {
      return {"status": 500, "msg": "failed to create user"};
    }

    return {"status": 500, "msg": response['body']};
  }

  Future<Map> moveFolder(String lable) async {
    String pathForSendAuthCode = "api/v1/users/149/tasks";
    // var payload = {"name": '$code',"lable":'$lable',"userId":2};
    var payload = {
      "task": {
        "description": "$lable",
        "title": "testing"

      }
    };

    // var payload = {"name": '$code',"lable":'$lable',"userId":2};


    var mockedresponse = {
      "body": {
        "created": false,
        "error": "Successfully created new user.",
        "user": {
          "id": 47,
          "email": "cibdevtest2@gmail.com",
          "password": "",
          "phone": 1234567890,
          "updatedAt": "2021-01-09T23:50:59.113Z",
          "createdAt": "2021-01-09T23:50:59.113Z"
        },
        "token": "Bearer eg",
        "success": false
      },
      "status": 200
    };

    var mockedResponseError = {
      "body": {
        "success": false,
        "error": {
          "created": false,
          "userid": 1,
          "error":
          "Email or phone number exists: Validation error - cibdevtest1@gmail.com"
        }
      },
      "status": 200
    };

    var response = null;
    try {
      response =  await cibpost(pathForSendAuthCode, payload);

      if (response['status'] >= 500) {
        return {"status": 500, "msg": "Failed to create a subuser mail"};
      } else if (response['status'] >= 200) {
        response['body']['success']=true;
        return response;
      }
      return {"status": 500, "msg": "Failed to create a folder"};


    } catch (e) {
      return {"status": 500, "msg": "failed to create user"};
    }

    return {"status": 500, "msg": response['body']};
  }

  Future<Map> edit(String lable,String id) async {
    String pathForSendAuthCode = "api/v1/users/149/tasks/$id";
    // var payload = {"name": '$code',"lable":'$lable',"userId":2};
    var payload = {
      "task": {
        "description": "$lable"

      }
    };



    var response = null;
    try {
      response =  await cibput(pathForSendAuthCode, payload);

      if (response['status'] >= 500) {
        return {"status": 500, "msg": "Failed to create a subuser mail"};
      } else if (response['status'] >= 200) {
        response['body']['success']=true;
        return response;
      }
      return {"status": 500, "msg": "Failed to create a folder"};


    } catch (e) {
      return {"status": 500, "msg": "failed to create user"};
    }

    return {"status": 500, "msg": response['body']};
  }
  Future<Map> completed(String id) async {
    String pathForSendAuthCode = "api/v1/users/149/tasks/$id/completed";
    // var payload = {"name": '$code',"lable":'$lable',"userId":2};
    var payload = {

    };



    var response = null;
    try {
      response =  await cibput(pathForSendAuthCode, payload);

      if (response['status'] >= 500) {
        return {"status": 500, "msg": "Failed to create a subuser mail"};
      } else if (response['status'] >= 200) {
        response['body']['success']=true;
        return response;
      }
      return {"status": 500, "msg": "Failed to create a folder"};


    } catch (e) {
      return {"status": 500, "msg": "failed to create user"};
    }

    return {"status": 500, "msg": response['body']};
  }
  Future<Map> uncompleted(String id) async {
    String pathForSendAuthCode = "api/v1/users/149/tasks/$id/uncompleted";
    // var payload = {"name": '$code',"lable":'$lable',"userId":2};
    var payload = {

    };



    var response = null;
    try {
      response =  await cibput(pathForSendAuthCode, payload);

      if (response['status'] >= 500) {
        return {"status": 500, "msg": "Failed to create a subuser mail"};
      } else if (response['status'] >= 200) {
        response['body']['success']=true;
        return response;
      }
      return {"status": 500, "msg": "Failed to create a folder"};


    } catch (e) {
      return {"status": 500, "msg": "failed to create user"};
    }

    return {"status": 500, "msg": response['body']};
  }



  Future<List<Todolist>> getAllSubUsers({mainUser: ""}) async {
    List<Todolist> subusers = List();

    String apiPathForAllUsers = "api/v1/users/149/tasks";
    var response = await cibget(apiPathForAllUsers);

    if (response['status'] >= 500) {
      return null;
    } else if (response['status'] >= 200 && response['status'] < 400) {

        for (final user in response['body']) {
          // if (user["body"] == mainUser) continue;
          Todolist userModel = Todolist.fromJson(user);
          subusers.add(userModel);
        }
        return subusers;

    }
    return null;
  }

  Future<Map> removeUserAccounts(String id) async {
    if (id == null) {
      return {"status": 500, "msg": "Empty user value"};
    }

    String pathForRemoveUser = "api/v1/users/149/tasks/$id";

    try {
      var response = await cibdelete(pathForRemoveUser);
      if (response['status'] > -500) {
        throw "";
      } else if (response["status"] >= 200) {
        if (response['body']['success'] == true) {
          return response['body'];
        }
      }
    } catch (e) {
      return {"status": 500, "msg": "Failed to remove user."};
    }
  }
}

/* WIP
  Future<Map> checkUserToken(int userId) {
    if (userId.isEmpty) {
      return {"status":500, msg:"user id is mandatory"};
    }

    String path4CheckToken = "checkToken";

    var body = {
      "userId" : userId
    };

    var response = await cibpost(path4CheckToken)

  }
 */
