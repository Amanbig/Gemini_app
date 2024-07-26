import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService{
  final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: 'AIzaSyDEZLvpQDd39rQZSMiA7ei9x_upBAZQTu4');
   Future<String> generate(String title, String topic)async{
    final content = [Content.text('Write a ${title} about a ${topic}.')];
    final response = await model.generateContent(content);
    return response.text.toString();
  }
}