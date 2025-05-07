import 'dart:developer' as dev;
import 'dart:io';
import 'dart:math';

// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:path/path.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart';

class GeminiService {
  final String apiKey;
  Gemini? instance;

  GeminiService({required this.apiKey}) {
    if (apiKey.isEmpty) {
      throw Exception('API_KEY cannot be empty');
    }
    Gemini.init(apiKey: apiKey);
    instance = Gemini.instance;
  }

  /// Generates a random string of specified length for unique identifiers.
  static String generateRandomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random.secure();
    return String.fromCharCodes(Iterable.generate(
      length,
      (_) => chars.codeUnitAt(random.nextInt(chars.length)),
    ));
  }

  /// Processes a text-only prompt and returns the generated response.
  /// Returns null if an error occurs.
  Future<String?> processTextInput(String prompt) async {
    try {
      if (instance == null) {
        throw Exception('Gemini instance not initialized');
      }
      final response = await instance!.text(prompt);
      return response?.output;
    } catch (e) {
      dev.log('Error processing text input: $e');
      return null;
    }
  }

  Future<String?> processTextAndImageInput(
      String prompt, File imageFile) async {
    try {
      if (instance == null) {
        throw Exception('Gemini instance not initialized');
      }
      if (!await imageFile.exists()) {
        throw Exception('Image file does not exist');
      }
      final supabase = Supabase.instance.client;
      final fileName =
          'images/${generateRandomString(16)}${path.extension(imageFile.path)}';
      await supabase.storage.from('images').upload(fileName, imageFile);
      final fileUri = supabase.storage.from('images').getPublicUrl(fileName);
      String? mimeType;
      final extension = path.extension(imageFile.path).toLowerCase();
      if (extension == '.jpg' || extension == '.jpeg') {
        mimeType = 'image/jpeg';
      } else if (extension == '.png') {
        mimeType = 'image/png';
      } else {
        throw Exception('Unsupported image format: $extension');
      }
      final response = await instance!.prompt(parts: [
        Part.text(prompt),
        Part.file(FileDataPart(mimeType: mimeType, fileUri: fileUri)),
      ]);
      return response?.output;
    } catch (e) {
      dev.log('Error processing text+image input: $e');
      return null;
    }
  }


  /// Streams text responses for real-time text input.
  /// Calls the onData callback with partial responses.
  void streamTextInput(String prompt, Function(String) onData) {
    if (instance == null) {
      dev.log('Gemini instance not initialized');
      return;
    }
    instance!.streamGenerateContent(prompt).listen(
          (value) => onData(value.output ?? ''),
          onError: (e) => dev.log('Error streaming text input: $e'),
        );
  }

  /// Placeholder for image generation.
  /// Note: Gemini API does not support image generation natively.
  /// Returns a message indicating the limitation and suggests an alternative API.
  Future<String?> generateImage(String prompt) async {
    // Gemini does not support image generation.
    // Consider integrating a separate API like Stable Diffusion or DALL·E.
    dev.log('Image generation not supported by Gemini API.');
    return 'Image generation not supported. Use a separate API like Stable Diffusion.';
  }
}
