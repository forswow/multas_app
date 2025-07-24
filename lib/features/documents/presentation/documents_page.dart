import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multas_app/features/documents/presentation/widgets/add_task_form.dart';
import 'package:multas_app/features/documents/presentation/widgets/task_list_item.dart';
import 'package:multas_app/features/documents/providers/task_providers.dart';

class DocumentsView extends ConsumerWidget {
  const DocumentsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(tasksNotifierProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF121212) : const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'Documentos',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        foregroundColor: isDark ? Colors.white : Colors.black87,
        elevation: 0,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: isDark
            ? const SystemUiOverlayStyle(
                statusBarBrightness: Brightness.dark,
                statusBarIconBrightness: Brightness.light,
              )
            : const SystemUiOverlayStyle(
                statusBarBrightness: Brightness.light,
                statusBarIconBrightness: Brightness.dark,
              ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header section with gradient
            SliverToBoxAdapter(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isDark
                        ? [
                            const Color(0xFF1E1E1E),
                            const Color(0xFF2A2A2A),
                          ]
                        : [
                            Colors.white,
                            const Color(0xFFF8F9FA),
                          ],
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.blue.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.description_outlined,
                              color: Colors.blue,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Gestiona tus documentos',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        isDark ? Colors.white : Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Mantén actualizados los datos de tu vehículo',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: isDark
                                        ? Colors.grey[400]
                                        : Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Add form section
            const SliverToBoxAdapter(
              child: AddTaskForm(),
            ),

            // Documents list header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
                child: Row(
                  children: [
                    Text(
                      'Mis documentos',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const Spacer(),
                    tasksAsync.when(
                      data: (tasks) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${tasks.length}',
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      loading: () => const SizedBox.shrink(),
                      error: (_, __) => const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            ),

            // Documents list
            tasksAsync.when(
              data: (tasks) {
                if (tasks.isEmpty) {
                  return SliverFillRemaining(
                    child: _buildEmptyState(isDark),
                  );
                }
                return SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: TaskListItem(task: tasks[index]),
                      ),
                      childCount: tasks.length,
                    ),
                  ),
                );
              },
              loading: () => const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (error, _) => SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red.withValues(alpha: 0.6),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Error al cargar documentos',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        error.toString(),
                        style: TextStyle(
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom padding
            const SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(bool isDark) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.description_outlined,
                size: 64,
                color: Colors.grey.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No tienes documentos',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Agrega tu primer documento usando\nel formulario de arriba',
              style: TextStyle(
                fontSize: 16,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.arrow_upward,
                    color: Colors.blue,
                    size: 16,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Comienza aquí',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
