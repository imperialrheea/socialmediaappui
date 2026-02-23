import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// MyApp is the root of your application.
// It sets up the theme (Colors, Fonts) and the starting screen.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Removes the red 'Debug' banner
      title: 'TELE CLONE',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        useMaterial3: true,
        // Global styling for all AppBars in the app
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.pink,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      // The app starts at the ChatListScreen
      home: const ChatListScreen(),
    );
  }
}

// --- CHAT LIST SCREEN ---
class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TELE CLONE'),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        ],
      ),
      drawer: _buildDrawer(context),
      body: ListView(
        children: [
          _buildStoriesBar(),
          const Divider(height: 1),
          // Using Picsum for chat profile pictures
          const ChatListItem(
            avatarUrl: 'https://picsum.photos/id/1011/150/150', // Picsum ID 1011
            name: 'Skylar Rose',
            lastMessage: 'Hey, how are you doing?',
            time: '10:30 AM',
            unreadCount: 2,
          ),
          const ChatListItem(
            avatarUrl: 'https://picsum.photos/id/1027/150/150', // Picsum ID 1027
            name: 'Work Group',
            lastMessage: 'Meeting is rescheduled to 3 PM.',
            time: 'Yesterday',
            unreadCount: 1,
          ),
          const ChatListItem(
            avatarUrl: 'https://picsum.photos/id/1025/150/150', // Picsum ID 1025
            name: 'Luna Lovegood',
            lastMessage: 'Don\'t forget dinner tonight!',
            time: 'Feb 20',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.pink,
        child: const Icon(Icons.edit, color: Colors.white),
      ),
    );
  }

  // HELPER: Builds the horizontal scrolling area for stories with Picsum photos
  Widget _buildStoriesBar() {
    return SizedBox(
      height: 110,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          _buildStoryItem('Your Story', 'https://picsum.photos/id/64/150/150', isMe: true),
          _buildStoryItem('Travel', 'https://picsum.photos/id/10/150/150'),
          _buildStoryItem('Nature', 'https://picsum.photos/id/15/150/150'),
          _buildStoryItem('City', 'https://picsum.photos/id/237/150/150'),
          _buildStoryItem('Art', 'https://picsum.photos/id/24/150/150'),
        ],
      ),
    );
  }

  Widget _buildStoryItem(String label, String imageUrl, {bool isMe = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(2.5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: isMe ? null : const LinearGradient(colors: [Colors.pinkAccent, Colors.orangeAccent]),
                  color: isMe ? Colors.grey.shade300 : null,
                ),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(radius: 27, backgroundImage: NetworkImage(imageUrl)),
                ),
              ),
              if (isMe)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.pink, shape: BoxShape.circle),
                    padding: const EdgeInsets.all(2),
                    child: const Icon(Icons.add, color: Colors.white, size: 18),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 5),
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

// --- REUSABLE DRAWER ---
Widget _buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(color: Colors.pink),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CircleAvatar(radius: 30, backgroundImage: NetworkImage('https://picsum.photos/id/64/150/150')),
              SizedBox(height: 8),
              Text('Yanzie Imperial', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              Text('imperialyanzie@gmail.com', style: TextStyle(color: Colors.white70, fontSize: 13)),
            ],
          ),
        ),
        ListTile(leading: const Icon(Icons.group, color: Colors.pink), title: const Text('New Group'), onTap: () {}),
        ListTile(leading: const Icon(Icons.settings, color: Colors.pink), title: const Text('Settings'), onTap: () {}),
      ],
    ),
  );
}

// --- CHAT LIST ITEM ---
class ChatListItem extends StatelessWidget {
  final String avatarUrl, name, lastMessage, time;
  final int? unreadCount;
  const ChatListItem({super.key, required this.avatarUrl, required this.name, required this.lastMessage, required this.time, this.unreadCount});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(radius: 28, backgroundImage: NetworkImage(avatarUrl)),
          title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(lastMessage, maxLines: 1, overflow: TextOverflow.ellipsis),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(time, style: const TextStyle(fontSize: 12)),
              if (unreadCount != null)
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(color: Colors.pinkAccent, shape: BoxShape.circle),
                  child: Text('$unreadCount', style: const TextStyle(color: Colors.white, fontSize: 10)),
                )
            ],
          ),
        ),
        const Divider(height: 1, indent: 80),
      ],
    );
  }
}