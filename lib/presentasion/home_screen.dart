import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/blog/blog_cubit.dart';
import '../bloc/blog/blog_event.dart';
class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    calPostApi();
  }

  void calPostApi() => context.read<BlogCubit>().getPost();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: BlocBuilder<BlogCubit, BlogEvent>(
        builder: (context, state) {
          if (state is BlogLoaded) {
            return ListView.builder(
                itemCount: state.postModel.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Card(
                        child: Text(state.postModel[index].body.toString())),
                  );
                });
          } else if (state is BlogLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const SizedBox();
          }
        },
      )),
    );
  }
}
