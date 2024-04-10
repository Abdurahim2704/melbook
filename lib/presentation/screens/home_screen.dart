import 'package:flutter/material.dart';

class HomePage1 extends StatefulWidget {
  final List<String> images = [
    'assets/images/ingliztili.png',
    'assets/images/ingliztili.png',
    'assets/images/ingliztili.png',
    'assets/images/ingliztili.png',
    'assets/images/ingliztili.png',
    'assets/images/ingliztili.png',

  ];
  final List<String> secondimages = [
    "assets/images/bookforcover.png",
    "assets/images/bookforcover.png",
    "assets/images/bookforcover.png",
    "assets/images/bookforcover.png",
    "assets/images/bookforcover.png",
  ];

  HomePage1({super.key});

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Xush kelibsiz",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            icon: Icon(Icons.person),
            onPressed: () {},
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 110),
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(36),
                    topRight: Radius.circular(36),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 22, left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Image.asset(
                          'assets/images/first.png',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      SizedBox(height: 18),
                      Container(
                        height: 529,
                        width: 385,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF2F2F2),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 47,
                                    width: 169,
                                    decoration: BoxDecoration(
                                      image: const DecorationImage(
                                          image: AssetImage('assets/images/frame1.png')),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  const SizedBox(width: 30),
                                  Container(
                                    height: 47,
                                    width: 138,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage('assets/images/frame2.png')),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(left: 18),
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  'Tavsiyalar',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.3),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Container(
                                height: 150,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: widget.images.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height: 150,
                                      width: 106,
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(16),
                                          image: DecorationImage(
                                            image: AssetImage(widget.images[index]),
                                            fit: BoxFit.cover,
                                          )),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(left: 18),
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  'Kitoblar',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.3),
                                ),
                              ),
                              SizedBox(height: 12),
                              Container(
                                height: 150,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: widget.secondimages.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      width: 250,
                                      height: 114,
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            widget.secondimages[index],
                                            width: 73,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                          SizedBox(width: 10),
                                          const Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'English Vocabulary\nIN USE',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Icon(Icons.star, color: Colors.yellow),
                                                  Icon(Icons.star, color: Colors.yellow),
                                                  Icon(Icons.star, color: Colors.yellow),
                                                  Icon(Icons.star, color: Colors.yellow),
                                                  Icon(Icons.star, color: Colors.yellow),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                              padding: EdgeInsets.all(7),
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.blue,
                                              ),
                                              child: const Icon(
                                                Icons.play_arrow,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.book, color: Colors.black),
            label: 'Kitoblar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat, color: Colors.black),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.circle_notifications, color: Colors.black),
            label: 'Asosiy',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard, color: Colors.black),
            label: 'Saqlangan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.black),
            label: 'Profil',
          ),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
      ),
    );
  }
}
