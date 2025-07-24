import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:multas_app/features/documents/domain/entities/task.dart';

class VehicleCard extends ConsumerStatefulWidget {
  const VehicleCard({required this.task, super.key});
  final Task task;

  @override
  ConsumerState<VehicleCard> createState() => _VehicleCardState();
}

class _VehicleCardState extends ConsumerState<VehicleCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.98,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.02,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) => Transform.scale(
        scale: _scaleAnimation.value,
        child: Transform.rotate(
          angle: _rotationAnimation.value,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
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
                        const Color(0xFFFAFAFA),
                      ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: widget.task.isChecked
                    ? Colors.green.withValues(alpha: 0.3)
                    : Colors.orange.withValues(alpha: 0.3),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? Colors.black.withValues(alpha: 0.4)
                      : Colors.grey.withValues(alpha: 0.15),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTapDown: (_) => _animationController.forward(),
                onTapUp: (_) => _animationController.reverse(),
                onTapCancel: () => _animationController.reverse(),
                onTap: () => context.push('/consulta'),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      // Vehicle icon with status indicator
                      Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.blue.withValues(alpha: 0.1),
                                  Colors.blue.withValues(alpha: 0.2),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.blue.withValues(alpha: 0.2),
                              ),
                            ),
                            child: const Icon(
                              Icons.directions_car,
                              color: Colors.blue,
                              size: 32,
                            ),
                          ),
                          // Status indicator
                          Positioned(
                            right: -2,
                            top: -2,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: widget.task.isChecked
                                    ? Colors.green
                                    : Colors.orange,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isDark
                                      ? const Color(0xFF1E1E1E)
                                      : Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: Icon(
                                widget.task.isChecked
                                    ? Icons.check
                                    : Icons.schedule,
                                color: Colors.white,
                                size: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 20),

                      // Vehicle info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.task.title,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: isDark
                                          ? Colors.white
                                          : Colors.black87,
                                      letterSpacing: 0.5,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Colors.blue.withValues(alpha: 0.2),
                                    ),
                                  ),
                                  child: Text(
                                    widget.task.description,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.blue,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

                            // Status row
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: widget.task.isChecked
                                        ? Colors.green.withValues(alpha: 0.1)
                                        : Colors.orange.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: widget.task.isChecked
                                          ? Colors.green.withValues(alpha: 0.3)
                                          : Colors.orange
                                              .withValues(alpha: 0.3),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        widget.task.isChecked
                                            ? Icons.verified
                                            : Icons.warning,
                                        color: widget.task.isChecked
                                            ? Colors.green
                                            : Colors.orange,
                                        size: 14,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        widget.task.isChecked
                                            ? 'Válido'
                                            : 'Pendiente',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: widget.task.isChecked
                                              ? Colors.green
                                              : Colors.orange,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  'Toca para consultar',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isDark
                                        ? Colors.grey[400]
                                        : Colors.grey[500],
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Arrow indicator
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.blue,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
