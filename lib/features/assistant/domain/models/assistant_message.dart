class AssistantMessage {
  const AssistantMessage({
    required this.text,
    required this.sender,
  });

  final String text;
  final MessageSender sender;
}

enum MessageSender {
  assistant,
  user,
}
