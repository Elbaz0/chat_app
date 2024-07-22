class chat_model {
  final String message;
  final String id;

  chat_model(this.message, this.id);

  factory chat_model.fromjson(json) {
    return chat_model(json['msg'], json['id']);
  }
}
