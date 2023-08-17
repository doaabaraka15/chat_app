class Message{
  late String content ;
  late String time ;
  late String email ;


  Message();
  Message.fromMap(Map<String , dynamic> map){
    content = map['content'];
    time = map['time'];
    email = map['email'];
  }
  Map<String , dynamic> toMap(){
    Map<String , dynamic> map =<String ,dynamic>{};
    map['content'] = content ;
    map['time'] = time ;
    map['email'] = email ;
    return map ;

  }


}