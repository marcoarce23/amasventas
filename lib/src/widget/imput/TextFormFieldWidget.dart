import 'package:flutter/material.dart';

class ResponseWidget {
  Widget _widget;
  var _response;

  get widget {
    return this._widget;
  }

  get response {
    return this._response;
  }
}

ResponseWidget textFormField(
  String initialValue,
  String label,
  TextEditingController mycontroller
) {
  var _value;
  ResponseWidget _responseWidget = new ResponseWidget();


  _responseWidget._widget = TextFormField(
    controller: mycontroller,
    initialValue: initialValue,
    textCapitalization: TextCapitalization.sentences,
    decoration: InputDecoration(labelText: label),
    onSaved: (value) => _value = value,
    validator: (value) {
      if (value.length < 3) {
        return 'Ingrese el nombre del producto';
      } else {
        return null;
      }
    },
  );

  _responseWidget._response = _value;

  return _responseWidget;
}
