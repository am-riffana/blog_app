import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/blog_model.dart';
import 'package:flutter_application_1/screens/blogdetail_screen.dart';


class BlogCard extends StatelessWidget {
  final BlogModel blog;

  const BlogCard({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Card(
    
      margin:  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlogDetailsScreen(blog: blog),
            ),
          );
        },
        child: Padding(
          padding:  EdgeInsets.all(19),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Chip(label: Text(blog.category)),
               SizedBox(height: 9),
              Text(
                blog.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style:  TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
               SizedBox(height: 7),
              Text(
                blog.content,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
               SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('By ${blog.authorName}'),
                  Text(blog.date),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}