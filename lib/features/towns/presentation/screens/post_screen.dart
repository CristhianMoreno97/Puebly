import 'package:flutter/material.dart';
import 'package:puebly/features/towns/presentation/widgets/custom_appbar.dart';
import 'package:puebly/features/towns/presentation/widgets/custom_drawer.dart';

class PostScreen extends StatelessWidget {
  final String postId;
  const PostScreen({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      body: Center(
        child: Text('Post Screen - $postId'),
      ),
    );
  }
}
