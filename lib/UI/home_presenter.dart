

import 'package:flutter/cupertino.dart';
import 'package:tic_tac_toe/storage/game_info_repository.dart';

class HomePresenter {

  GameInfoRepository repository;

  HomePresenter(){
    repository = GameInfoRepository.getInstance();
  }

  Stream buildVictorsStream(){
    return repository.getVictoryStream();

  }

  int getVictoryCountFromStream(AsyncSnapshot snapshot ){
    return repository.getVictoryCount(snapshot);
  }
}