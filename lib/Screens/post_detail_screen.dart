import 'package:assessment_app/models/post_details_model.dart';
import 'package:assessment_app/models/user_model.dart';
import 'package:flutter/material.dart';

class PostDetailScreen extends StatefulWidget {
  final PostDetailsModel post;
  final UserModel author;
  const PostDetailScreen({super.key, required this.post, required this.author});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Author: ${widget.author.name}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(widget.post.body),
          ],
        ),
      ),
    );
  }
}
