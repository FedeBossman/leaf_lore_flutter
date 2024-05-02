import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/core/extension/build_context_extensions.dart';

class StreamHandler<T> extends StatelessWidget {
  final Stream<T> stream;
  final AsyncWidgetBuilder<T> builder;

  const StreamHandler({super.key, required this.stream, required this.builder});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (!snapshot.hasData) {

          if (snapshot.hasError) {
            print(snapshot.stackTrace);
          }
          // TODO: text should be dynamic
          return Text(context.loc.streamHandler_noDataFound);
        } else {
          return builder(context, snapshot);
        }
      },
    );
  }
}
