class Validators{

  bool validateContactNumber(num) {
    if (num[0] == '+') {
      return num.length == 12;
    } else {
    return num.length == 10;
    }
  }

  bool validateEmail(String emailString) {

    String algorithm = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(algorithm);
    return regExp.hasMatch(emailString);
  }

}