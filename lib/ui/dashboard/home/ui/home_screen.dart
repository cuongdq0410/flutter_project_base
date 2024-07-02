import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_base/generated/l10n.dart';
import 'package:flutter_bloc_base/ui/chat/ui/chat_screen.dart';
import 'package:flutter_bloc_base/ui/widget/route_define.dart';
import 'package:go_router/go_router.dart';

import '../../../app/bloc/app_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                    context.pushNamed(
                      RouteDefine.chatScreen.name,
                      pathParameters: {
                        "id": "1",
                        "chatName": "Chat name",
                      },
                      extra: ChatScreenArgs(
                        chatId: 'Extra id 1',
                        chatName: 'Extra chat name 1',
                      ),
                    );
                  },
                  child: const Text('Push Chat'),
                ),
                TextButton(
                  onPressed: () {
                    context.go('/${RouteDefine.homeScreen.name}/details');
                  },
                  child: const Text('Nest Navigation'),
                ),
                TextButton(
                  onPressed: () {
                    context.push('/parent-page');
                  },
                  child: const Text('Push to Parent Page'),
                ),
                Text(S.of(context).change_language),
                const SizedBox(height: 8),
                BlocBuilder<AppBloc, AppState>(
                  builder: (context, state) {
                    return DropdownButtonFormField<Locale>(
                      value: state.locale,
                      onChanged: (Locale? newValue) {
                        if (newValue == null) return;
                        context.read<AppBloc>().add(
                              AppEvent.changeLanguage(newValue),
                            );
                      },
                      items: context
                          .read<AppBloc>()
                          .supportedLanguages
                          .map<DropdownMenuItem<Locale>>((Locale value) {
                        return DropdownMenuItem<Locale>(
                          value: value,
                          child: Text(
                            context
                                .read<AppBloc>()
                                .getLanguageName(context, value),
                          ),
                        );
                      }).toList(),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
