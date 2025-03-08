import 'package:flutter/material.dart';

class FeedbackWidget extends StatefulWidget {
  const FeedbackWidget({super.key});

  @override
  State<FeedbackWidget> createState() => _FeedbackWidgetState();
}

class _FeedbackWidgetState extends State<FeedbackWidget> {
  bool _isVisible = true;
  bool? _feedbackGiven; // true para gostei, false para não gostei

  void _giveFeedback(bool liked) {
    setState(() {
      _feedbackGiven = liked;
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isVisible = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) return const SizedBox.shrink();

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? Colors.grey[800]! : Colors.grey[100]!;
    final textColor = Theme.of(context).colorScheme.onSurface;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity:
            _feedbackGiven == null
                ? 1.0
                : 0.5, // Reduz opacidade ao dar feedback
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  _feedbackGiven == null
                      ? "O que achou dessas recomendações?"
                      : "Obrigado pelo feedback!",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      _feedbackGiven == true
                          ? Icons.thumb_up
                          : Icons.thumb_up_outlined,
                      color: Colors.green,
                    ),
                    onPressed:
                        _feedbackGiven == null
                            ? () => _giveFeedback(true)
                            : null,
                  ),
                  IconButton(
                    icon: Icon(
                      _feedbackGiven == false
                          ? Icons.thumb_down
                          : Icons.thumb_down_outlined,
                      color: Colors.red.shade400,
                    ),
                    onPressed:
                        _feedbackGiven == null
                            ? () => _giveFeedback(false)
                            : null,
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: textColor),
                    onPressed: () => setState(() => _isVisible = false),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
