class UserDatabase {
  // Cấu trúc lưu trữ: email -> {'password': '...', 'lastLogin': DateTime}
  static final Map<String, Map<String, dynamic>> _registeredUsers = {
    'admin@gmail.com': {
      'password': '12345678',
      'lastLogin': null,
    },
  };

  static String? currentUserEmail;
  static bool rememberLogin = true;

  // Đăng ký tài khoản mới
  static bool register(String email, String password) {
    String cleanEmail = email.trim().toLowerCase();
    if (_registeredUsers.containsKey(cleanEmail)) {
      return false;
    }
    _registeredUsers[cleanEmail] = {
      'password': password,
      'lastLogin': null,
    };
    return true;
  }

  // Kiểm tra email đã được đăng ký chưa
  static bool isEmailRegistered(String email) {
    return _registeredUsers.containsKey(email.trim().toLowerCase());
  }

  // Xác thực đăng nhập và ghi lại thời điểm đăng nhập gần nhất
  static bool login(String email, String password) {
    String cleanEmail = email.trim().toLowerCase();
    if (_registeredUsers.containsKey(cleanEmail) &&
        _registeredUsers[cleanEmail]!['password'] == password) {
      
      // Lưu thời gian đăng nhập hiện tại
      _registeredUsers[cleanEmail]!['lastLogin'] = DateTime.now();
      currentUserEmail = cleanEmail;
      return true;
    }
    return false;
  }

  // Lấy chuỗi định dạng thời gian đăng nhập gần nhất (VD: 14:35 - 20/05/2026)
  static String getLastLoginFormatted() {
    if (currentUserEmail == null ||
        !_registeredUsers.containsKey(currentUserEmail)) {
      return 'Chưa có thông tin';
    }

    DateTime? lastLogin = _registeredUsers[currentUserEmail]!['lastLogin'];
    if (lastLogin == null) {
      return 'Lần đầu đăng nhập';
    }

    String hour = lastLogin.hour.toString().padLeft(2, '0');
    String minute = lastLogin.minute.toString().padLeft(2, '0');
    String day = lastLogin.day.toString().padLeft(2, '0');
    String month = lastLogin.month.toString().padLeft(2, '0');
    String year = lastLogin.year.toString();

    return '$hour:$minute -$day/$month/$year';
  }
}