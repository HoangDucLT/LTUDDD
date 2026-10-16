import 'dart:async';
import 'package:flutter/material.dart';

class MyIndicator extends StatefulWidget {
  const MyIndicator({super.key});

  @override
  State<MyIndicator> createState() => _MyIndicatorState();
}

class _MyIndicatorState extends State<MyIndicator> {
  int totalItems = 5;
  double w = 20; // 
  double h = 20;
  double s = 6;  // 
  int currentIndex = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  // Khởi tạo hoặc reset lại đếm ngược 5s
  void startTimer() {
    timer?.cancel(); // 
    timer = Timer.periodic(const Duration(seconds: 5), (t) {
      if (!mounted) return;
      setState(() {
        currentIndex = (currentIndex + 1) % totalItems;
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  // Xử lý khi bấm nút "Tới"
  void nextItem() {
    setState(() {
      currentIndex = (currentIndex + 1) % totalItems;
    });
    startTimer(); 
  }

  // Xử lý khi bấm nút "Lùi"
  void previousItem() {
    setState(() {
      currentIndex = (currentIndex - 1 + totalItems) % totalItems;
    });
    startTimer(); 
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold( 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 1. Hàng chứa 2 nút bấm
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: previousItem, 
                  child: const Text("Lùi"),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: nextItem, 
                  child: const Text("Tới"),
                ),
              ],
            ),
            
            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                totalItems,
                (index) => buildIndicator(index, currentIndex),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIndicator(int index, int currentIndex) {
    return Container(
      width: w,
      height: h,
      margin: EdgeInsets.symmetric(horizontal: s),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: index == currentIndex ? Colors.blue : Colors.grey.shade400,
      ),
    );
  }
}