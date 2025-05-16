import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_app/features/add_ticketian/data/model/ticketian_model/ticketian_model.dart';
import 'package:manager_app/features/add_ticketian/data/repo/ticketian_repo.dart';
import '../../../../../core/widget/custom_toast.dart';
part 'add_ticketian_state.dart';

class AddTicketianCubit extends Cubit<AddTicketianState> {
  TicketianRepo ticketianRepo;
  AddTicketianCubit(this.ticketianRepo) : super(AddTicketianInitial());

  Future<void> fetchTicketian() async {
    emit(FetchAllTicketianLoading());
    var result = await ticketianRepo.fetchAllTicketian();
    result.fold(
      (failure) {
        emit(
          FetchAllTicketianFailure(errMessage: failure.errMessage),
        );
      },
      (ticketian) {
        emit(
          FetchAllTicketianSuccess(ticketian: ticketian),
        );
      },
    );
  }

  Future<void> searchTicketian(String name) async {
    emit(FetchAllTicketianLoading());
    var result = await ticketianRepo.searchTicketian(name: name);
    result.fold(
      (failure) {
        emit(FetchAllTicketianFailure(errMessage: failure.errMessage));
      },
      (ticketian) {
        emit(FetchAllTicketianSuccess(ticketian: ticketian));
      },
    );
  }

  Future<void> deleteTicketian(int id) async {
    emit(FetchAllTicketianLoading());
    var result = await ticketianRepo.deleteTicketian(id);
    result.fold(
      (failure) {
        CustomToast.show(
            message: failure.errMessage, backgroundColor: Colors.red);
        fetchTicketian();
      },
      (_) async {
        await fetchTicketian();
      },
    );
  }

  Future<void> editTicketian({
    required int id,
    required String name,
    required String email,
    required String password,
    required String confirmPass,
    required String phone,
  }) async {
    emit(FetchAllTicketianLoading());
    var result = await ticketianRepo.editTicketian(
      id: id,
      name: name,
      email: email,
      phone: phone,
      password: password,
      confirmPass: confirmPass,
    );
    result.fold(
      (failure) async {
        emit(EditTicketianFailure(errMessage: failure.errMessage));
        await fetchTicketian();
      },
      (_) async {
        emit(EditTicketianSuccess());
        await fetchTicketian();
      },
    );
  }
}
