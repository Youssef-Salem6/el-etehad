// current_calc_view.dart

import 'package:el_etehad/features/services/manager/cubit/get_current_cubit.dart';
import 'package:el_etehad/features/services/view/components/CurrencyGridWidget.dart';
import 'package:el_etehad/features/services/view/components/currency_converter_widget.dart';
import 'package:el_etehad/features/services/view/components/shimmer_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:el_etehad/features/services/view/components/error_widget.dart'
    as custom;

class CurrentCalcView extends StatefulWidget {
  const CurrentCalcView({super.key});

  @override
  State<CurrentCalcView> createState() => _CurrentCalcViewState();
}

class _CurrentCalcViewState extends State<CurrentCalcView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    context.read<GetCurrentCubit>().getCurrent();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors:
                  isDark
                      ? [
                        const Color(0xFF000014),
                        const Color(0xFF271C2E),
                        const Color(0xFF1a1424),
                      ]
                      : [
                        const Color(0xFFF8F9FA),
                        const Color(0xFFE9ECEF),
                        const Color(0xFFFFFFFF),
                      ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: BlocConsumer<GetCurrentCubit, GetCurrentState>(
                    listener: (context, state) {
                      if (state is GetCurrentSuccess) {
                        _animationController.forward();
                      }
                    },
                    builder: (context, state) {
                      if (state is GetCurrentLoading) {
                        return const ShimmerLoadingWidget();
                      } else if (state is GetCurrentSuccess) {
                        return FadeTransition(
                          opacity: _fadeAnimation,
                          child: SlideTransition(
                            position: _slideAnimation,
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  CurrencyGridWidget(
                                    model: state.currencyModel,
                                    onCurrencyTap: (currency) {
                                      HapticFeedback.lightImpact();
                                    },
                                  ),
                                  const SizedBox(height: 32),
                                  _buildDivider(isDark),
                                  const SizedBox(height: 32),
                                  CurrencyConverterWidget(
                                    model: state.currencyModel,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      } else if (state is GetCurrentFailure) {
                        return custom.ErrorWidget(
                          error: state.error,
                          onRetry: () {
                            _animationController.reset();
                            context.read<GetCurrentCubit>().getCurrent();
                          },
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDivider(bool isDark) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  isDark
                      ? const Color(0xFF271C2E).withOpacity(0.5)
                      : const Color(0xFF0d0316).withOpacity(0.2),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF7c2a9e).withOpacity(0.2),
                  const Color(0xFF9b3ec7).withOpacity(0.2),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFFb554e8).withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.calculate_outlined,
                  color:
                      isDark
                          ? const Color(0xFFd084ff)
                          : const Color(0xFF7c2a9e),
                  size: 25,
                ),
                const SizedBox(width: 8),
                Text(
                  'الحاسبه',
                  style: TextStyle(
                    color:
                        isDark
                            ? const Color(0xFFd084ff)
                            : const Color(0xFF7c2a9e),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  isDark
                      ? const Color(0xFF271C2E).withOpacity(0.5)
                      : const Color(0xFF0d0316).withOpacity(0.2),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
