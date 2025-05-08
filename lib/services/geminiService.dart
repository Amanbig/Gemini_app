import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class GeminiService {
  final String apiKey;
  final String baseUrl;

  GeminiService({
    required this.apiKey,
    this.baseUrl = 'https://generativelanguage.googleapis.com/v1beta/openai',
  });

  /// Uses the OpenAI compatibility layer for text generation.
  Future<String> generateText({
    String prompt = '',
    String model = 'gemini-2.0-flash',
    bool isStream = false,
  }) async {
    final url = Uri.parse('$baseUrl/chat/completions');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };
    final body = jsonEncode({
      'model': model,
      'messages': [
        {'role': 'user', 'content': prompt},
      ],
      'stream': isStream,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'];
    } else {
      throw Exception(
          'Failed to generate text (OpenAI Compat): ${response.body}');
    }
  }

  /// Uses the OpenAI compatibility layer for image generation.
  Future<String> generateImage({
    String prompt = '',
    String model = 'imagen-3.0-generate-002',
  }) async {
    final url = Uri.parse('$baseUrl/images/generations');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };
    final body = jsonEncode({
      'model': model,
      'prompt': prompt,
      'response_format': 'b64_json',
      'n': 1,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['data'] != null &&
          data['data'].isNotEmpty &&
          data['data'][0]['b64_json'] != null) {
        return data['data'][0]['b64_json']; // Base64 encoded image
      } else {
        throw Exception('Unexpected image response format: $data');
      }
    } else {
      throw Exception(
          'Failed to generate image (OpenAI Compat): ${response.body}');
    }
  }

  /// Uses the OpenAI compatibility layer for text generation with thinking.
  Future<String> generateTextWithThinking({
    String prompt = '',
    String model = 'gemini-2.5-flash-preview-04-17',
    bool isStream = false,
  }) async {
    final url = Uri.parse('$baseUrl/chat/completions');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };
    final body = jsonEncode({
      'model': model,
      'messages': [
        {'role': 'user', 'content': prompt},
      ],
      'stream': isStream,
      'reasoning_effort': 'low', // Or "medium", "high", or "none"
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'];
    } else {
      throw Exception(
          'Failed to generate text with thinking (OpenAI Compat): ${response.body}');
    }
  }

  /// Uses the OpenAI compatibility layer to list available models.
  Future<List<String>> listModels() async {
    final url = Uri.parse('$baseUrl/models');
    final headers = {
      'Authorization': 'Bearer $apiKey',
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final models = data['data'] as List;
      return models.map((model) => model['id'] as String).toList();
    } else {
      throw Exception(
          'Failed to list models (OpenAI Compat): ${response.body}');
    }
  }

  /// Uses the OpenAI compatibility layer for file upload.
  Future<String> uploadFile({
    required Uint8List fileBytes,
    required String fileName,
    required String mimeType,
  }) async {
    final url = Uri.parse('$baseUrl/files');

    // Create multipart request
    var request = http.MultipartRequest('POST', url);

    // Add authorization header
    request.headers['Authorization'] = 'Bearer $apiKey';

    // Add file
    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        fileBytes,
        filename: fileName,
      ),
    );

    // Add purpose
    request.fields['purpose'] = 'assistants';

    // Send request
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['id'];
    } else {
      throw Exception('Failed to upload file: ${response.body}');
    }
  }

  /// Performs function calling using the OpenAI compatibility layer.
  Future<Map<String, dynamic>> functionCall({
    required String prompt,
    required List<Map<String, dynamic>> functionDeclarations,
    String model = 'gemini-2.0-flash',
  }) async {
    final url = Uri.parse('$baseUrl/chat/completions');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };
    final body = jsonEncode({
      'model': model,
      'messages': [
        {'role': 'user', 'content': prompt},
      ],
      'tools': [
        {
          'type': 'function',
          'functions': functionDeclarations,
        }
      ],
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception(
          'Failed to perform function call (OpenAI Compat): ${response.body}');
    }
  }

  /// Image-to-text (Vision) using the OpenAI compatibility layer.
  Future<String> analyzeImage({
    required String base64Image,
    String prompt = 'Describe this image in detail.',
    String model = 'gemini-2.0-flash',
  }) async {
    final url = Uri.parse('$baseUrl/chat/completions');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };

    final body = jsonEncode({
      'model': model,
      'messages': [
        {
          'role': 'user',
          'content': [
            {'type': 'text', 'text': prompt},
            {
              'type': 'image_url',
              'image_url': {'url': 'data:image/jpeg;base64,$base64Image'}
            }
          ]
        }
      ]
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'];
    } else {
      throw Exception(
          'Failed to analyze image (OpenAI Compat): ${response.body}');
    }
  }

  /// Audio-to-text transcription using the OpenAI compatibility layer.
  Future<String> transcribeAudio({
    required Uint8List audioBytes,
    required String fileName,
    String model = 'gemini-2.0-flash',
    String language = 'en', // ISO language code
  }) async {
    final url = Uri.parse('$baseUrl/audio/transcriptions');

    // Create multipart request
    var request = http.MultipartRequest('POST', url);

    // Add authorization header
    request.headers['Authorization'] = 'Bearer $apiKey';

    // Add file
    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        audioBytes,
        filename: fileName,
      ),
    );

    // Add additional fields
    request.fields['model'] = model;
    request.fields['language'] = language;

    // Send request
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['text'];
    } else {
      throw Exception(
          'Failed to transcribe audio (OpenAI Compat): ${response.body}');
    }
  }

  /// Audio description (understanding audio content) using the OpenAI compatibility layer.
  Future<String> describeAudio({
    required Uint8List audioBytes,
    required String fileName,
    String prompt = 'Describe what you hear in this audio.',
    String model = 'gemini-2.0-flash',
  }) async {
    final url = Uri.parse('$baseUrl/audio/translations');

    // Create multipart request
    var request = http.MultipartRequest('POST', url);

    // Add authorization header
    request.headers['Authorization'] = 'Bearer $apiKey';

    // Add file
    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        audioBytes,
        filename: fileName,
      ),
    );

    // Add additional fields
    request.fields['model'] = model;
    request.fields['prompt'] = prompt;

    // Send request
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['text'];
    } else {
      throw Exception(
          'Failed to describe audio (OpenAI Compat): ${response.body}');
    }
  }

  /// Multi-turn conversation with image using the OpenAI compatibility layer.
  Future<String> chatWithImage({
    required String base64Image,
    required List<Map<String, dynamic>> messages,
    String model = 'gemini-2.0-flash',
  }) async {
    final url = Uri.parse('$baseUrl/chat/completions');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };

    // Add the image to the last user message
    if (messages.isNotEmpty && messages.last['role'] == 'user') {
      final lastUserMessage = messages.last;
      if (lastUserMessage['content'] is String) {
        // Convert string content to list format
        final textContent = lastUserMessage['content'];
        lastUserMessage['content'] = [
          {'type': 'text', 'text': textContent},
          {
            'type': 'image_url',
            'image_url': {'url': 'data:image/jpeg;base64,$base64Image'}
          }
        ];
      } else if (lastUserMessage['content'] is List) {
        // Append image to existing content list
        lastUserMessage['content'].add({
          'type': 'image_url',
          'image_url': {'url': 'data:image/jpeg;base64,$base64Image'}
        });
      }
    }

    final body = jsonEncode({
      'model': model,
      'messages': messages,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'];
    } else {
      throw Exception(
          'Failed to chat with image (OpenAI Compat): ${response.body}');
    }
  }

  /// Multiple image analysis using the OpenAI compatibility layer.
  Future<String> analyzeMultipleImages({
    required List<String> base64Images,
    String prompt = 'Compare these images.',
    String model = 'gemini-2.0-flash',
  }) async {
    final url = Uri.parse('$baseUrl/chat/completions');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };

    // Create content with text and multiple images
    List<Map<String, dynamic>> content = [
      {'type': 'text', 'text': prompt},
    ];

    // Add all images to the content
    for (final base64Image in base64Images) {
      content.add({
        'type': 'image_url',
        'image_url': {'url': 'data:image/jpeg;base64,$base64Image'}
      });
    }

    final body = jsonEncode({
      'model': model,
      'messages': [
        {'role': 'user', 'content': content}
      ],
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'];
    } else {
      throw Exception(
          'Failed to analyze multiple images (OpenAI Compat): ${response.body}');
    }
  }
}
