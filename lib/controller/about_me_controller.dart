import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:neat_nest/screens/user/notifiers/about_me_controller_state.dart';
import 'package:neat_nest/utilities/route/app_naviation_helper.dart';
import 'package:neat_nest/utilities/route/app_route_names.dart';
import 'package:neat_nest/widget/notificaiton_content.dart';

import '../widget/loading_screen.dart';

class AboutMeController {
  AboutMeController();

  TextEditingController aboutMeController = TextEditingController();

  Future<void> postAboutMe(
    BuildContext context,
    WidgetRef ref, {
    String? aboutMe,
  }) async {
    final myText = aboutMeController.text.trim();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          insetPadding: EdgeInsets.zero,
          child: LoadingScreen(),
        );
      },
    );
    try {
      await ref
          .read(aboutMeControllerStateProvider.notifier)
          .postAboutMe(myText);
      if (!context.mounted) return;
      AppNavigatorHelper.go(context, AppRoute.viewAboutMeScreen);
    } catch (e) {
      if (!context.mounted) return;
      context.pop();
      if (e is DioException) {
        showErrorNotification(message: e.error.toString());
      }
    }
  }

  Future<void> updateAboutMe(
    BuildContext context,
    WidgetRef ref, {
    String? aboutMe,
  }) async {
    final myText = aboutMeController.text.trim();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          insetPadding: EdgeInsets.zero,
          child: LoadingScreen(),
        );
      },
    );
    try {
      await ref
          .read(aboutMeControllerStateProvider.notifier)
          .postAboutMe(myText);
      if (!context.mounted) return;
      AppNavigatorHelper.go(context, AppRoute.viewAboutMeScreen);
    } catch (e) {
      if (!context.mounted) return;
      context.pop();
      if (e is DioException) {
        showErrorNotification(message: e.error.toString());
      }
    }
  }

  Future<void> getAboutMe(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(aboutMeControllerStateProvider.notifier).getAboutMe();
    } catch (e) {
      if (!context.mounted) return;
      if (e is DioException) {
        showErrorNotification(message: e.error.toString());
        context.pop();
      }
    }
  }

  Future<void> deleteAboutMe(BuildContext context, WidgetRef ref) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          insetPadding: EdgeInsets.zero,
          child: LoadingScreen(),
        );
      },
    );
    try {
      await ref.read(aboutMeControllerStateProvider.notifier).deleteAboutMe();
      if (!context.mounted) return;
      context.pop();
      showSuccessNotification(message: "About me Successfully deleted");
    } catch (e) {
      if (!context.mounted) return;
      context.pop();
      if (e is DioException) {
        showErrorNotification(message: e.error.toString());
      }
    }
  }
}
