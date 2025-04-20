import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_app/features/add_ticketian/data/model/ticketian_model/ticketian_model.dart';
import 'package:manager_app/features/add_ticketian/data/repo/ticketian_repo.dart';
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

  Future<bool> createTicketian({
    required String name,
    required String email,
    required String password,
    required String confirmPass,
    required String phone,
  }) async {
    emit(FetchAllTicketianLoading());
    final result = await ticketianRepo.createTicketian(
      name: name,
      email: email,
      phone: phone,
      password: password,
      confirmPass: confirmPass,
    );
    return result.fold(
      (failure) {
        emit(FetchAllTicketianFailure(errMessage: failure.errMessage));
        return false;
      },
      (_) async {
        await fetchTicketian();
        return true;
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
        emit(FetchAllTicketianFailure(errMessage: failure.errMessage));
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
      (failure) {
        emit(FetchAllTicketianFailure(errMessage: failure.errMessage));
      },
      (_) async {
        await fetchTicketian();
      },
    );
  }
}
