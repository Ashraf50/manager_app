import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_app/features/add_ticketian/data/repo/ticketian_repo.dart';
part 'create_ticketian_state.dart';

class CreateTicketianCubit extends Cubit<CreateTicketianState> {
  TicketianRepo ticketianRepo;
  CreateTicketianCubit(this.ticketianRepo) : super(CreateTicketianInitial());

  Future<bool> createTicketian({
    required String name,
    required String email,
    required String password,
    required String confirmPass,
    required String phone,
  }) async {
    emit(CreateTicketianLoading());
    final result = await ticketianRepo.createTicketian(
      name: name,
      email: email,
      phone: phone,
      password: password,
      confirmPass: confirmPass,
    );
    return result.fold(
      (failure) {
        emit(CreateTicketianFailure(errMessage: failure.errMessage));
        return false;
      },
      (_) async {
        emit(CreateTicketianSuccess());
        return true;
      },
    );
  }
}
