class FcmModel {
  String title;
  String body;
  String data;
  String token;

  FcmModel(String title, String body, String data, String token) {
    this.title = title;
    this.body = body;
    this.data = data;
    this.token = token;
  }

  String get getTitle => title;
  set setTitle(String title) => this.title = title;

  String get getBody => body;
  set setBody(String body) => this.body = body;

  String get getData => data;
  set setData(String data) => this.data = data;
}
