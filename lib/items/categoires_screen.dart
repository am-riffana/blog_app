import 'package:flutter/material.dart';
import 'package:flutter_application_1/items/blog_card.dart';
import 'package:flutter_application_1/provider/blog_provider.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final blogProvider = context.watch<BlogProvider>();
    final categories = blogProvider.categories;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 254, 161, 155),
      appBar: AppBar(
        backgroundColor:  const Color.fromARGB(255, 254, 161, 155),
        title:  Text('Categories')),
      body: GridView.builder(
        padding:  EdgeInsets.all(16),
        gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.2,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final count = blogProvider.getBlogsByCategory(category).length;

          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryBlogsScreen(category: category),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 238, 110, 121),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    category,
                    style:  TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                   SizedBox(height: 6),
                  Text('$count blogs'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CategoryBlogsScreen extends StatelessWidget {
  final String category;

  const CategoryBlogsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final blogs = context.watch<BlogProvider>().getBlogsByCategory(category);

    return Scaffold(
      appBar: AppBar(title: Text(category)),
      body: blogs.isEmpty
          ?  Center(child: Text('No blogs in this category '))
          : ListView.builder(
              itemCount: blogs.length,
              itemBuilder: (context, index) {
                return BlogCard(blog: blogs[index]);
              },
            ),
    );
  }
}