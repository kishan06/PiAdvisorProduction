import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piadvisory/Utils/Constants.dart';
import 'package:piadvisory/api/watchlist/models/watchlist_mutual_fund_model.dart';

class WatchlistMutualFundApiMethods extends GetConnect {
  Future<Response<List<WatchlistMutualFundModel>>> fetchWatchlistStocks() =>
      get(
        "${ApiConstant.base}api/get_mutual_fund_watchlist",
        decoder: (data) {
          var response = data['data'] as List;
          var parsed = response
              .map((json) => WatchlistMutualFundModel.fromJson(json))
              .toList();
          return parsed;
        },
      );

  Future<Response> addMutualFundToWatchlist({
    required int userId,
    required String companyName,
    required String schemeCode,
  }) =>
      post(
        "${ApiConstant.base}api/add_mutual_fund_watchlist",
        {
          "user_id": userId,
          "company_funding_name": companyName,
          "option_scheme": schemeCode,
          "equity_type": "equity_type",
          "percentage": "percentage",
          "years": "years"
        },
        decoder: (data) => data['mutual_fund_inserted_id'],
      );

  Future<Response> deleteMutualFundFromWatchlist(int id) =>
      get("${ApiConstant.base}api/delete_mutual_fund_watchlist/$id");
}
