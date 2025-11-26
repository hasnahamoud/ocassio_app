// lib/features/profile/presentation/views/profile_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../../login/presentation/views/log_in_view.dart';
import '../../data/data_sources/profile_remote_data_source.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';

class ProfileView extends StatelessWidget {
const ProfileView({super.key});

static const String id = 'ProfileView';

@override
Widget build(BuildContext context) {
return BlocProvider(
create: (context) => ProfileBloc(
repository: ProfileRepositoryImpl(
remoteDataSource: ProfileRemoteDataSource(client: http.Client()),
),
)..add(LoadProfile()),
child: Scaffold(
backgroundColor: const Color(0xFFEEC9C4),
appBar: AppBar(
backgroundColor: Colors.transparent,
elevation: 0,
centerTitle: true,
title: const Text(
'My profile',
style: TextStyle(
color: Colors.brown,
fontWeight: FontWeight.bold,
),
),
),
body: BlocListener<ProfileBloc, ProfileState>(
listener: (context, state) {
if (state is ProfileLoggedOut) {
Navigator.pushNamedAndRemoveUntil(context, loginView.id, (route) => false);
}
if (state is ProfileUpdatePasswordSuccess) {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(content: Text('Password updated successfully!')),
);
}
if (state is ProfileError) {
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(content: Text(state.message)),
);
}
},
child: BlocBuilder<ProfileBloc, ProfileState>(
builder: (context, state) {
if (state is ProfileLoading || state is ProfileInitial) {
return const Center(child: CircularProgressIndicator());
}
if (state is ProfileLoaded) {
return SingleChildScrollView(
child: Padding(
padding: const EdgeInsets.all(16.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.center,
children: [
const SizedBox(height: 20),
_buildProfileImage(),
const SizedBox(height: 40),
_buildInfoField(state.user.email, isEmail: true),
const SizedBox(height: 16),
_buildInfoField(state.user.name),
const SizedBox(height: 32),
_buildChangePasswordButton(context),
const SizedBox(height: 16),
_buildLogoutButton(context),
],
),
),
);
}
if (state is ProfileError) {
return Center(child: Text(state.message));
}
return Container();
},
),
),
),
);
}

Widget _buildProfileImage() {
return Container(
width: 120,
height: 120,
decoration: BoxDecoration(
shape: BoxShape.circle,
color: Colors.brown.withOpacity(0.1),
),
child: const Icon(
Icons.person,
size: 80,
color: Colors.brown,
),
);
}

Widget _buildInfoField(String text, {bool isEmail = false}) {
return Container(
padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
decoration: BoxDecoration(
color: Colors.white.withOpacity(0.5),
borderRadius: BorderRadius.circular(10),
),
child: Row(
children: [
Icon(isEmail ? Icons.email : Icons.person, color: Colors.brown),
const SizedBox(width: 10),
Expanded(
child: Text(
text,
style: const TextStyle(
fontSize: 16,
color: Colors.black,
),
overflow: TextOverflow.ellipsis,
),
),
],
),
);
}

Widget _buildChangePasswordButton(BuildContext context) {
return ElevatedButton(
onPressed: () {
_showChangePasswordDialog(context);
},
style: ElevatedButton.styleFrom(
foregroundColor: Colors.white,
backgroundColor: Colors.brown,
minimumSize: const Size(double.infinity, 50),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(10),
),
),
child: const Text('Change Password'),
);
}

void _showChangePasswordDialog(BuildContext context) {
final currentPasswordController = TextEditingController();
final newPasswordController = TextEditingController();
final formKey = GlobalKey<FormState>();

final profileBloc = BlocProvider.of<ProfileBloc>(context);

showDialog(
context: context,
builder: (context) {
return AlertDialog(
title: const Text('Change Password'),
content: Form(
key: formKey,
child: Column(
mainAxisSize: MainAxisSize.min,
children: [
TextFormField(
controller: currentPasswordController,
decoration: const InputDecoration(labelText: 'Current Password'),
obscureText: true,
validator: (value) {
if (value == null || value.isEmpty) {
return 'Please enter your current password';
}
return null;
},
),
TextFormField(
controller: newPasswordController,
decoration: const InputDecoration(labelText: 'New Password'),
obscureText: true,
validator: (value) {
if (value == null || value.isEmpty || value.length < 8) {
return 'Password must be at least 8 characters';
}
return null;
},
),
],
),
),
actions: [
TextButton(
onPressed: () => Navigator.of(context).pop(),
child: const Text('Cancel'),
),
ElevatedButton(
onPressed: () {
if (formKey.currentState!.validate()) {
profileBloc.add(
UpdatePassword(
currentPassword: currentPasswordController.text,
newPassword: newPasswordController.text,
),
);
Navigator.of(context).pop();
}
},
child: const Text('Save'),
),
],
);
},
);
}

Widget _buildLogoutButton(BuildContext context) {
return ElevatedButton(
onPressed: () {
BlocProvider.of<ProfileBloc>(context).add(Logout());
},
style: ElevatedButton.styleFrom(
foregroundColor: Colors.white,
backgroundColor: Colors.red,
minimumSize: const Size(double.infinity, 50),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(10),
),
),
child: const Text('Logout'),
);
}
}
