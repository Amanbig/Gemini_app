import 'package:flutter_tts/flutter_tts.dart';

class Services {
  final FlutterTts flutterTts = FlutterTts();
  var currentVoice;

  void initTTS() {
    flutterTts.getVoices.then((data) {
      try {
        List<Map> _voices = List<Map>.from(data);
        _voices = _voices.where((_voice) => _voice["name"].contains("en")).toList();
        currentVoice = _voices.first;
        setVoice(currentVoice!);
      } catch (e) {
        print(e);
      }
    });
  }

  void setVoice(Map voice) {
    setVolume(0.8);
    flutterTts.setVoice({"name": voice["name"], "locale": voice["locale"]});
  }

  void setVolume(double volume) {
    flutterTts.setVolume(volume);
  }
}
