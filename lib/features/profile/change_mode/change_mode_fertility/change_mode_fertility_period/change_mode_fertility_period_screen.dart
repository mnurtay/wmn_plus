import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmn_plus/features/profile/change_mode/change_mode_fertility/change_mode_fertility_period/index.dart';
import 'package:wmn_plus/features/registration/index.dart';

class ChangeModeFertilityPeriodScreen extends StatefulWidget {
  ChangeModeFertilityPeriodScreen(
      {Key key,
      @required ChangeModeFertilityPeriodBloc changeModeFertilityPeriodBloc,
      @required Fertility fertility})
      : _changeModeFertilityPeriodBloc = changeModeFertilityPeriodBloc,
        _fertility = fertility,
        super(key: key);

  final ChangeModeFertilityPeriodBloc _changeModeFertilityPeriodBloc;
  final Fertility _fertility;

  @override
  ChangeModeFertilityPeriodScreenState createState() {
    return ChangeModeFertilityPeriodScreenState(_changeModeFertilityPeriodBloc);
  }
}

class ChangeModeFertilityPeriodScreenState
    extends State<ChangeModeFertilityPeriodScreen> {
  final ChangeModeFertilityPeriodBloc _changeModeFertilityPeriodBloc;
  ChangeModeFertilityPeriodScreenState(this._changeModeFertilityPeriodBloc);

  @override
  void initState() {
    super.initState();
    this._load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeModeFertilityPeriodBloc,
            ChangeModeFertilityPeriodState>(
        bloc: widget._changeModeFertilityPeriodBloc,
        builder: (
          BuildContext context,
          ChangeModeFertilityPeriodState currentState,
        ) {
          if (currentState is UnChangeModeFertilityPeriodState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is ErrorChangeModeFertilityPeriodState) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(currentState.errorMessage ?? 'Error'),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: RaisedButton(
                    color: Colors.blue,
                    child: Text('reload'),
                    onPressed: () => this._load(),
                  ),
                ),
              ],
            ));
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Flutter files: done'),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: RaisedButton(
                    color: Colors.red,
                    child: Text('throw error'),
                    onPressed: () => this._load(true),
                  ),
                ),
              ],
            ),
          );
        });
  }

  void _load([bool isError = false]) {
    widget._changeModeFertilityPeriodBloc
        .add(UnChangeModeFertilityPeriodEvent());
        widget._changeModeFertilityPeriodBloc
        .add(LoadChangeModeFertilityPeriodEvent(isError));
    // widget._changeModeFertilityPeriodBloc
    //     .add(CompleteChangeModeFertilityEvent(widget._fertility));
  }
}
