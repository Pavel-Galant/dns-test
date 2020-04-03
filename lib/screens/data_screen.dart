import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../api/dns_api.dart';

class DataScreen extends StatelessWidget {
  static const routeName = '/data';
  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Отправка данных"),
      ),
      body: DataForm(args['data'], args['token'])
    );
  }
}

class DataForm extends StatefulWidget {
  final String token;
  final Map <String, String> loginData;

  const DataForm (this.loginData, this.token , {Key key}) : super(key: key);
  @override
  DataFormState createState() => DataFormState();
}

class DataFormState extends State<DataForm> {
  final _formKey = GlobalKey<FormState>();
  Map <String, String>_data = {
    'githubProfileUrl': '',
    'summary': ''
  };
  API _api = API.getAPI();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                hintText: "Ссылка на github",
              ),
              validator: (value) {
                if (value.isEmpty || !Uri.parse(value).isAbsolute) {
                  return 'Пожалуйста введите url';
                }
                return null;
              },
              onSaved: (String value) {
                this._data['githubProfileUrl'] = value;
              }
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Ссылка на резюме",
              ),
              validator: (value) {
                if (value.isEmpty || !Uri.parse(value).isAbsolute) {
                  return 'Пожалуйста введите url';
                }
                return null;
              },
                onSaved: (String value) {
                  this._data['summary'] = value;
                }
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    try {
                      await _api.testSummary(params: {...this._data, ...widget.loginData}, token: widget.token);
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text('Данные успешно отправлены на сервер')));
                    } catch (error) {
                      //print(error);
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text("Ошибка при отправке данных на сервер ($error)")));
                    }
                  }
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}