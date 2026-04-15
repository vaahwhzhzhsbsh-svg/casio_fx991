import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/conversion_providers.dart';
import '../widgets/animated_header_widget.dart';
import '../widgets/glass_video_item_widget.dart';
import '../../data/models/video_model.dart';
import '../../domain/entities/video_entity.dart';
import '../../../core/constants/app_constants.dart';

class ConverterPage extends ConsumerStatefulWidget {
  const ConverterPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConverterPage> createState() => _ConverterPageState();
}

class _ConverterPageState extends ConsumerState<ConverterPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _fabController;

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fabController.forward();
  }

  @override
  void dispose() {
    _fabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final queue = ref.watch(videoQueueProvider);
    final queueState = ref.watch(conversionQueueProvider);
    final activeConversions = ref.watch(activeConversionsProvider);

    final completedCount = queue.where(
      (v) => v.status == ConversionStatus.completed,
    ).length;

    return Scaffold(
      backgroundColor: const Color(0xFF0a0e27),
      body: CustomScrollView(
        slivers: [
          // Sticky Header
          SliverAppBar(
            expandedHeight: 280,
            floating: true,
            pinned: true,
            backgroundColor: const Color(0xFF0a0e27),
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const AnimatedHeaderWidget(),
                  // Stats Bar
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF00d9ff).withOpacity(0.1),
                          const Color(0xFFb026ff).withOpacity(0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFF00d9ff).withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatCard('Queue', queue.length.toString()),
                        _buildStatCard(
                          'Converting',
                          activeConversions.length.toString(),
                        ),
                        _buildStatCard('Done', completedCount.toString()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Video List
          if (queue.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.video_library_outlined,
                      size: 80,
                      color: const Color(0xFF00d9ff).withOpacity(0.3),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'No videos selected',
                      style: GoogleFonts.elMessiri(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white60,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tap the + button to add videos',
                      style: GoogleFonts.elMessiri(
                        fontSize: 14,
                        color: Colors.white38,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final video = queue[index];
                  return GlassVideoItemWidget(
                    video: video,
                    index: index,
                    onDelete: () {
                      HapticFeedback.mediumImpact();
                      ref
                          .read(videoQueueProvider.notifier)
                          .removeVideo(video.id);
                    },
                    onRename: (newName) {
                      HapticFeedback.lightImpact();
                      final updated = video.copyWith(name: newName);
                      ref.read(videoQueueProvider.notifier).updateVideo(updated);
                    },
                  );
                },
                childCount: queue.length,
              ),
            ),
          // Bottom Spacing
          const SliverToBoxAdapter(
            child: SizedBox(height: 100),
          ),
        ],
      ),
      // Bottom Control Panel
      bottomSheet: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1a1f3a),
          border: Border(
            top: BorderSide(
              color: const Color(0xFF00d9ff).withOpacity(0.3),
              width: 1.5,
            ),
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Overall Progress
              if (queueState.isRunning || completedCount > 0)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Overall Progress',
                          style: GoogleFonts.elMessiri(
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                        ),
                        Text(
                          '${(queueState.totalProgress * 100).toStringAsFixed(0)}%',
                          style: GoogleFonts.elMessiri(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF00d9ff),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: queueState.totalProgress,
                        minHeight: 8,
                        backgroundColor: Colors.white12,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF00d9ff),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: queueState.isRunning
                          ? () {
                              HapticFeedback.mediumImpact();
                              ref
                                  .read(conversionQueueProvider.notifier)
                                  .pauseQueue();
                            }
                          : null,
                      icon: const Icon(Icons.pause),
                      label: Text(
                        'Pause',
                        style: GoogleFonts.elMessiri(fontSize: 14),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00d9ff).withOpacity(0.2),
                        foregroundColor: const Color(0xFF00d9ff),
                        disabledBackgroundColor: Colors.grey.withOpacity(0.1),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: queueState.isRunning
                          ? null
                          : () {
                              HapticFeedback.mediumImpact();
                              if (queue.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('Add videos first'),
                                ));
                                return;
                              }
                              ref
                                  .read(conversionQueueProvider.notifier)
                                  .startQueue();
                            },
                      icon: Icon(
                        queueState.isRunning ? Icons.play_arrow : Icons.play_arrow,
                      ),
                      label: Text(
                        queueState.isRunning ? 'Running...' : 'Start',
                        style: GoogleFonts.elMessiri(fontSize: 14),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFb026ff).withOpacity(0.2),
                        foregroundColor: const Color(0xFFb026ff),
                        disabledBackgroundColor: Colors.grey.withOpacity(0.1),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      // Floating Action Buttons
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'clear',
            tooltip: 'Clear Completed',
            backgroundColor: const Color(0xFFb026ff),
            onPressed: () {
              HapticFeedback.mediumImpact();
              ref.read(videoQueueProvider.notifier).clearCompleted();
            },
            child: const Icon(Icons.clear_all),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            heroTag: 'add',
            tooltip: 'Add Videos',
            backgroundColor: const Color(0xFF00d9ff),
            onPressed: () {
              HapticFeedback.mediumImpact();
              _showAddVideoOptions(context, ref);
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  void _showAddVideoOptions(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1a1f3a),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.video_library, color: Color(0xFF00d9ff)),
              title: Text(
                'Pick Multiple Videos',
                style: GoogleFonts.elMessiri(fontSize: 14),
              ),
              onTap: () async {
                Navigator.pop(context);
                // TODO: Implement file picker integration
              },
            ),
            ListTile(
              leading: const Icon(Icons.clear_all, color: Color(0xFFb026ff)),
              title: Text(
                'Clear All',
                style: GoogleFonts.elMessiri(fontSize: 14),
              ),
              onTap: () {
                Navigator.pop(context);
                HapticFeedback.mediumImpact();
                ref.read(videoQueueProvider.notifier).clearAll();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.elMessiri(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF00d9ff),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.elMessiri(
            fontSize: 11,
            color: Colors.white54,
          ),
        ),
      ],
    );
  }
}
