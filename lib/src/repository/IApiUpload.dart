abstract class IApiUpload {
   String api();
}

class ApiCloudy extends IApiUpload {
   String api() {
    return 'https://api.cloudinary.com/v1_1/propia/image/upload?upload_preset=luwzr1vw';
  }
}

class ApiAWS extends IApiUpload {
  String api() {
    return 'https://api.cloudinary.com/v1_1/propia/image/upload?upload_preset=luwzr1vw';
  }
}
