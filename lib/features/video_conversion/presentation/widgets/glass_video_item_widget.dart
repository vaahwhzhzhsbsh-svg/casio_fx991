import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/video_entity.dart';

class GlassVideoItemWidget extends StatefulWidget {
  final VideoEntity video;
  final VoidCallback onDelete;
  final Function(String) onRename;
  final int index;

  const GlassVideoItemWidget({
    Key? key,
    required this.video,
    required this.onDelete,
    required this.onRename,
    required this.index,
  }) : super(key: key);

  @override
  State<GlassVideoItemWidget> createState() => _GlassVideoItemWidgetState();
}

class _GlassVideoItemWidgetState extends State<GlassVideoItemWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  bool _isRenaming = false;
  late TextEditingController _renameController;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _renameController = TextEditingController(text: widget.video.name);
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _renameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _scaleController.forward(),
      onTapUp: (_) => _scaleController.reverse(),
      onTapCancel: () => _scaleController.reverse(),
      child: ScaleTransition(
        scale: Tween<double>(begin: 1.0, end: 0.95).animate(
          CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFF00d9ff).withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: ui.BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFF1a1f3a).withOpacity(0.4),
                      const Color(0xFF0a0e27).withOpacity(0.2),
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header: Index + Status
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF00d9ff).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color(0xFF00d9ff).withOpacity(0.5),
                            ),
                          ),
                          child: Text(
                            '#${widget.index + 1}',
                            style: GoogleFonts.elMessiri(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF00d9ff),
                            ),
                          ),
                        ),
                        _buildStatusBadge(),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Filename / Rename TextField
                    if (_isRenaming)
                      TextField(
                        controller: _renameController,
                        maxLines: 1,
                        style: GoogleFonts.elMessiri(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Enter new name',
                          hintStyle: GoogleFonts.elMessiri(
                            color: Colors.white38,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xFF00d9ff),
                              width: 1.5,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xFF00d9ff),
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xFF00d9ff),
                              width: 2,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.check,
                              color: Color(0xFF00d9ff),
                            ),
                            onPressed: () {
                              widget.onRename(_renameController.text);
                              setState(() => _isRenaming = false);
                            },
                          ),
                        ),
                      )
                    else
                      Text(
                        widget.video.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.elMessiri(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    const SizedBox(height: 8),
                    // File Size
                    Text(
                      'Size: ${_formatBytes(widget.video.fileSize)}',
                      style: GoogleFonts.elMessiri(
                        fontSize: 12,
                        color: Colors.white60,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Progress Bar
                    if (widget.video.status == ConversionStatus.converting)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: widget.video.progress,
                              minHeight: 6,
                              backgroundColor: Colors.white12,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                _getStatusColor(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '${(widget.video.progress * 100).toStringAsFixed(1)}%',
                            style: GoogleFonts.elMessiri(
                              fontSize: 11,
                              color: Colors.white54,
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 12),
                    // Action Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: widget.video.status == ConversionStatus.pending
                                ? () => setState(() => _isRenaming = !_isRenaming)
                                : null,
                            icon: const Icon(Icons.edit, size: 16),
                            label: Text(
                              'Rename',
                              style: GoogleFonts.elMessiri(fontSize: 12),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF00d9ff).withOpacity(0.2),
                              foregroundColor: const Color(0xFF00d9ff),
                              disabledBackgroundColor: Colors.grey.withOpacity(0.2),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: widget.onDelete,
                            icon: const Icon(Icons.delete, size: 16),
                            label: Text(
                              'Remove',
                              style: GoogleFonts.elMessiri(fontSize: 12),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFb026ff).withOpacity(0.2),
                              foregroundColor: const Color(0xFFb026ff),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge() {
    final status = widget.video.status;
    Color bgColor;
    Color textColor;
    String label;

    switch (status) {
      case ConversionStatus.pending:
        bgColor = Colors.blue.withOpacity(0.2);
        textColor = Colors.blue;
        label = 'Pending';
      case ConversionStatus.converting:
        bgColor = const Color(0xFF00d9ff).withOpacity(0.2);
        textColor = const Color(0xFF00d9ff);
        label = 'Converting';
      case ConversionStatus.completed:
        bgColor = Colors.green.withOpacity(0.2);
        textColor = Colors.green;
        label = 'Done';
      case ConversionStatus.failed:
        bgColor = Colors.red.withOpacity(0.2);
        textColor = Colors.red;
        label = 'Failed';
      case ConversionStatus.cancelled:
        bgColor = Colors.orange.withOpacity(0.2);
        textColor = Colors.orange;
        label = 'Cancelled';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: textColor.withOpacity(0.5)),
      ),
      child: Text(
        label,
        style: GoogleFonts.elMessiri(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }

  Color _getStatusColor() {
    switch (widget.video.status) {
      case ConversionStatus.converting:
        return const Color(0xFF00d9ff);
      case ConversionStatus.completed:
        return Colors.green;
      case ConversionStatus.failed:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}
