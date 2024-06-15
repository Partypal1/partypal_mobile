import 'package:flutter/material.dart';
import 'package:partypal/models/event_model.dart';
import 'package:partypal/widgets/app_bars/app_bar.dart';
import 'package:partypal/widgets/cards/ticket_card.dart';

class TicketScreen extends StatefulWidget {
  final Event event;
  const TicketScreen({
    required this.event,
    super.key});

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: CustomSliverAppBar(title: 'Ticket'),
            pinned: true,
          ),

          SliverToBoxAdapter(
            child: TicketCard(event: widget.event),
          )
        ],
      ),
    );
  }
}