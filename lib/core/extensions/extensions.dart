extension StringExtension on String {
  String get toFileName {
    final parts = split('.');
    if (parts.length > 1) {
      parts.removeLast();
      return parts.join('.');
    }
    return this;
  }

  String get toFileExtension {
    final parts = split('.');
    return parts.isNotEmpty ? parts.last : '';
  }

  String formatAsSize() {
    final bytes = int.tryParse(this) ?? 0;
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
}

extension DurationExtension on Duration {
  String get formatted {
    final hours = inHours;
    final minutes = inMinutes % 60;
    final seconds = inSeconds % 60;
    
    if (hours > 0) {
      return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}

extension DateTimeExtension on DateTime {
  String get relativeTime {
    final now = DateTime.now();
    final difference = now.difference(this);
    
    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    }
    return 'Long ago';
  }
}
