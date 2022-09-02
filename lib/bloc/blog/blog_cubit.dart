import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interviewmobile/bloc/blog/blog_event.dart';
import 'package:interviewmobile/repository/data/post_repo.dart';
import 'package:interviewmobile/repository/models/post_model.dart';

class BlogCubit extends Cubit<BlogEvent> {
  BlogCubit() : super(BlogLoading());

  void getPost() async {
    emit(BlogLoading());
    final fetchPost = await PostRepository().getDataPost();
    emit(BlogLoaded(fetchPost));
  }

  void createPost(PostModel formPost, VoidCallback onSuccess) async {
    final fetchRegisterPost = await PostRepository().createPost(formPost);

    if (fetchRegisterPost.statusCode == 200 ||
        fetchRegisterPost.statusCode == 201) {
      onSuccess();
      getPost();
    }
  }

  void deletePost(int? id, VoidCallback onSuccess) async {
    final fetchDelete = await PostRepository().deletePost(id);

    if (fetchDelete.statusCode != 200) {
      onSuccess();
      getPost();
    }
  }
}
