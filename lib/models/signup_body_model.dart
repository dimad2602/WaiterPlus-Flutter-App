//Загатовка для авторизации. В метод валидации, при успешном вводе данных создаеться экземляр класс SignUpBody
// в экземляр передаются значения
class SignUpBody{
  String name;
  String phone;
  String email;
  String password;
  SignUpBody({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
});

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["f_name"] = this.name; // f is - first name
    data["phone"] = this.phone;
    data["email"] = this.email;
    data["password"] = this.password;
    return data;
  }
}