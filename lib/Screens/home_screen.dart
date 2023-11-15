import 'dart:convert';

import 'package:assessment_app/Screens/post_detail_screen.dart';
import 'package:assessment_app/models/post_details_model.dart';
import 'package:assessment_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostDetailsModel> posts = [];

  Future<void> fetchPosts() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      setState(() {
        posts =
            jsonData.map((post) => PostDetailsModel.fromJson(post)).toList();
      });
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<UserModel> fetchUser(int userId) async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/users/$userId'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return UserModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load user');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post List'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return FutureBuilder<UserModel>(
            future: fetchUser(posts[index].userId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const ListTile(
                  title: Text('Loading...'),
                );
              } else if (snapshot.hasError) {
                return const ListTile(
                  title: Text('Error loading author'),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 1, color: Colors.black)),
                    child: ListTile(
                      title: Text('Author: ${snapshot.data?.name ?? 'Unknown'}',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(posts[index].title),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PostDetailScreen(
                              post: posts[index],
                              author: snapshot.data ??
                                  UserModel(id: -1, name: 'Unknown'),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
