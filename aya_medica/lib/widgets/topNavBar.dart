import 'package:flutter/material.dart';

class TopNavBar extends StatelessWidget {
  final String userName;
  final String userRole;
  final String? userAvatarUrl;
  final int messageCount;
  final VoidCallback? onMessageTap;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onProfileTap;

  const TopNavBar({
    Key? key,
    required this.userName,
    this.userRole = 'Parent',
    this.userAvatarUrl,
    this.messageCount = 0,
    this.onMessageTap,
    this.onNotificationTap,
    this.onProfileTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[200]!,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side - Avatar and User Info
          GestureDetector(
            onTap: onProfileTap,
            child: Row(
              children: [
                // Avatar
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[300],
                    image: userAvatarUrl != null
                        ? DecorationImage(
                            image: NetworkImage(userAvatarUrl!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: userAvatarUrl == null
                      ? Icon(
                          Icons.person,
                          color: Colors.grey[600],
                          size: 20,
                        )
                      : null,
                ),
                const SizedBox(width: 12),

                // User Info
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, $userName',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      userRole,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Right side - Icons
          GestureDetector(
            onTap: onMessageTap,
            child: Stack(
              children: [
                Icon(
                  Icons.mail_outline,
                  size: 24,
                  color: Colors.grey[700],
                ),
                if (messageCount > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFE53935),
                      ),
                      child: Center(
                        child: Text(
                          messageCount > 9 ? '9+' : '$messageCount',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),

          // Notification icon
          GestureDetector(
            onTap: onNotificationTap,
            child: Icon(
              Icons.notifications_outlined,
              size: 24,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
