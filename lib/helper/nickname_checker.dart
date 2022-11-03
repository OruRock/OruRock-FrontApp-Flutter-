
bool nickNameChecker(String nickname) {
  RegExp nickNameRegexp = RegExp(r'^[가-힣a-zA-Z0-9]{2,10}$');
  if(nickNameRegexp.hasMatch(nickname)) {
    return true;
  }
  return false;
}