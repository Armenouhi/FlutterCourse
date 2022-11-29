import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'device_event.dart';
part 'device_state.dart';

var items = [
  'See 1 More',
  'See 2 More',
  'See 3 More',
  'See 4 More',
  'See 5 More',
];

class DeviceBloc extends Bloc<DeviceEvent, DeviceState> {
  bool onOff = false;
  double? direction;

  DeviceBloc() : super(DeviceState()) {
    on<SelectMenuItemEvent>(_selectMenuItem);
    on<SelectDropdownItemEvent>(_selectDropdownItemEvent);
    on<ChangeColor>(_changeColorEvent);
    on<DetermineTheSize>(_onDetermineSize);
    on<ChangeSlideColor>(_onChangeColorEvent);
  }

  _selectMenuItem(SelectMenuItemEvent event, Emitter<DeviceState> emit) {
    emit(state.copyWith(selectedIndex: event.index));
  }

  _selectDropdownItemEvent(
      SelectDropdownItemEvent event, Emitter<DeviceState> emit) {
    emit(state.copyWith(dropdownvalue: event.item));
  }

  _changeColorEvent(ChangeColor event, Emitter<DeviceState> emit) {
    emit(state.copyWith(onOff: event.isChanged));
  }

  _onDetermineSize(DetermineTheSize event, Emitter<DeviceState> emit) {
    if (event.direction > 0) {
      direction = event.direction;
    } else if (event.direction < 0) {
      direction = 0;
    }
    emit(state.copyWith(index: direction));
  }

  _onChangeColorEvent(ChangeSlideColor event, Emitter<DeviceState> emit) {
    emit(state.copyWith(isStarted: event.isStarted));
  }
}
