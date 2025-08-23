import 'package:flutter/material.dart';

void main() {
  runApp(const Profile());
}

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.pink.shade100,
              Colors.pink.shade300,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Card(
            color: Colors.pink[50],
            elevation: 25,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              width: 380,
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color.fromARGB(255, 192, 126, 148),
                        width: 6,
                      ),
                    ),
                    child: const CircleAvatar(
                      radius: 70,
                      backgroundImage: NetworkImage(
                        "https://scontent.fbkk17-1.fna.fbcdn.net/v/t39.30808-6/307369352_397154232604177_210431761487047548_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=6ee11a&_nc_eui2=AeGKtW0gBOPV1Y-4qyrwIH0luduApyJ5-_6524CnInn7_sKgEVyCAneaJInJ3wWx87_OWlIxNKcieq8oJSJbRgVI&_nc_ohc=NKKGbJv2LzcQ7kNvwHDJm5T&_nc_oc=AdnkJS94ca6J0EF2i3z1VJCJGnSL3iaZJ_uo_UGEAi5ppB2hd0aWcT1177tZBiBwuLA&_nc_zt=23&_nc_ht=scontent.fbkk17-1.fna&_nc_gid=wcLuvEhXiFU5Ff1bdblPQA&oh=00_AfVatf4CrBlun1nBkoQL7KpVTrg3eS2X9L_PPxlB-bKorA&oe=68AF135D",
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Athichar Kijcharoen",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Information Technology",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueGrey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 13),
                  Text(
                    "660710748",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blueGrey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Divider(
                    color: Colors.black.withOpacity(0.3),
                    thickness: 2,
                    indent: 50,
                    endIndent: 50,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "I believe every pain shapes growth — that’s why I chose this field.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blueGrey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.email, color: Colors.blue),
                      const SizedBox(width: 8),
                      Text(
                        "kijcharoen_a@su.ac.th",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blueGrey[800],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
