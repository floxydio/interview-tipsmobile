import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interviewmobile/bloc/blog/blog_event.dart';
import 'package:interviewmobile/repository/data/post_repo.dart';

class BlogCubit extends Cubit<BlogEvent> {
  BlogCubit() : super(BlogLoading());

  void getPost() async {
    emit(BlogLoading());
    final fetchPost = await PostRepository().getDataPost();
    emit(BlogLoaded(fetchPost));
  }
}
