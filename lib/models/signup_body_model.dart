//Загатовка для авторизации. В метод валидации, при успешном вводе данных создаеться экземляр класс SignUpBody
// в экземляр передаются значения
class SignUpBody{
  String name;
  //String phone;
  String email;
  String passwd;
  SignUpBody({
    required this.name,
    //required this.phone,
    required this.email,
    required this.passwd,
});

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["name"] = this.name; // f is - first name
    //data["phone"] = this.phone;
    //TODO: Мирослав email обозвал как login
    data["login"] = this.email;
    data["passwd"] = this.passwd;
    return data;
  }
}