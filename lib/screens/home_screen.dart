import 'package:flutter/material.dart';
import 'package:flutter_application_1/items/blog_card.dart';
import 'package:flutter_application_1/items/categoires_screen.dart';
import 'package:flutter_application_1/provider/blog_provider.dart';
import 'package:flutter_application_1/screens/profile_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
       AllBlogsPage(),
       CategoriesScreen(),
       ProfileScreen(),
    ];

    return Scaffold(
      body: pages[currentIndex],

      floatingActionButton: currentIndex == 0
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.pushNamed(context, '/create');
              },
              icon:  Icon(Icons.add),
              label:  Text('Write'),
            )
          : null,

      bottomNavigationBar: NavigationBar(
        backgroundColor:  Color.fromARGB(255, 251, 209, 209),
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index; // <-- ITHAAYIRUNNU MISSING
          });
        },
        destinations:  [
          NavigationDestination(icon: Icon(Icons.home_work), label: 'Home'),
          NavigationDestination(
              icon: Icon(Icons.category_outlined), label: 'Categories'),
          NavigationDestination(
              icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

class AllBlogsPage extends StatelessWidget {
    const AllBlogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final blogProvider = context.watch<BlogProvider>();
    final blogs = blogProvider.blogs;

    return Scaffold(
      backgroundColor:  Color.fromARGB(255, 254, 165, 165),
      appBar: AppBar(
        backgroundColor:  Color.fromARGB(255, 254, 165, 165),
        title:  Text(
          'All Blogs',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon:  Icon(Icons.search, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
          ),
        ],
      ),
      body: blogs.isEmpty
          ?  Center(child: Text('No blogs'))
          : ListView.builder(
              padding:  EdgeInsets.only(bottom: 90),
              itemCount: blogs.length,
              itemBuilder: (context, index) {
                return BlogCard(blog: blogs[index]);
              },
            ),
    );
  }
}