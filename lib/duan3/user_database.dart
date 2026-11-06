class UserDatabase {
  // Lưu trữ các tài khoản dạng {email: password}
  static final Map<String, String> _registeredUsers = {
    'admin@gmail.com': '12345678', // Tài khoản mẫu mặc định để kiểm thử
  };

  // Đăng ký tài khoản mới
  static bool register(String email, String password) {
    String cleanEmail = email.trim().toLowerCase();
    if (_registeredUsers.containsKey(cleanEmail)) {
      return false; // Email đã tồn tại
    }
    _registeredUsers[cleanEmail] = password;
    return true;
  }

  // Kiểm tra email đã được đăng ký chưa
  static bool isEmailRegistered(String email) {
    return _registeredUsers.containsKey(email.trim().toLowerCase());
  }

  // Kiểm tra thông tin đăng nhập (email + mật khẩu)
  static bool login(String email, String password) {
    String cleanEmail = email.trim().toLowerCase();
    return _registeredUsers.containsKey(cleanEmail) && _registeredUsers[cleanEmail] == password;
  }
}