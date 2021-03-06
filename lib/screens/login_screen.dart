import 'package:flutter/material.dart';
import '../api/dns_api.dart';
import 'data_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ввод данных'),
      ),
      body: LoginForm(),
    );
  }
}


class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  Map <String, String>_data = {
    'firstName': '',
    'lastName': '',
    'email': '',
    'phone': '',
  };
  String _apiToken = '';
  API _api = API.getAPI();


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                hintText: "Имя",
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Пожалуйста введите имя';
                }
                return null;
              },
              onSaved: (String value) {
                this._data['firstName'] = value;
              }
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Фамилия",
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Пожалуйста введите фамилию';
                }
                return null;
              },
                onSaved: (String value) {
                  this._data['lastName'] = value;
                }
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress ,
              decoration: InputDecoration(
                hintText: "e-mail",
              ),
              validator: (value) {
                if (!RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?").hasMatch(value)) {
                  return 'Пожалуйста введите правильный e-mail адрес';
                }
                return null;
              },
                onSaved: (String value) {
                  this._data['email'] = value;
                }
            ),
            TextFormField(
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(
                hintText: "Телефон",
              ),
              validator: (value) {
                if (int.tryParse(value) == null) {
                  return 'Вводите только цифры!';
                }
                return null;
              },
                onSaved: (String value) {
                  this._data['phone'] = value;
                }
            ),
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: RaisedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    try {
                      this._apiToken = await this._api.getToken(params: this._data);
                      //print(this._apiToken);
                      Navigator.pushNamed(
                        context,
                        DataScreen.routeName,
                        arguments: {'data': this._data, 'token': this._apiToken},
                      );
                    } catch (error) {
                      //print(error);
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text('Ошибка при получении токена ($error)')));
                    }
                  }
                },
                child: Text('ПОЛУЧИТЬ КЛЮЧ'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}