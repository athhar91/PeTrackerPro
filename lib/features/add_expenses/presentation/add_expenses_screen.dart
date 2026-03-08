import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pe_track/features/add_expenses/presentation/expenses_provider.dart';
import 'package:pe_track/features/add_expenses/domain/expense.dart';

class AddExpensesScreen extends ConsumerStatefulWidget {
  const AddExpensesScreen({super.key});

  @override
  ConsumerState<AddExpensesScreen> createState() => _AddExpensesScreenState();
}

class _AddExpensesScreenState extends ConsumerState<AddExpensesScreen> {
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedCategory = 'Food';
  String _selectedPaymentMethod = 'Cash';
  DateTime _selectedDate = DateTime.now();
  String? _editingExpenseId;

  final List<String> _categories = [
    'Food',
    'Transport',
    'Entertainment',
    'Shopping',
    'Bills',
    'Other',
  ];

  Future<void> _saveExpense() async {
    if (_amountController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter an amount')));
      return;
    }

    final expenseData = {
      'title':
          _descriptionController.text.isEmpty
              ? _selectedCategory
              : _descriptionController.text,
      'category': _selectedCategory,
      'amount': _amountController.text,
      'date': DateFormat('yyyy-MM-dd').format(_selectedDate),
      'paymentMethod': _selectedPaymentMethod,
    };

    if (_editingExpenseId != null) {
      await ref
          .read(expensesProvider.notifier)
          .editExpense(_editingExpenseId!, expenseData);
    } else {
      await ref.read(expensesProvider.notifier).addExpense(expenseData);
    }

    _amountController.clear();
    _descriptionController.clear();
    setState(() {
      _editingExpenseId = null;
      _selectedCategory = 'Food';
      _selectedPaymentMethod = 'Cash';
      _selectedDate = DateTime.now();
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _editingExpenseId != null ? 'Expense Updated ✨' : 'Expense Saved ✨',
          ),
        ),
      );
    }
  }

  void _editExpense(Expense expense) {
    setState(() {
      _editingExpenseId = expense.id;
      _amountController.text = expense.amountValue;
      _descriptionController.text = expense.titleValue;
      _selectedCategory = expense.categoryValue;
      _selectedPaymentMethod = expense.paymentMethodValue;
      try {
        _selectedDate = DateFormat('yyyy-MM-dd').parse(expense.dateValue);
      } catch (_) {
        _selectedDate = DateTime.now();
      }
    });
  }

  Future<void> _deleteExpense(Expense expense) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: const Color(0xFF1A1A1A),
            title: const Text(
              'Delete Expense',
              style: TextStyle(color: Colors.white),
            ),
            content: const Text(
              'Are you sure you want to remove this expense?',
              style: TextStyle(color: Colors.white70),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white38),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
            ],
          ),
    );

    if (confirmed == true && expense.id != null) {
      await ref.read(expensesProvider.notifier).deleteExpense(expense.id!);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Expense Deleted 🗑️')));
      }
    }
  }

  IconData _getIconForCategory(String category) {
    switch (category) {
      case 'Food':
        return LucideIcons.utensils;
      case 'Transport':
        return LucideIcons.car;
      case 'Entertainment':
        return LucideIcons.clapperboard;
      case 'Shopping':
        return LucideIcons.shoppingBag;
      case 'Bills':
        return LucideIcons.receipt;
      default:
        return LucideIcons.package;
    }
  }

  @override
  Widget build(BuildContext context) {
    final expensesAsync = ref.watch(expensesProvider);
    final isLoading = expensesAsync.isLoading;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Expense'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          if (isLoading)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.orangeAccent,
                ),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInputForm(context, isLoading),
            const SizedBox(height: 32),
            _buildRecentExpenses(context, expensesAsync),
          ],
        ),
      ),
    );
  }

  Widget _buildInputForm(BuildContext context, bool isLoading) {
    final color = Colors.orangeAccent;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withValues(alpha: 0.3)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color.withValues(alpha: 0.15), Colors.transparent],
        ),
      ),
      child: Column(
        children: [
          _buildPriceInput(context),
          const SizedBox(height: 24),
          _buildCategorySelector(context),
          const SizedBox(height: 16),
          _buildPaymentMethodSelector(context),
          const SizedBox(height: 16),
          _buildDescriptionInput(context),
          const SizedBox(height: 16),
          _buildDatePicker(context),
          const SizedBox(height: 32),
          _buildSaveButton(context, isLoading),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.1);
  }

  Widget _buildPriceInput(BuildContext context) {
    return Column(
      children: [
        const Text(
          'AMOUNT',
          style: TextStyle(
            color: Colors.white60,
            fontSize: 12,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            const Text(
              '\$',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.orangeAccent,
              ),
            ),
            const SizedBox(width: 8),
            IntrinsicWidth(
              child: TextField(
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: '0.00',
                  hintStyle: TextStyle(color: Colors.white24),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCategorySelector(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'CATEGORY',
          style: TextStyle(
            color: Colors.white60,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedCategory,
              isExpanded: true,
              dropdownColor: const Color(0xFF1A1A1A),
              items:
                  _categories.map((String category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(
                        category,
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
              onChanged: (val) => setState(() => _selectedCategory = val!),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethodSelector(BuildContext context) {
    final methods = ['Cash', 'Debit', 'Credit Card'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'PAYMENT METHOD',
          style: TextStyle(
            color: Colors.white60,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children:
              methods.map((method) {
                final isSelected = _selectedPaymentMethod == method;
                return ChoiceChip(
                  label: Text(
                    method,
                    style: TextStyle(
                      color: isSelected ? Colors.black : Colors.white60,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() => _selectedPaymentMethod = method);
                    }
                  },
                  selectedColor: Colors.orangeAccent,
                  backgroundColor: Colors.white.withValues(alpha: 0.05),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color:
                          isSelected
                              ? Colors.orangeAccent
                              : Colors.white.withValues(alpha: 0.1),
                    ),
                  ),
                  showCheckmark: false,
                );
              }).toList(),
        ),
      ],
    );
  }

  Widget _buildDescriptionInput(BuildContext context) {
    return TextField(
      controller: _descriptionController,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: 'DESCRIPTION',
        labelStyle: const TextStyle(
          color: Colors.white60,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
        prefixIcon: const Icon(
          LucideIcons.fileText,
          color: Colors.orangeAccent,
        ),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.05),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.orangeAccent),
        ),
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return InkWell(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: _selectedDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (picked != null) setState(() => _selectedDate = picked);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: Row(
          children: [
            const Icon(LucideIcons.calendar, color: Colors.orangeAccent),
            const SizedBox(width: 16),
            Text(
              DateFormat('EEEE, MMM d, yyyy').format(_selectedDate),
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context, bool isLoading) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.orangeAccent.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
          gradient: const LinearGradient(
            colors: [Colors.orangeAccent, Color(0xFFFF8C00)],
          ),
        ),
        child: ElevatedButton(
          onPressed: isLoading ? null : _saveExpense,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child:
              isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(
                    _editingExpenseId != null
                        ? 'UPDATE EXPENSE'
                        : 'SAVE EXPENSE',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
        ),
      ),
    );
  }

  Widget _buildRecentExpenses(
    BuildContext context,
    AsyncValue<List<dynamic>> expensesAsync,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Expenses',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            IconButton(
              icon: const Icon(LucideIcons.refreshCw, size: 16),
              onPressed: () => ref.invalidate(expensesProvider),
              color: Colors.white60,
            ),
          ],
        ),
        const SizedBox(height: 16),
        expensesAsync.when(
          data:
              (expenses) =>
                  expenses.isEmpty
                      ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(32),
                          child: Text(
                            'No expenses yet',
                            style: TextStyle(color: Colors.white38),
                          ),
                        ),
                      )
                      : Column(
                        children: [
                          ...expenses.reversed.map(
                            (expense) => _buildExpenseItem(expense),
                          ),
                        ],
                      ),
          loading:
              () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: CircularProgressIndicator(color: Colors.orangeAccent),
                ),
              ),
          error:
              (error, stack) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Text(
                    'Error: $error',
                    style: const TextStyle(color: Colors.redAccent),
                  ),
                ),
              ),
        ),
      ],
    ).animate().fadeIn().slideX(begin: 0.1);
  }

  Widget _buildExpenseItem(dynamic expense) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orangeAccent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              _getIconForCategory(expense.categoryValue),
              color: Colors.orangeAccent,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  expense.titleValue,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '${expense.categoryValue} • ${expense.paymentMethodValue}',
                  style: const TextStyle(color: Colors.white60, fontSize: 12),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '- \$${expense.amountValue}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                  fontSize: 16,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => _editExpense(expense),
                    icon: const Icon(LucideIcons.pencil, size: 14),
                    color: Colors.white60,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    onPressed: () => _deleteExpense(expense),
                    icon: const Icon(LucideIcons.trash2, size: 14),
                    color: Colors.redAccent.withValues(alpha: 0.6),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              Text(
                expense.dateValue,
                style: const TextStyle(color: Colors.white38, fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
