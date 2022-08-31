import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interviewmobile/bloc/blog/blog_cubit.dart';
import 'package:interviewmobile/presentasion/home_screen.dart';

void main() => runApp(MaterialApp(
        home: BlocProvider(
      create: (context) => BlogCubit(),
      child: const Homepage(),
    )));
