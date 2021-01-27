class ResponsesService<T> {
  Status status;
  T data;
  String message;

  ResponsesService.loading(this.message) : status = Status.LOADING;
  ResponsesService.completed(this.data) : status = Status.COMPLETED;
  ResponsesService.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { LOADING, COMPLETED, ERROR }
