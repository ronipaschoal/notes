import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/cubit/connection/connection_cubit.dart';

class ConnectionStatusBar extends StatelessWidget {
  const ConnectionStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppConnectionCubit, AppConnectionState>(
      builder: (_, state) => state is ConnectionOfflineState
          ? Container(
              width: double.infinity,
              color: Colors.blue.shade100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Colors.blue.shade900,
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    'Verifique sua conexão com a internet',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
