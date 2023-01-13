import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piadvisory/Utils/Constants.dart';
import 'package:piadvisory/api/watchlist/models/watchlist_stock_model.dart';

class WatchlistStockApiMethods extends GetConnect {
  Future<Response<List<WatchlistStockModel>>> fetchWatchlistStocks() => get(
        "${ApiConstant.base}api/get_stock_watchlist",
        decoder: (data) {
          var response = data['data'] as List;
          var parsed = response
              .map((json) => WatchlistStockModel.fromJson(json))
              .toList();
          return parsed;
        },
      );

  Future<Response> addStockToWatchlist({
    required int userId,
    required String companyName,
    required String tickerCode,
    required String fincode,
  }) =>
      post(
        "${ApiConstant.base}api/add_stock_watchlist",
        {
          "user_id": userId,
          "company_name": companyName,
          "ticker_code": tickerCode,
          "fin_code": fincode,
        },
        decoder: (data) => data['stock_inserted_id'],
      );

  Future<Response> deleteStockFromWatchlist(int id) =>
      get("${ApiConstant.base}api/delete_stock_watchlist/$id");
}
