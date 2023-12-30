import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partypal/widgets/app_bar.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(delegate: SliverCustomAppBarDelegate(title: 'Reset password')),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(0.03.sw),
              child: Column(
                children: [
          
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}