import 'package:flutter/material.dart';

import '../../data/services/assistant_conversation_storage.dart';
import '../../domain/models/assistant_message.dart';
import '../../domain/services/assistant_service.dart';
import '../widgets/assistant_typing_bubble.dart';
import '../widgets/assistant_header_card.dart';
import '../widgets/chat_input_card.dart';
import '../widgets/chat_message_bubble.dart';
import '../widgets/emergency_alert_card.dart';

class AssistantScreen extends StatefulWidget {
  const AssistantScreen({
    super.key,
    required this.assistantService,
    required this.conversationStorage,
  });

  final AssistantService assistantService;
  final AssistantConversationStorage conversationStorage;

  @override
  State<AssistantScreen> createState() => _AssistantScreenState();
}

class _AssistantScreenState extends State<AssistantScreen>
    with AutomaticKeepAliveClientMixin {
  static const _initialMessages = [
    AssistantMessage(
      text: 'Ola! Sou seu assistente CUIDA+. Como posso auxiliar sua saude hoje?',
      sender: MessageSender.assistant,
    ),
  ];
  static const _contextWindowSize = 8;

  final TextEditingController _messageController = TextEditingController();
  final List<AssistantMessage> _conversation = List.of(_initialMessages);
  final ScrollController _scrollController = ScrollController();
  bool _isSending = false;
  bool _isRestoring = true;
  String? _conversationId;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _restoreConversation();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> _restoreConversation() async {
    final storedConversation = await widget.conversationStorage.read();
    if (!mounted) {
      return;
    }

    if (storedConversation == null) {
      setState(() {
        _isRestoring = false;
      });
      return;
    }

    setState(() {
      _conversation
        ..clear()
        ..addAll(storedConversation.messages);
      _conversationId = storedConversation.conversationId;
      _isRestoring = false;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  void _scrollToBottom() {
    if (!_scrollController.hasClients) {
      return;
    }

    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOut,
    );
  }

  Future<void> _persistConversation() {
    return widget.conversationStorage.write(
      conversation: List.unmodifiable(_conversation),
      conversationId: _conversationId,
    );
  }

  List<AssistantMessage> _buildContextWindow() {
    if (_conversation.length <= _contextWindowSize) {
      return List.unmodifiable(_conversation);
    }

    return List.unmodifiable(
      _conversation.sublist(_conversation.length - _contextWindowSize),
    );
  }

  String _friendlyErrorMessage(Object error) {
    final raw = error.toString().toLowerCase();
    if (raw.contains('404')) {
      return 'Nao conseguimos encontrar o servico do assistente agora. Tente novamente em instantes.';
    }
    if (raw.contains('timeout') || raw.contains('socket')) {
      return 'Estamos com dificuldade para conectar. Verifique a rede e tente novamente.';
    }
    if (raw.contains('429')) {
      return 'O assistente esta com muitas solicitacoes no momento. Tente novamente daqui a pouco.';
    }
    if (raw.contains('500') || raw.contains('502') || raw.contains('503')) {
      return 'O assistente esta indisponivel no momento. Tente novamente em instantes.';
    }

    return 'Nao foi possivel responder agora. Tente novamente em instantes.';
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty || _isSending || _isRestoring) {
      return;
    }

    setState(() {
      _errorMessage = null;
      _conversation.add(
        AssistantMessage(
          text: text,
          sender: MessageSender.user,
        ),
      );
      _messageController.clear();
      _isSending = true;
    });
    await _persistConversation();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

    try {
      final reply = await widget.assistantService.sendMessage(
        prompt: text,
        conversation: _buildContextWindow(),
        conversationId: _conversationId,
      );

      if (!mounted) {
        return;
      }

      setState(() {
        _conversationId = reply.conversationId ?? _conversationId;
        _conversation.add(
          AssistantMessage(
            text: reply.message,
            sender: MessageSender.assistant,
            summary: reply.summary,
            immediateSteps: reply.immediateSteps,
            alerts: reply.alerts,
            followUpQuestion: reply.followUpQuestion,
          ),
        );
        _isSending = false;
      });
      await _persistConversation();
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    } catch (error) {
      debugPrint('Assistant request failed: $error');
      if (!mounted) {
        return;
      }

      setState(() {
        _isSending = false;
        _errorMessage = _friendlyErrorMessage(error);
      });
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (_isRestoring)
                      const Padding(
                        padding: EdgeInsets.only(top: 48),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF2F7A5F),
                          ),
                        ),
                      )
                    else ...[
                      Text(
                        'CUIDA+',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontSize: 30,
                          color: const Color(0xFF2F7A5F),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x110E1D16),
                              blurRadius: 18,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.fromLTRB(14, 16, 14, 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const AssistantHeaderCard(),
                            const SizedBox(height: 18),
                            for (final message in _conversation) ...[
                              ChatMessageBubble(message: message),
                              const SizedBox(height: 12),
                            ],
                            const EmergencyAlertCard(),
                            const SizedBox(height: 18),
                            if (_errorMessage != null) ...[
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFF5F3),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: const Color(0xFFF1D5D0),
                                  ),
                                ),
                                child: Text(
                                  _errorMessage!,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: const Color(0xFFC05642),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 18),
                            ],
                            ChatInputCard(
                              controller: _messageController,
                              onSend: _sendMessage,
                              enabled: !_isSending,
                            ),
                            const SizedBox(height: 18),
                            if (_isSending)
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: AssistantTypingBubble(),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
