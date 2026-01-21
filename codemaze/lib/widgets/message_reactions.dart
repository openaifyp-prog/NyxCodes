import 'package:flutter/material.dart';

typedef ReactionCallback = void Function(int messageIndex, String reaction);

class ReactionPicker extends StatelessWidget {
  final ReactionCallback onReactionSelected;

  const ReactionPicker({Key? key, required this.onReactionSelected}) : super(key: key);

  final List<String> _reactions = const ['👍', '❤️', '😂', '😮', '😢', '👎'];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: _reactions
          .map(
            (reaction) => GestureDetector(
          onTap: () {
            onReactionSelected(_reactions.indexOf(reaction), reaction);
            Navigator.pop(context);
          },
          child: Text(
            reaction,
            style: const TextStyle(fontSize: 28),
          ),
        ),
      )
          .toList(),
    );
  }
}
