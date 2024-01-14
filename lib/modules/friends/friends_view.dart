import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studyhelper/data/user/model/user_model.dart';
import 'package:studyhelper/modules/friends/friends_view_controller.dart';
import 'package:studyhelper/utils/app_color.dart';

class FriendsView extends GetView<FriendsViewController> {
  const FriendsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.mainColor,
        elevation: 0,
        title: const Text('친구'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SearchBar(
              searchController: controller.searchController,
              onSearch: controller.onSearch,
            ),
            _Friends(
              friends: controller.friends,
            ),
            //_Teachers(),
            //_Parents(),
          ],
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  final TextEditingController searchController;
  final VoidCallback onSearch;
  const _SearchBar(
      {required this.searchController, required this.onSearch, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '닉네임 검색',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 40,
          child: TextField(
            controller: searchController,
            cursorColor: AppColor.mainColor,
            textAlign: TextAlign.left,
            onEditingComplete: onSearch,
            decoration: InputDecoration(
                focusColor: AppColor.mainColor,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                enabledBorder: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(),
                suffixIcon: GestureDetector(
                  onTap: onSearch,
                  child: const Icon(
                    Icons.search,
                    color: AppColor.mainColor,
                  ),
                )),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class _Teachers extends StatelessWidget {
  const _Teachers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '선생님(0)',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class _Friends extends StatelessWidget {
  final List<UserModel> friends;
  const _Friends({required this.friends, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '친구(${friends.length.toString()})',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ...friends.map((e) => _friendItem(friend: e)).toList(),
          ],
        ));
  }

  Widget _friendItem({required UserModel friend}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColor.mainColor.withOpacity(0.3)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Text(
              friend.name,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              ' (${friend.nick})',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColor.mainColor),
            ),
          ],
        ),
      ),
    );
  }
}

class _Parents extends StatelessWidget {
  const _Parents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '학부모님(0)',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
