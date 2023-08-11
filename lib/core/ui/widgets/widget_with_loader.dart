import 'package:auth_module/core/ui/widgets/app_bar/api_loader_screen.dart';
import 'package:auth_module/core/utlis/mixins/notifier_mixin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetWithLoader<T extends ChangeNotifierState> extends StatelessWidget {
  final Widget child;

  const WidgetWithLoader({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Selector<T, bool>(
          builder: (_, isLoading, child) => Visibility(
            visible: isLoading,
            child: const ApiLoaderScreen(),
          ),
          selector: (_, model) => model.state == AppState.loading,
        ),
      ],
    );
  }
}
