import 'package:flutter/material.dart';

import '../../widgets/bottomNavigationBar_widget.dart';

class GuestServerScreen extends StatefulWidget {
  const GuestServerScreen({super.key});

  @override
  GuestServerScreenState createState() => GuestServerScreenState();
}

class GuestServerScreenState extends State<GuestServerScreen> {
  int? _selectedValue = 0;
  late int _currentIndex = 0;


  void _handleRadioValueChange(int? value) {
    setState(() {
      _selectedValue = value;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index; // Update the selected index
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 150,
          ),
          Center(
            child: Container(
              width: 226,
              height: 210,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/searching_image.png'),
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 225.71,
            child: Transform.translate(
              offset: const Offset(0, -8),
              child: const Divider(
                color: Color(0xFFDBD2D1),
                thickness: 1,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Sign in to connect with more servers',
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              letterSpacing: -0.02,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 90, // Button width
            height: 36, // Button height
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF1D1D7D),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              onPressed: () {},
              child: const Text(
                'SIGN UP',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(height: 60),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 32),
              const Icon(
                Icons.language,
                color: Colors.blue,
                size: 20,
              ),
              const SizedBox(width: 16),
              const Text('Smart Location',
                  style: TextStyle(
                    fontSize: 12,
                  )),
              const Spacer(),
              Radio<int>(
                value: 0,
                groupValue: _selectedValue,
                onChanged: _handleRadioValueChange,
              ),
              const SizedBox(width: 32),
            ],
          ),
          const Divider(
            color: Color(0xFFDBD2D1),
            thickness: 1,
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.only(left: 32),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Locations',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Theme.of(context).cardColor,
            child: SizedBox(
              height: 80,
              child: Center(
                child: ListTile(
                  leading: Container(
                    width: 40,
                    height: 25,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/french_flag.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: const Text('France'),
                  trailing: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('231ms', style: TextStyle(color: Colors.blue)),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: VerticalDivider(
                          width: 10,
                          thickness: 1,
                          color: Color(0xFF787473),
                        ),
                      ),
                      Icon(Icons.arrow_drop_down, color: Colors.black),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Theme.of(context).cardColor,
            child: SizedBox(
              height: 80,
              child: Center(
                child: ListTile(
                  leading: Container(
                    width: 40,
                    height: 25,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/french_flag.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: const Text('Poland'),
                  trailing: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('999ms', style: TextStyle(color: Colors.red)),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: VerticalDivider(
                          width: 10,
                          thickness: 1,
                          color: Color(0xFF787473),
                        ),
                      ),
                      Icon(Icons.arrow_drop_down, color: Colors.black),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
