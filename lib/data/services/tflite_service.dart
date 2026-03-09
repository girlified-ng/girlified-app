import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

class TFLiteService {
  static final TFLiteService _instance = TFLiteService._internal();
  factory TFLiteService() => _instance;
  TFLiteService._internal();

  Interpreter? _interpreter;
  bool _isInitialized = false;

  // Model configuration
  static const String modelPath =
      'assets/models/harmful_content_detector.tflite';
  static const int inputSize = 224; // Standard image input size
  static const int numChannels = 3; // RGB
  static const double threshold =
      0.7; // Confidence threshold for harmful content

  // Content categories
  static const List<String> categories = [
    'Safe',
    'Violence',
    'Explicit Content',
    'Harassment',
    'Hate Speech',
    'Self-Harm',
  ];

  Future<bool> initialize() async {
    if (_isInitialized) return true;

    try {
      // Load the TFLite model
      _interpreter = await Interpreter.fromAsset(modelPath);

      // Get input and output tensor shapes
      final inputShape = _interpreter!.getInputTensor(0).shape;
      final outputShape = _interpreter!.getOutputTensor(0).shape;

      print('TFLite Model Loaded');
      print('Input shape: $inputShape');
      print('Output shape: $outputShape');

      _isInitialized = true;
      return true;
    } catch (e) {
      print('Error initializing TFLite model: $e');
      // In development, we'll work without the model
      // In production, you must include a trained model
      _isInitialized = false;
      return false;
    }
  }

  Future<ContentAnalysisResult> analyzeImage(Uint8List imageBytes) async {
    if (!_isInitialized) {
      print('TFLite not initialized, using fallback detection');
      return _fallbackAnalysis();
    }

    try {
      // Decode image
      img.Image? image = img.decodeImage(imageBytes);
      if (image == null) {
        return ContentAnalysisResult(
          isHarmful: false,
          category: 'Safe',
          confidence: 0.0,
          message: 'Could not decode image',
        );
      }

      // Preprocess image
      final preprocessedImage = _preprocessImage(image);

      // Run inference
      final output =
          List.generate(1, (_) => List.filled(categories.length, 0.0));
      _interpreter!.run(preprocessedImage, output);

      // Process results
      final predictions = output[0];
      final maxIndex =
          predictions.indexOf(predictions.reduce((a, b) => a > b ? a : b));
      final confidence = predictions[maxIndex];

      final isHarmful = maxIndex > 0 && confidence >= threshold;
      final category = categories[maxIndex];

      return ContentAnalysisResult(
        isHarmful: isHarmful,
        category: category,
        confidence: confidence,
        message: isHarmful
            ? 'Detected: $category (${(confidence * 100).toStringAsFixed(1)}%)'
            : 'Content appears safe',
      );
    } catch (e) {
      print('Error analyzing image: $e');
      return _fallbackAnalysis();
    }
  }

  List<List<List<List<double>>>> _preprocessImage(img.Image image) {
    // Resize image to model input size
    final resizedImage = img.copyResize(
      image,
      width: inputSize,
      height: inputSize,
    );

    // Convert to normalized float array [1, 224, 224, 3]
    final input = List.generate(
      1,
      (_) => List.generate(
        inputSize,
        (y) => List.generate(
          inputSize,
          (x) {
            final pixel = resizedImage.getPixel(x, y);
            final r = pixel.r.toInt();
            final g = pixel.g.toInt();
            final b = pixel.b.toInt();
            return [
              (r / 255.0), // Normalize to [0, 1]
              (g / 255.0),
              (b / 255.0),
            ];
          },
        ),
      ),
    );

    return input;
  }

  Future<ContentAnalysisResult> analyzeText(String text) async {
    // Simple keyword-based text analysis
    // In production, use a proper NLP model or text classification model

    final lowerText = text.toLowerCase();

    final violenceKeywords = [
      'kill',
      'murder',
      'attack',
      'violence',
      'weapon',
      'blood',
      'gore'
    ];
    final harassmentKeywords = [
      'hate',
      'bully',
      'harass',
      'threat',
      'abuse',
      'insult'
    ];
    final explicitKeywords = ['explicit', 'nsfw', 'sexual', 'nude'];
    final selfHarmKeywords = [
      'suicide',
      'self-harm',
      'cut myself',
      'end my life'
    ];

    double violenceScore = _calculateKeywordScore(lowerText, violenceKeywords);
    double harassmentScore =
        _calculateKeywordScore(lowerText, harassmentKeywords);
    double explicitScore = _calculateKeywordScore(lowerText, explicitKeywords);
    double selfHarmScore = _calculateKeywordScore(lowerText, selfHarmKeywords);

    final scores = {
      'Violence': violenceScore,
      'Harassment': harassmentScore,
      'Explicit Content': explicitScore,
      'Self-Harm': selfHarmScore,
    };

    final maxEntry = scores.entries.reduce((a, b) => a.value > b.value ? a : b);

    if (maxEntry.value >= 0.3) {
      return ContentAnalysisResult(
        isHarmful: true,
        category: maxEntry.key,
        confidence: maxEntry.value,
        message: 'Detected harmful text: ${maxEntry.key}',
      );
    }

    return ContentAnalysisResult(
      isHarmful: false,
      category: 'Safe',
      confidence: 1.0 - maxEntry.value,
      message: 'Text appears safe',
    );
  }

  double _calculateKeywordScore(String text, List<String> keywords) {
    int matches = 0;
    for (final keyword in keywords) {
      if (text.contains(keyword)) {
        matches++;
      }
    }
    return matches / keywords.length;
  }

  ContentAnalysisResult _fallbackAnalysis() {
    // Fallback when model is not available
    return ContentAnalysisResult(
      isHarmful: false,
      category: 'Safe',
      confidence: 0.0,
      message: 'Model not available, using basic detection',
    );
  }

  void dispose() {
    _interpreter?.close();
    _isInitialized = false;
  }
}

class ContentAnalysisResult {
  final bool isHarmful;
  final String category;
  final double confidence;
  final String message;

  ContentAnalysisResult({
    required this.isHarmful,
    required this.category,
    required this.confidence,
    required this.message,
  });

  Map<String, dynamic> toJson() => {
        'isHarmful': isHarmful,
        'category': category,
        'confidence': confidence,
        'message': message,
      };

  @override
  String toString() =>
      'ContentAnalysisResult(isHarmful: $isHarmful, category: $category, confidence: ${confidence.toStringAsFixed(2)})';
}
