import 'dart:async';
import 'dart:ui'; // Cần thiết để sử dụng PointerDeviceKind
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// 1. ScrollBehavior giúp vuốt/lướt slider bằng con chuột trên Web và máy tính
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class MySliderPage extends StatefulWidget {
  const MySliderPage({super.key});

  @override
  State<MySliderPage> createState() => _MySliderPageState();
}

class _MySliderPageState extends State<MySliderPage> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  int _currentPage = 0;
  Timer? _timer;

  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?w=700',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?w=700',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?w=700',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?w=700',
    'https://images.unsplash.com/photo-1508700115892-45ecd05ae2ad?w=700',
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < imgList.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // AppBar tiêu đề
            AppBar(
              leading: const Icon(Icons.arrow_back_ios, color: Colors.white),
              title: const Text(
                'Complicated image slider demo',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              backgroundColor: Colors.blue,
              elevation: 0,
            ),

            // Slider chiếm toàn bộ chiều cao còn lại
            Expanded(
              child: ScrollConfiguration(
                behavior: MyCustomScrollBehavior(),
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (int index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: imgList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      // Bấm vào ảnh nào sẽ chuyển tới ảnh đó
                      onTap: () {
                        _pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(
                                imgList[index],
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                bottom: 20,
                                left: 20,
                                child: Text(
                                  'No. $index image',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(blurRadius: 6, color: Colors.black),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Indicator phía dưới với hiệu ứng Swap
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: SmoothPageIndicator(
                controller: _pageController,
                count: imgList.length,
                onDotClicked: (index) {
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                },
                effect: const SwapEffect(
                  activeDotColor: Colors.blue,
                  dotColor: Color(0xFFDCDCDC),
                  dotWidth: 10,
                  dotHeight: 10,
                  spacing: 8,
                  type: SwapType.yRotation,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}