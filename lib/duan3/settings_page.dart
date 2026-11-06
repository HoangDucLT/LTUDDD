import 'package:flutter/material.dart';
import 'login_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Trạng thái Bật/Tắt nhóm 1
  bool _receiveNotifications = true;
  bool _darkMode = false; // Thêm chế độ tối
  bool _rememberLogin = true;

  // Trạng thái nhóm 2
  String _selectedLanguage = 'Tiếng Việt';
  String _selectedFontSize = 'Vừa';

  // 1. Tính toán tỷ lệ cỡ chữ linh hoạt
  double get _fontScale {
    switch (_selectedFontSize) {
      case 'Nhỏ':
      case 'Small':
        return 0.85;
      case 'Lớn':
      case 'Large':
        return 1.15;
      case 'Rất lớn':
      case 'Extra Large':
        return 1.3;
      case 'Vừa':
      case 'Medium':
      default:
        return 1.0;
    }
  }

  // 2. Từ điển ngôn ngữ cho giao diện Cài đặt
  final Map<String, Map<String, String>> _localizedTexts = {
    'Tiếng Việt': {
      'title': 'Cài đặt',
      'group1': 'THÔNG BÁO & BẢO MẬT',
      'notif': 'Nhận thông báo',
      'darkMode': 'Chế độ tối',
      'remember': 'Nhớ đăng nhập',
      'group2': 'ỨNG DỤNG',
      'lang': 'Ngôn ngữ',
      'fontSize': 'Cỡ chữ',
      'about': 'Về ứng dụng',
      'version': 'Phiên bản 1.0.0',
      'logout': 'Đăng xuất',
      'logoutTitle': 'Xác nhận đăng xuất',
      'logoutMsg': 'Bạn có chắc chắn muốn đăng xuất khỏi ứng dụng không?',
      'cancel': 'Hủy',
      'selectLang': 'Chọn ngôn ngữ',
      'selectFont': 'Chọn cỡ chữ',
    },
    'English': {
      'title': 'Settings',
      'group1': 'NOTIFICATIONS & SECURITY',
      'notif': 'Receive notifications',
      'darkMode': 'Dark mode',
      'remember': 'Remember login',
      'group2': 'APPLICATION',
      'lang': 'Language',
      'fontSize': 'Font size',
      'about': 'About app',
      'version': 'Version 1.0.0',
      'logout': 'Log out',
      'logoutTitle': 'Confirm Logout',
      'logoutMsg': 'Are you sure you want to log out of the application?',
      'cancel': 'Cancel',
      'selectLang': 'Select Language',
      'selectFont': 'Select Font Size',
    },
    'Français': {
      'title': 'Paramètres',
      'group1': 'NOTIFICATIONS ET SÉCURITÉ',
      'notif': 'Recevoir des notifications',
      'darkMode': 'Mode sombre',
      'remember': 'Se souvenir de moi',
      'group2': 'APPLICATION',
      'lang': 'Langue',
      'fontSize': 'Taille de police',
      'about': 'À propos de l\'application',
      'version': 'Version 1.0.0',
      'logout': 'Se déconnecter',
      'logoutTitle': 'Confirmer la déconnexion',
      'logoutMsg': 'Voulez-vous vraiment vous déconnecter ?',
      'cancel': 'Annuler',
      'selectLang': 'Choisir la langue',
      'selectFont': 'Choisir la taille de police',
    },
    '日本語': {
      'title': '設定',
      'group1': '通知とセキュリティ',
      'notif': '通知を受け取る',
      'darkMode': 'ダークモード',
      'remember': 'ログイン状態を保存',
      'group2': 'アプリ',
      'lang': '言語',
      'fontSize': 'フォントサイズ',
      'about': 'アプリについて',
      'version': 'バージョン 1.0.0',
      'logout': 'ログアウト',
      'logoutTitle': 'ログアウトの確認',
      'logoutMsg': '本当にログアウトしますか？',
      'cancel': 'キャンセル',
      'selectLang': '言語を選択',
      'selectFont': 'フォントサイズを選択',
    },
  };

  // Hàm dịch nhanh dựa trên ngôn ngữ đang chọn
  String _getText(String key) {
    return _localizedTexts[_selectedLanguage]?[key] ?? _localizedTexts['Tiếng Việt']![key]!;
  }

  // Danh sách tùy chọn cỡ chữ thích ứng theo ngôn ngữ
  List<String> get _fontSizeOptions {
    if (_selectedLanguage == 'English') {
      return ['Small', 'Medium', 'Large', 'Extra Large'];
    }
    return ['Nhỏ', 'Vừa', 'Lớn', 'Rất lớn'];
  }

  // Hàm hiển thị BottomSheet chọn giá trị
  void _showSelectionBottomSheet({
    required String title,
    required List<String> options,
    required String currentValue,
    required ValueChanged<String> onSelect,
  }) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18 * _fontScale,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(height: 1),
              ...options.map((option) {
                final isSelected = option == currentValue;
                return ListTile(
                  title: Text(
                    option,
                    style: TextStyle(
                      fontSize: 15 * _fontScale,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? Colors.blue : Colors.black87,
                    ),
                  ),
                  trailing: isSelected ? const Icon(Icons.check, color: Colors.blue) : null,
                  onTap: () {
                    onSelect(option);
                    Navigator.pop(context);
                  },
                );
              }),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  // Hàm hiển thị Hộp thoại Đăng xuất
  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text(
            _getText('logoutTitle'),
            style: TextStyle(fontSize: 18 * _fontScale, fontWeight: FontWeight.bold),
          ),
          content: Text(
            _getText('logoutMsg'),
            style: TextStyle(fontSize: 14 * _fontScale),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                _getText('cancel'),
                style: TextStyle(color: Colors.grey, fontSize: 14 * _fontScale),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(
                _getText('logout'),
                style: TextStyle(color: Colors.white, fontSize: 14 * _fontScale),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Phối màu giao diện linh hoạt theo Chế độ tối
    final backgroundColor = _darkMode ? const Color(0xFF121212) : const Color(0xFFF8F9FA);
    final cardColor = _darkMode ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = _darkMode ? Colors.white : Colors.black87;
    final subtitleColor = _darkMode ? Colors.grey.shade400 : Colors.grey;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          _getText('title'),
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 18 * _fontScale,
          ),
        ),
        backgroundColor: cardColor,
        elevation: 0.5,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          // NHÓM 1: THÔNG BÁO & BẢO MẬT
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              _getText('group1'),
              style: TextStyle(
                fontSize: 12 * _fontScale,
                fontWeight: FontWeight.bold,
                color: subtitleColor,
              ),
            ),
          ),
          Container(
            color: cardColor,
            child: Column(
              children: [
                // 1. Nhận thông báo
                SwitchListTile(
                  title: Text(
                    _getText('notif'),
                    style: TextStyle(color: textColor, fontSize: 15 * _fontScale),
                  ),
                  value: _receiveNotifications,
                  activeColor: Colors.blue,
                  onChanged: (value) {
                    setState(() {
                      _receiveNotifications = value;
                    });
                  },
                ),
                Divider(height: 1, indent: 16, color: _darkMode ? Colors.grey.shade800 : Colors.grey.shade200),

                // 2. CHẾ ĐỘ TỐI (MỚI BỔ SUNG)
                SwitchListTile(
                  title: Text(
                    _getText('darkMode'),
                    style: TextStyle(color: textColor, fontSize: 15 * _fontScale),
                  ),
                  value: _darkMode,
                  activeColor: Colors.blue,
                  onChanged: (value) {
                    setState(() {
                      _darkMode = value; // Cập nhật màu giao diện ngay lập tức
                    });
                  },
                ),
                Divider(height: 1, indent: 16, color: _darkMode ? Colors.grey.shade800 : Colors.grey.shade200),

                // 3. Nhớ đăng nhập
                SwitchListTile(
                  title: Text(
                    _getText('remember'),
                    style: TextStyle(color: textColor, fontSize: 15 * _fontScale),
                  ),
                  value: _rememberLogin,
                  activeColor: Colors.blue,
                  onChanged: (value) {
                    setState(() {
                      _rememberLogin = value;
                    });
                  },
                ),
                // Mục cuối không có đường kẻ
              ],
            ),
          ),

          const SizedBox(height: 24),

          // NHÓM 2: ỨNG DỤNG
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              _getText('group2'),
              style: TextStyle(
                fontSize: 12 * _fontScale,
                fontWeight: FontWeight.bold,
                color: subtitleColor,
              ),
            ),
          ),
          Container(
            color: cardColor,
            child: Column(
              children: [
                // Thay đổi Ngôn ngữ
                ListTile(
                  title: Text(
                    _getText('lang'),
                    style: TextStyle(color: textColor, fontSize: 15 * _fontScale),
                  ),
                  subtitle: Text(
                    _selectedLanguage,
                    style: TextStyle(color: subtitleColor, fontSize: 13 * _fontScale),
                  ),
                  trailing: Icon(Icons.chevron_right, color: subtitleColor),
                  onTap: () {
                    _showSelectionBottomSheet(
                      title: _getText('selectLang'),
                      options: ['Tiếng Việt', 'English', 'Français', '日本語'],
                      currentValue: _selectedLanguage,
                      onSelect: (val) {
                        setState(() {
                          _selectedLanguage = val;
                          // Tự động chuyển đổi nhãn cỡ chữ mặc định phù hợp với ngôn ngữ
                          if (val == 'English' && _selectedFontSize == 'Vừa') {
                            _selectedFontSize = 'Medium';
                          } else if (val == 'Tiếng Việt' && _selectedFontSize == 'Medium') {
                            _selectedFontSize = 'Vừa';
                          }
                        });
                      },
                    );
                  },
                ),
                Divider(height: 1, indent: 16, color: _darkMode ? Colors.grey.shade800 : Colors.grey.shade200),

                // Thay đổi Cỡ chữ
                ListTile(
                  title: Text(
                    _getText('fontSize'),
                    style: TextStyle(color: textColor, fontSize: 15 * _fontScale),
                  ),
                  subtitle: Text(
                    _selectedFontSize,
                    style: TextStyle(color: subtitleColor, fontSize: 13 * _fontScale),
                  ),
                  trailing: Icon(Icons.chevron_right, color: subtitleColor),
                  onTap: () {
                    _showSelectionBottomSheet(
                      title: _getText('selectFont'),
                      options: _fontSizeOptions,
                      currentValue: _selectedFontSize,
                      onSelect: (val) => setState(() => _selectedFontSize = val),
                    );
                  },
                ),
                Divider(height: 1, indent: 16, color: _darkMode ? Colors.grey.shade800 : Colors.grey.shade200),

                // Về ứng dụng
                ListTile(
                  title: Text(
                    _getText('about'),
                    style: TextStyle(color: textColor, fontSize: 15 * _fontScale),
                  ),
                  subtitle: Text(
                    _getText('version'),
                    style: TextStyle(color: subtitleColor, fontSize: 13 * _fontScale),
                  ),
                  trailing: Icon(Icons.chevron_right, color: subtitleColor),
                  onTap: () {
                    showAboutDialog(
                      context: context,
                      applicationName: _getText('title'),
                      applicationVersion: '1.0.0',
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Nút Đăng xuất
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: OutlinedButton(
              onPressed: _showLogoutDialog,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: const BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                _getText('logout'),
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16 * _fontScale,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}