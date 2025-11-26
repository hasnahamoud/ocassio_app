import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../data/data_sources/sign_up_remote_data_source.dart';
import '../../data/repositories/sign_up_repository_impl.dart';

import '../bloc/sign_up_bloc.dart';
import '../widgets/sign_view_body.dart';

class signView extends StatelessWidget {
  const signView({super.key});
  static String id = 'signView';

  @override
  Widget build(BuildContext context) {
    final signUpRepository = SignUpRepositoryImpl(
      remoteDataSource: SignUpRemoteDataSource(
        client: http.Client(),
      ),
    );

    return BlocProvider(
      create: (_) => SignUpBloc(signUpRepository: signUpRepository),
      child: Scaffold(
        body: signViewBody(),
      ),
    );
  }
}

