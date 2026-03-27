import 'package:aya_medica/widgets/TopNavBar.dart';
import 'package:aya_medica/widgets/bottomNavBar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final String userName = 'Khaled'; // Replace with actual user name

  void _onNavBarTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to different screens based on index
    switch (index) {
      case 0:
        // Home - already here
        break;
      case 1:
        // Find Doctor
        // Navigator.push(context, MaterialPageRoute(builder: (context) => const FindDoctorScreen()));
        break;
      case 2:
        // Calendar
        // Navigator.push(context, MaterialPageRoute(builder: (context) => const CalendarScreen()));
        break;
      case 3:
        // Records
        // Navigator.push(context, MaterialPageRoute(builder: (context) => const RecordsScreen()));
        break;
      case 4:
        // Profile
        // Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
        break;
    }
  }

  void _handleSkip() {
    // Skip the tour
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Tour skipped'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _handleTakeTour() {
    // Start the tour
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Starting tour...'),
        duration: Duration(seconds: 1),
      ),
    );
    // You can navigate to a tour screen or show an overlay here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Top Navigation Bar
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: TopNavBar(
          userName: userName,
          userRole: 'Parent',
          userAvatarUrl: null,
          messageCount: 1,
          onMessageTap: () {
            // Handle message tap
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Messages'),
                duration: Duration(seconds: 1),
              ),
            );
          },
          onNotificationTap: () {
            // Handle notification tap
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Notifications'),
                duration: Duration(seconds: 1),
              ),
            );
          },
          onProfileTap: () {
            // Navigate to profile
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Profile'),
                duration: Duration(seconds: 1),
              ),
            );
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Main content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    // Illustration
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Image.asset(
                        'assets/images/homescreen.png',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(
                              Icons.image_not_supported,
                              size: 80,
                              color: Colors.grey[400],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Welcome text
                    Text(
                      'Welcome , $userName',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Description
                    Text(
                      'We are happy to have you onboard, click the button below to take a tour and know how to monitor records and appointments',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600],
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Buttons
                    Row(
                      children: [
                        // Skip button
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _handleSkip,
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              side: BorderSide(
                                color: Colors.grey[400]!,
                                width: 1.5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text(
                              'Skip',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Take tour button
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _handleTakeTour,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1E40AF),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'Take the tour',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onNavBarTapped,
      ),
    );
  }
}
