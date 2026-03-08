import 'package:go_router/go_router.dart';
import 'package:pe_track/features/auth/presentation/login_screen.dart';
import 'package:pe_track/features/auth/presentation/register_screen.dart';
import 'package:pe_track/features/auth/presentation/onboarding_screen.dart';
import 'package:pe_track/features/add_expenses/presentation/add_expenses_screen.dart';
import 'package:pe_track/features/workout/presentation/workout_history_screen.dart';
import 'package:pe_track/features/health/presentation/health_dashboard_screen.dart';
import 'package:pe_track/features/dashboard/presentation/dashboard_screen.dart';
import 'package:pe_track/features/admin/presentation/admin_panel_screen.dart';
import 'package:pe_track/features/budget/presentation/budget_screen.dart';
import 'package:pe_track/features/savings/presentation/savings_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(path: '/', builder: (context, state) => const DashboardScreen()),
    GoRoute(
      path: '/add_expenses',
      builder: (context, state) => const AddExpensesScreen(),
    ),
    GoRoute(path: '/budget', builder: (context, state) => const BudgetScreen()),
    GoRoute(
      path: '/savings',
      builder: (context, state) => const SavingsScreen(),
    ),
    GoRoute(
      path: '/workouts',
      builder: (context, state) => const WorkoutHistoryScreen(),
    ),
    GoRoute(
      path: '/health',
      builder: (context, state) => const HealthDashboardScreen(),
    ),
    GoRoute(
      path: '/admin',
      builder: (context, state) => const AdminPanelScreen(),
    ),
  ],
);
