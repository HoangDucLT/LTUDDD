import 'package:flutter/material.dart';

String getUrlImage() =>
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSXHcy0MxR9bC-ZC76E57959jm1F1_sr65c1mPEfPP5jg&s=10';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFEEE9),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 70, top: 60),
              child: Text('Code lab', style: TextStyle(fontSize: 52, color: Colors.blue)),
            ),
            Expanded(
              child: Center(
                child: Container(
                  width: 360,
                  height: double.infinity,
                  color: Colors.white,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Image.network(getUrlImage(), height: 200, fit: BoxFit.cover),
                      const ListTile(
                        title: Text('Đại Nội Huế', style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('Thành Phố Huế, Việt Nam'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [Icon(Icons.star, color: Colors.red), Text('41')],
                        ),
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(children: [Icon(Icons.call, color: Colors.blue), Text('CALL', style: TextStyle(color: Colors.blue, fontSize: 12))]),
                          Column(children: [Icon(Icons.near_me, color: Colors.blue), Text('ROUTE', style: TextStyle(color: Colors.blue, fontSize: 12))]),
                          Column(children: [Icon(Icons.share, color: Colors.blue), Text('SHARE', style: TextStyle(color: Colors.blue, fontSize: 12))]),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.all(24),
                        child: Text(
                          'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. '
                          'Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. '
                          'A gondola ride from Kandersteg, followed by a half-hour walk through pastures '
                          'and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. '
                          'Activities enjoyed here include rowing, and riding the summer toboggan run.',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}