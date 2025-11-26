import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocassio_app/features/login/presentation/bloc/login_bloc.dart';
import 'package:ocassio_app/features/login/presentation/widgets/log_in_view_body.dart';

import '../../data/data_sources/login_remote_data_source.dart';
import '../../data/repositories/login_repository_impl.dart';
import 'package:http/http.dart' as http;

class loginView extends StatelessWidget {
  const loginView({super.key});
  static String id = 'loginView';



  @override
  Widget build(BuildContext context) {
    final loginRepository = LoginRepositoryImpl(
      remoteDataSource: LoginRemoteDataSource(
        client: http.Client(),
      ),
    );

    return BlocProvider(
      create: (_)=>LoginBloc(loginRepository: loginRepository),
      child: Scaffold(
        body:LoginViewBody(),


      ),
    );

  }
}
