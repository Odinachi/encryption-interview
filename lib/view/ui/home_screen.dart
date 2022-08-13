import 'package:apex/res/assets.dart';
import 'package:apex/res/colors.dart';
import 'package:apex/view_model/blocs/dashboard_bloc/dashboard_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardBloc()..add(FetchDashBoard()),
      child: const _HomeScreen(),
    );
  }
}

class _HomeScreen extends StatelessWidget {
  const _HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is DashboardFailed) {
            return Center(
              child: Text(
                state.error,
                textAlign: TextAlign.center,
                style: AppAssets.appTextStyle.copyWith(
                  color: AppColors.appDarkColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            );
          }
          if (state is DashboardSuccess) {
            return Center(
              child: Text(
                state.message,
                textAlign: TextAlign.center,
                style: AppAssets.appTextStyle.copyWith(
                  color: AppColors.appDarkColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            );
          }
          return const Center(
            child: Text(""),
          );
        },
      ),
    );
  }
}
