import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../view_model/cubit/user_data_cubit.dart';

class UserInfoListTile extends StatelessWidget {
  const UserInfoListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataCubit, UserDataState>(
      builder: (context, state) {
        if (state is GetUserDataSuccess) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        context.push(
                          '/photo_view',
                          extra: state.userData.data!.avatar!,
                        );
                      },
                      child: ClipOval(
                        child: Image.network(
                          state.userData.data!.avatar ??
                              "https://tanzolymp.com/images/default-non-user-no-photo-1-768x768.jpg",
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: MediaQuery.sizeOf(context).width * .3,
                            child: Text(
                              state.userData.data!.name ?? "null",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            )),
                        SizedBox(
                            width: MediaQuery.sizeOf(context).width * .3,
                            child: Text(
                              state.userData.data!.email ?? "null",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            )),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    context.push(
                      "/edit_profile",
                      extra: state.userData,
                    );
                  },
                  icon: const Icon(Icons.edit),
                )
              ],
            ),
          );
        } else if (state is GetUserDataLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetUserDataFailure) {
          return Center(child: Text(state.errMessage));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
