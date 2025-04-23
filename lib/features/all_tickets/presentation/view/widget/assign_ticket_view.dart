import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:manager_app/core/constant/app_colors.dart';
import 'package:manager_app/core/widget/custom_app_bar.dart';
import 'package:manager_app/core/widget/custom_button.dart';
import 'package:manager_app/core/widget/custom_scaffold.dart';
import 'package:manager_app/core/widget/custom_toast.dart';
import 'package:manager_app/features/add_ticketian/data/model/ticketian_model/ticketian_model.dart';
import 'package:manager_app/features/add_ticketian/presentation/view_model/cubit/add_ticketian_cubit.dart';
import 'package:manager_app/features/all_tickets/presentation/view_model/cubit/ticket_cubit.dart';
import '../../../../../../../core/widget/drop_down_text_field.dart';
import '../../../../../core/constant/app_styles.dart';

class AssignTicketView extends StatefulWidget {
  final int ticketId;
  const AssignTicketView({super.key, required this.ticketId});

  @override
  State<AssignTicketView> createState() => _AssignTicketViewState();
}

class _AssignTicketViewState extends State<AssignTicketView> {
  int? selectedTicketianId;
  TicketianModel? selectTicketian;

  @override
  void initState() {
    super.initState();
    context.read<AddTicketianCubit>().fetchTicketian();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TicketCubit, TicketState>(
      listener: (context, state) {
        if (state is FetchTicketLoading) {
          SmartDialog.showLoading();
        } else if (state is FetchTicketFailure) {
          SmartDialog.dismiss();
          CustomToast.show(
            message: state.errMessage,
            backgroundColor: Colors.red,
          );
        } else {
          SmartDialog.dismiss();
          context.pop(context);
          CustomToast.show(
            message: "Ticket has been assigned to the technician",
            alignment: Alignment.topCenter,
            backgroundColor: AppColors.toastColor,
          );
        }
      },
      child: CustomScaffold(
        appBar: const CustomAppBar(title: "Assign Ticket"),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                "Ticketian",
                style: AppStyles.textStyle18bold,
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<AddTicketianCubit, AddTicketianState>(
                builder: (context, state) {
                  if (state is FetchAllTicketianLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is FetchAllTicketianFailure) {
                    return Text(state.errMessage);
                  } else if (state is FetchAllTicketianSuccess) {
                    return DropdownTextField(
                      ticketian: state.ticketian,
                      selectedTicketian: selectTicketian,
                      onChanged: (ticketian) {
                        setState(() {
                          selectTicketian = ticketian;
                          selectedTicketianId = ticketian.id;
                        });
                      },
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                  title: "Submit",
                  onTap: () async {
                    final cubit = context.read<TicketCubit>();
                    await cubit.assignTicketian(
                      ticketId: widget.ticketId,
                      ticketianId: selectedTicketianId!,
                    );
                  },
                  color: AppColors.activeBlue),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}
