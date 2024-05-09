import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/core/extension/build_context_extensions.dart';
import 'package:leaf_lore_flutter/shared/presentation/error_snack_bar.dart';

class StreamHandler<T> extends StatefulWidget {
  final Stream<T> stream;
  final AsyncWidgetBuilder<T> builder;
  final Widget? empty;
  final Widget? error;

  const StreamHandler(
      {super.key, required this.stream, required this.builder, this.empty, this.error});

  @override
  State<StreamHandler<T>> createState() => _StreamHandlerState<T>();
}

class _StreamHandlerState<T> extends State<StreamHandler<T>> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: widget.stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(
              context.loc.streamHandler_errorMessage,
            ));
          });
          debugPrintStack(stackTrace: snapshot.stackTrace);
          return widget.error ?? Text(context.loc.streamHandler_errorMessage);
        } else if (!snapshot.hasData) {
          return widget.empty ?? Text(context.loc.streamHandler_noDataFound);
        } else if (snapshot.data is List && (snapshot.data as List).isEmpty) {
          return widget.empty ?? Text(context.loc.streamHandler_noDataFound);
        } else if (snapshot.data == null) {
          return widget.empty ?? Text(context.loc.streamHandler_noDataFound);
        } else {
          return widget.builder(context, snapshot);
        }
      },
    );
  }
}
