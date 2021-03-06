import 'package:flutter/material.dart';

Future responseMessageService(
    Future response, GlobalKey<ScaffoldState> scaffold) async {
  await response.then((result) {
    print(result["tipo_mensaje"].toString());
    switch (result["tipo_mensaje"].toString()) {
      case "0":
        final snackbar = SnackBar(
          backgroundColor: Colors.green,
          content: Text(result["mensaje"].toString()),
          duration: Duration(milliseconds: 1500),
        );
        scaffold.currentState.showSnackBar(snackbar);
        break;
      case "1":
        final snackbar = SnackBar(
          backgroundColor: Colors.black,
          content: Text(result["mensaje"].toString()),
          duration: Duration(milliseconds: 1500),
        );
        scaffold.currentState.showSnackBar(snackbar);
        break;
      case "2":
        final snackbar = SnackBar(
          backgroundColor: Colors.yellowAccent,
          content: Text(result["mensaje"].toString(),
              style: TextStyle(
                color: Colors.black,
              )),
          duration: Duration(milliseconds: 1500),
        );
        scaffold.currentState.showSnackBar(snackbar);
        break;
      default:
        final snackbar = SnackBar(
          backgroundColor: Colors.red,
          content: Text(result["mensaje"].toString()),
          duration: Duration(milliseconds: 1500),
        );
        scaffold.currentState.showSnackBar(snackbar);
        break;
    }
  });
}
