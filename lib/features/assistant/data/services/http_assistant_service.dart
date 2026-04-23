import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../domain/models/assistant_message.dart';
import '../../domain/models/assistant_reply.dart';
import '../../domain/services/assistant_service.dart';
import '../models/assistant_message_request.dart';
import '../models/assistant_message_response.dart';

class HttpAssistantService implements AssistantService {
  HttpAssistantService({
    required this.baseUrl,
    required this.path,
    http.Client? client,
  }) : _client = client ?? http.Client();

  final String baseUrl;
  final String path;
  final http.Client _client;

  @override
  Future<AssistantReply> sendMessage({
    required String prompt,
    required List<AssistantMessage> conversation,
    String? conversationId,
  }) async {
    final request = AssistantMessageRequest(
      prompt: prompt,
      conversation: conversation,
      conversationId: conversationId,
    );

    final uri = Uri.parse(baseUrl).resolve(path);
    final response = await _client.post(
      uri,
      headers: const {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      String details =
          'Unexpected status code: ${response.statusCode} for $uri';

      try {
        final decoded = jsonDecode(response.body);
        if (decoded is Map<String, dynamic>) {
          final error = decoded['error'];
          final serverDetails = decoded['details'];

          if (error is String && error.trim().isNotEmpty) {
            details = error.trim();
          }
          if (serverDetails is String && serverDetails.trim().isNotEmpty) {
            details = '$details (${serverDetails.trim()})';
          }
        }
      } catch (_) {
        final body = response.body.trim();
        if (body.isNotEmpty) {
          details = '$details ($body)';
        }
      }

      throw AssistantServiceException(
        details,
      );
    }

    final decoded = jsonDecode(response.body);
    if (decoded is! Map<String, dynamic>) {
      throw const AssistantServiceException('Invalid response payload');
    }

    final assistantResponse = AssistantMessageResponse.fromJson(decoded);
    if (assistantResponse.message.trim().isEmpty) {
      throw const AssistantServiceException('Empty assistant response');
    }

    return assistantResponse.toDomain();
  }
}

class AssistantServiceException implements Exception {
  const AssistantServiceException(this.message);

  final String message;

  @override
  String toString() => message;
}
