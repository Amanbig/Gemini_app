import 'dart:typed_data';
import 'dart:io';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gemini_app/services/geminiService.dart';
import 'package:http/http.dart'
    as http; // Make sure to add this to your pubspec.yaml

void main() async {
  await dotenv.load();
  // Replace with your actual API key
  final apiKey = dotenv.env['API_KEY'] ?? 'default_value';

  // Create a GeminiService instance
  final geminiService = GeminiService(apiKey: apiKey);

  // Test text generation
  try {
    print('--- Testing Text Generation ---');
    final generatedText = await geminiService.generateText(
      prompt: 'Write a short poem about a cat in Chandigarh',
      model: 'gemini-2.0-flash',
    );
    print('Generated Text: $generatedText\n');
  } catch (e) {
    print('Error generating text: $e\n');
  }

  // Test text generation with thinking
  try {
    print('--- Testing Text Generation with Thinking ---');
    final generatedTextWithThinking =
        await geminiService.generateTextWithThinking(
      prompt:
          'Explain the concept of a smart city in Chandigarh in a low-reasoning effort',
      model: 'gemini-2.5-flash-preview-04-17',
    );
    print('Generated Text with Thinking: $generatedTextWithThinking\n');
  } catch (e) {
    print('Error generating text with thinking: $e\n');
  }

  // Test image generation
  // try {
  //   print('--- Testing Image Generation ---');
  //   final generatedImage = await geminiService.generateImage(
  //     prompt:
  //         'A bustling market in Chandigarh, India with colorful textiles and spices',
  //     model: 'imagen-3.0-generate-002',
  //   );
  //   print('Generated Image (base64): ${generatedImage.substring(0, 50)}...\n');

  //   // Optionally save the image to file
  //   /*
  //   final imageBytes = base64Decode(generatedImage);
  //   final file = File('generated_image.png');
  //   await file.writeAsBytes(imageBytes);
  //   print('Image saved to generated_image.png\n');
  //   */
  // } catch (e) {
  //   print('Error generating image: $e\n');
  // }

  // Test listing models
  try {
    print('--- Testing List Models ---');
    final models = await geminiService.listModels();
    print('Available Models:');
    for (final model in models) {
      print('- $model');
    }
    print('\n');
  } catch (e) {
    print('Error listing models: $e\n');
  }

  // // Test file upload
  // try {
  //   print('--- Testing File Upload ---');
  //   // Example: Create a simple text file to upload
  //   final Uint8List fileBytes =
  //       Uint8List.fromList(utf8.encode('This is a test file content.'));
  //   final uploadResult = await geminiService.uploadFile(
  //     fileBytes: fileBytes,
  //     fileName: 'test.txt',
  //     mimeType: 'text/plain',
  //   );
  //   print('Uploaded file ID: $uploadResult\n');
  // } catch (e) {
  //   print('Error uploading file: $e\n');
  // }

  // Test function calling
  // try {
  //   print('--- Testing Function Calling ---');
  //   final functionDeclarations = [
  //     {
  //       'name': 'get_weather',
  //       'description': 'Get the current weather in a given location',
  //       'parameters': {
  //         'type': 'object',
  //         'properties': {
  //           'location': {
  //             'type': 'string',
  //             'description': 'The city and state, e.g., San Francisco, CA',
  //           },
  //           'unit': {
  //             'type': 'string',
  //             'enum': ['celsius', 'fahrenheit'],
  //             'description': 'The temperature unit to use',
  //           },
  //         },
  //         'required': ['location'],
  //       },
  //     }
  //   ];

  //   final functionCallResult = await geminiService.functionCall(
  //     prompt: 'What is the weather like in Chandigarh today?',
  //     functionDeclarations: functionDeclarations,
  //     model: 'gemini-2.0-flash',
  //   );
  //   print('Function Call Result: $functionCallResult\n');
  // } catch (e) {
  //   print('Error performing function call: $e\n');
  // }

  // Test image analysis (Vision)
  try {
    print('--- Testing Image Analysis (Vision) ---');
    // For testing, you should have an image file and read it
    // Replace 'test_image.jpg' with the path to your test image
    final File imageFile = File('assets/ai_image.jpeg');
    if (await imageFile.exists()) {
      final Uint8List imageBytes = await imageFile.readAsBytes();
      final String base64Image = base64Encode(imageBytes);

      final imageAnalysis = await geminiService.analyzeImage(
        base64Image: base64Image,
        prompt: 'Describe what you see in this image in detail.',
        model: 'gemini-2.0-flash',
      );
      print('Image Analysis: $imageAnalysis\n');
    } else {
      print('Test image file not found. Skipping vision test.\n');
    }
  } catch (e) {
    print('Error analyzing image: $e\n');
  }

  // Test multiple image analysis
  try {
    print('--- Testing Multiple Image Analysis ---');
    // For testing, you should have multiple image files
    final List<String> imagePaths = ['assets/ai_image.jpeg', 'assets/gemini_logo.jpeg'];
    final List<String> base64Images = [];

    bool allImagesExist = true;
    for (final path in imagePaths) {
      final File imageFile = File(path);
      if (await imageFile.exists()) {
        final Uint8List imageBytes = await imageFile.readAsBytes();
        base64Images.add(base64Encode(imageBytes));
      } else {
        print('Image file $path not found.');
        allImagesExist = false;
        break;
      }
    }

    if (allImagesExist && base64Images.length > 1) {
      final multiImageAnalysis = await geminiService.analyzeMultipleImages(
        base64Images: base64Images,
        prompt: 'Compare these two images and describe the differences.',
        model: 'gemini-2.0-flash',
      );
      print('Multiple Image Analysis: $multiImageAnalysis\n');
    } else {
      print(
          'One or more test image files not found. Skipping multiple image test.\n');
    }
  } catch (e) {
    print('Error analyzing multiple images: $e\n');
  }

  // Test chat with image
  try {
    print('--- Testing Chat with Image ---');
    final File imageFile = File('assets/ai_image.jpeg');
    if (await imageFile.exists()) {
      final Uint8List imageBytes = await imageFile.readAsBytes();
      final String base64Image = base64Encode(imageBytes);

      final messages = [
        {'role': 'user', 'content': 'What can you tell me about this image?'},
      ];

      final chatWithImageResult = await geminiService.chatWithImage(
        base64Image: base64Image,
        messages: messages,
        model: 'gemini-2.0-flash',
      );
      print('Chat with Image Result: $chatWithImageResult\n');
    } else {
      print('Test image file not found. Skipping chat with image test.\n');
    }
  } catch (e) {
    print('Error chatting with image: $e\n');
  }

  // Test audio transcription
  try {
    print('--- Testing Audio Transcription ---');
    // For testing, you should have an audio file
    final File audioFile = File('test_audio.mp3');
    if (await audioFile.exists()) {
      final Uint8List audioBytes = await audioFile.readAsBytes();

      final transcription = await geminiService.transcribeAudio(
        audioBytes: audioBytes,
        fileName: 'test_audio.mp3',
        model: 'chirp-3.5-flash',
        language: 'en',
      );
      print('Audio Transcription: $transcription\n');
    } else {
      print('Test audio file not found. Skipping transcription test.\n');
    }
  } catch (e) {
    print('Error transcribing audio: $e\n');
  }

  // Test audio description
  try {
    print('--- Testing Audio Description ---');
    final File audioFile = File('test_audio.mp3');
    if (await audioFile.exists()) {
      final Uint8List audioBytes = await audioFile.readAsBytes();

      final audioDescription = await geminiService.describeAudio(
        audioBytes: audioBytes,
        fileName: 'test_audio.mp3',
        prompt: 'Describe what you hear in this audio file.',
        model: 'chirp-3.5-flash',
      );
      print('Audio Description: $audioDescription\n');
    } else {
      print('Test audio file not found. Skipping audio description test.\n');
    }
  } catch (e) {
    print('Error describing audio: $e\n');
  }

  // Helper function to ensure test files exist
  Future<void> ensureTestFilesExist() async {
    // Create a dummy image file if it doesn't exist
    final File imageFile = File('test_image.jpg');
    if (!await imageFile.exists()) {
      print('Creating dummy test image file...');
      try {
        // This URL points to a placeholder image service
        final response =
            await http.get(Uri.parse('https://via.placeholder.com/300'));
        if (response.statusCode == 200) {
          await imageFile.writeAsBytes(response.bodyBytes);
          print('Created test image file: test_image.jpg\n');
        }
      } catch (e) {
        print('Error creating test image: $e\n');
      }
    }

    // Create a second image file for multiple image testing
    final File imageFile2 = File('test_image2.jpg');
    if (!await imageFile2.exists()) {
      print('Creating second dummy test image file...');
      try {
        final response =
            await http.get(Uri.parse('https://via.placeholder.com/300/ff0000'));
        if (response.statusCode == 200) {
          await imageFile2.writeAsBytes(response.bodyBytes);
          print('Created test image file: test_image2.jpg\n');
        }
      } catch (e) {
        print('Error creating second test image: $e\n');
      }
    }

    // Note: Creating a valid audio file programmatically is more complex,
    // for testing purposes you should add your own test audio file.
    final File audioFile = File('test_audio.mp3');
    if (!await audioFile.exists()) {
      print(
          'Note: You need to provide your own test_audio.mp3 file for audio tests.\n');
    }
  }

  // Ensure test files exist before running tests
  await ensureTestFilesExist();

  print('All tests completed.');
}
