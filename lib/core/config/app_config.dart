class AppConfig {
  const AppConfig._();

  static const String assistantApiBaseUrl = String.fromEnvironment(
    'ASSISTANT_API_BASE_URL',
    defaultValue: '',
  );

  static const String assistantApiPath = String.fromEnvironment(
    'ASSISTANT_API_PATH',
    defaultValue: '/assistant/message',
  );

  static bool get hasAssistantApi =>
      assistantApiBaseUrl.trim().isNotEmpty;
}
