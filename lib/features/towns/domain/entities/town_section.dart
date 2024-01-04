import 'package:flutter/material.dart';
import 'package:puebly/features/towns/domain/entities/post.dart';

class TownSection {
  final int categoryId;
  final String name;
  final String description;
  final String featuredImgUrl;
  final IconData icon;
  final Color color;
  final List<Post> posts;

  TownSection({
    required this.categoryId,
    required this.name,
    required this.description,
    required this.featuredImgUrl,
    required this.icon,
    required this.color,
    this.posts = const [],
  });

  TownSection copyWith({
    int? categoryId,
    String? name,
    String? description,
    String? featuredImgUrl,
    IconData? icon,
    Color? color,
    List<Post>? posts,
  }) {
    return TownSection(
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      description: description ?? this.description,
      featuredImgUrl: featuredImgUrl ?? this.featuredImgUrl,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      posts: posts ?? this.posts,
    );
  }
}
