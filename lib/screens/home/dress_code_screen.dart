import 'package:flutter/material.dart';
import 'package:partypal/models/event_model.dart';
import 'package:partypal/widgets/app_bars/app_bar.dart';

class DressCodeScreen extends StatefulWidget {
  final Event event;
  const DressCodeScreen({
    required this.event,
    super.key});

  @override
  State<DressCodeScreen> createState() => _DressCodeScreenState();
}

class _DressCodeScreenState extends State<DressCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: CustomSliverAppBar(title: 'Dress code'),
            pinned: true,
          )
        ],
      ),
    );
  }
}