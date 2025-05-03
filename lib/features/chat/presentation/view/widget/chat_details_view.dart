import 'package:flutter/material.dart';
import 'package:manager_app/core/constant/app_colors.dart';
import 'package:manager_app/core/widget/custom_app_bar.dart';
import 'package:manager_app/core/widget/custom_scaffold.dart';
import 'package:manager_app/features/chat/presentation/view/widget/messages_list_view.dart';

class ChatDetailsView extends StatefulWidget {
  const ChatDetailsView({
    super.key,
  });

  @override
  State<ChatDetailsView> createState() => _ChatDetailsViewState();
}

class _ChatDetailsViewState extends State<ChatDetailsView> {
  final TextEditingController _controller = TextEditingController();
  bool _isNotEmpty = false;
  String chatTitle = "Loading...";

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isNotEmpty = _controller.text.trim().isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: const Color(0xffF3F2F5),
      appBar: const CustomAppBar(title: "Alaa Elhawary"),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Expanded(child: MessagesListView()),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(7),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.darkBlue),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "send message",
                  suffixIcon: _isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            if (_isNotEmpty) {}
                          },
                          icon: const Icon(
                            Icons.send,
                            color: AppColors.darkBlue,
                            size: 30,
                          ),
                        )
                      : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
