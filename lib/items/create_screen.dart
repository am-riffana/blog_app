import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/auth_provider.dart';
import 'package:flutter_application_1/provider/blog_provider.dart';
import 'package:provider/provider.dart';

class CreateBlogScreen extends StatefulWidget {
  const CreateBlogScreen({super.key});

  @override
  State<CreateBlogScreen> createState() => _CreateBlogScreenState();
}

class _CreateBlogScreenState extends State<CreateBlogScreen> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  String selectedCategory = 'Technology';

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  Future<void> publishBlog() async {
    if (!formKey.currentState!.validate()) return;

    final blogProvider = context.read<BlogProvider>();
    final user = context.read<AuthProvider>().user!;

    await blogProvider.addBlog(
      title: titleController.text.trim(),
      content: contentController.text.trim(),
      category: selectedCategory,
      authorName: user.name,
      authorEmail: user.email,
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text('Blog published')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final categories = context.read<BlogProvider>().categories;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 165, 165),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 165, 165),
        title:  Text('Create Blog'),
      ),
      body: SingleChildScrollView(
        padding:  EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration:  InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter a title';
                  }
                  return null;
                },
              ),
               SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: selectedCategory,
                decoration:  InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                items: categories.map((cat) {
                  return DropdownMenuItem(value: cat, child: Text(cat));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value!;
                  });
                },
              ),
               SizedBox(height: 16),

              TextFormField(
                controller: contentController,
                minLines: 8,
                maxLines: 20,
                decoration:  InputDecoration(
                  labelText: 'Write your blog',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().length < 10) {
                    return 'Write at least 10 characters';
                  }
                  return null;
                },
              ),
               SizedBox(height: 24),

              SizedBox(
                width: 250,
                height: 50,
                child: FilledButton(
                  onPressed: publishBlog,
                  child:  Text('Publish Blog'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}