import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:manager_app/generated/l10n.dart';
import 'package:shimmer/shimmer.dart';
import 'package:manager_app/features/add_ticketian/presentation/view_model/cubit/add_ticketian_cubit.dart';
import 'ticketian_card.dart';

class AllTicketianListView extends StatefulWidget {
  const AllTicketianListView({super.key});

  @override
  State<AllTicketianListView> createState() => _AllTicketianListViewState();
}

class _AllTicketianListViewState extends State<AllTicketianListView> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(13),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 13),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(13),
        ),
        child: BlocBuilder<AddTicketianCubit, AddTicketianState>(
          builder: (context, state) {
            if (state is FetchAllTicketianSuccess) {
              if (state.ticketian.isEmpty) {
                return Center(
                  child: Text(S.of(context).no_ticketian),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.ticketian.length,
                itemBuilder: (context, index) {
                  return TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: Duration(milliseconds: 500 + (index * 100)),
                    curve: Curves.easeOut,
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 30 * (1 - value)),
                          child: child,
                        ),
                      );
                    },
                    child: InkWell(
                      onTap: () {
                        context.push(
                          '/ticketian_details',
                          extra: state.ticketian[index],
                        );
                      },
                      child: TicketianCard(
                        ticketian: state.ticketian[index],
                      ),
                    ),
                  );
                },
              );
            } else if (state is FetchAllTicketianLoading) {
              return buildShimmerLoading();
            } else if (state is FetchAllTicketianFailure) {
              return Center(
                child: Text(state.errMessage),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}

Widget buildShimmerLoading() {
  return ListView.builder(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: 5,
    itemBuilder: (context, index) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 120,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 200,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                height: 1,
                color: Colors.white,
              ),
            ],
          ),
        ),
      );
    },
  );
}
