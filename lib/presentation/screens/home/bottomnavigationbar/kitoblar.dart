import 'package:flutter/material.dart';

class KitoblarPage extends StatefulWidget {
  const KitoblarPage({Key? key}) : super(key: key);

  @override
  State<KitoblarPage> createState() => _KitoblarPageState();
}

class _KitoblarPageState extends State<KitoblarPage> {
  int _selectedIndex = 0; // Added this to manage the bottom navigation bar's state

  // Example book data (replace with your actual data source)
  final List<Map<String, dynamic>> _books = List.generate(
    10,
        (index) => {
      'title': 'Book $index',
      'rating': List.generate(5, (index) => Icons.star),
    },
  );

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
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {},
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications),
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
                          'assets/images/img_homeslide.png',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      const SizedBox(height: 18),
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
                                  ),
                                  const SizedBox(width: 30),
                                  Container(
                                    height: 47,
                                    width: 138,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(image: AssetImage('assets/images/frame2.png')),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Container(
                                margin: const EdgeInsets.only(left: 18),
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  'Tavsiyalar',
                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, letterSpacing: 1.3),
                                ),
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                height: 150,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _books.length, // Adjusted to use example data
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height: 150,
                                      width: 106,
                                      margin: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                margin: const EdgeInsets.only(left: 18),
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  'Kitoblar',
                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, letterSpacing: 1.3),
                                ),
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                height: 150,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _books.length, // Adjusted to use example data
                                  itemBuilder: (context, index) {
                                    final book = _books[index]; // Fetch book from example data
                                    return Container(
                                      width: 260,
                                      height: 114,
                                      margin: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 10),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                book['title'], // Use book title from data
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Row(
                                                children: List<Icon>.from(book['rating']), // Use rating icons
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                              padding: const EdgeInsets.all(7),
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
            icon: Icon(Icons.book),
            label: 'Kitoblar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.circle_notifications),
            label: 'Asosiy',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Saqlangan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 10.0,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
