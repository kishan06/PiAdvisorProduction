class MFSnapShotSummaryModel {
  List<Table>? table;
  List<Table1>? table1;
  List<Table2>? table2;
  List<Table3>? table3;
  List<Table4>? table4;

  MFSnapShotSummaryModel(
      {this.table, this.table1, this.table2, this.table3, this.table4});

  MFSnapShotSummaryModel.fromJson(Map<String, dynamic> json) {
    if (json['Table'] != null) {
      table = <Table>[];
      json['Table'].forEach((v) {
        table!.add(new Table.fromJson(v));
      });
    }
    if (json['Table1'] != null) {
      table1 = <Table1>[];
      json['Table1'].forEach((v) {
        table1!.add(new Table1.fromJson(v));
      });
    }
    if (json['Table2'] != null) {
      table2 = <Table2>[];
      json['Table2'].forEach((v) {
        table2!.add(new Table2.fromJson(v));
      });
    }
    if (json['Table3'] != null) {
      table3 = <Table3>[];
      json['Table3'].forEach((v) {
        table3!.add(new Table3.fromJson(v));
      });
    }
    if (json['Table4'] != null) {
      table4 = <Table4>[];
      json['Table4'].forEach((v) {
        table4!.add(new Table4.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.table != null) {
      data['Table'] = this.table!.map((v) => v.toJson()).toList();
    }
    if (this.table1 != null) {
      data['Table1'] = this.table1!.map((v) => v.toJson()).toList();
    }
    if (this.table2 != null) {
      data['Table2'] = this.table2!.map((v) => v.toJson()).toList();
    }
    if (this.table3 != null) {
      data['Table3'] = this.table3!.map((v) => v.toJson()).toList();
    }
    if (this.table4 != null) {
      data['Table4'] = this.table4!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Table {
  String? fundName;
  String? schemeName;
  String? aMC;
  String? tYPE;
  String? category;
  String? aSSETTYPE;
  String? miniPurches;
  String? miniRedumptAmnt;
  String? miniRedumptUnit;
  String? addPur;
  String? nFOOpen;
  String? nFOClose;
  String? launchDate;
  String? fundManager;
  String? aUMDATE;
  String? netAsset;
  String? faceValue;
  String? custodian;
  String? benchMark;
  String? planName;
  String? sTATUS;
  String? mergedwithSchemecode;
  String? mergedwithSchemename;
  String? mergeEffectiveDate;

  Table(
      {this.fundName,
      this.schemeName,
      this.aMC,
      this.tYPE,
      this.category,
      this.aSSETTYPE,
      this.miniPurches,
      this.miniRedumptAmnt,
      this.miniRedumptUnit,
      this.addPur,
      this.nFOOpen,
      this.nFOClose,
      this.launchDate,
      this.fundManager,
      this.aUMDATE,
      this.netAsset,
      this.faceValue,
      this.custodian,
      this.benchMark,
      this.planName,
      this.sTATUS,
      this.mergedwithSchemecode,
      this.mergedwithSchemename,
      this.mergeEffectiveDate});

  Table.fromJson(Map<String, dynamic> json) {
    fundName = json['FundName'];
    schemeName = json['SchemeName'];
    aMC = json['AMC'];
    tYPE = json['TYPE'];
    category = json['Category'];
    aSSETTYPE = json['ASSET_TYPE'];
    miniPurches = json['MiniPurches'];
    miniRedumptAmnt = json['MiniRedumptAmnt'];
    miniRedumptUnit = json['MiniRedumptUnit'];
    addPur = json['AddPur'];
    nFOOpen = json['NFO_Open'];
    nFOClose = json['NFO_Close'];
    launchDate = json['LaunchDate'];
    fundManager = json['FundManager'];
    aUMDATE = json['AUMDATE'];
    netAsset = json['NetAsset'];
    faceValue = json['FaceValue'];
    custodian = json['Custodian'];
    benchMark = json['BenchMark'];
    planName = json['PlanName'];
    sTATUS = json['STATUS'];
    mergedwithSchemecode = json['Mergedwith_Schemecode'];
    mergedwithSchemename = json['Mergedwith_Schemename'];
    mergeEffectiveDate = json['MergeEffectiveDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FundName'] = this.fundName;
    data['SchemeName'] = this.schemeName;
    data['AMC'] = this.aMC;
    data['TYPE'] = this.tYPE;
    data['Category'] = this.category;
    data['ASSET_TYPE'] = this.aSSETTYPE;
    data['MiniPurches'] = this.miniPurches;
    data['MiniRedumptAmnt'] = this.miniRedumptAmnt;
    data['MiniRedumptUnit'] = this.miniRedumptUnit;
    data['AddPur'] = this.addPur;
    data['NFO_Open'] = this.nFOOpen;
    data['NFO_Close'] = this.nFOClose;
    data['LaunchDate'] = this.launchDate;
    data['FundManager'] = this.fundManager;
    data['AUMDATE'] = this.aUMDATE;
    data['NetAsset'] = this.netAsset;
    data['FaceValue'] = this.faceValue;
    data['Custodian'] = this.custodian;
    data['BenchMark'] = this.benchMark;
    data['PlanName'] = this.planName;
    data['STATUS'] = this.sTATUS;
    data['Mergedwith_Schemecode'] = this.mergedwithSchemecode;
    data['Mergedwith_Schemename'] = this.mergedwithSchemename;
    data['MergeEffectiveDate'] = this.mergeEffectiveDate;
    return data;
  }
}

class Table1 {
  String? aMCCODE;
  String? aMC;
  String? aDD1;
  String? aDD2;
  String? aDD3;
  String? eMAIL;
  String? pHONE;
  String? fAX;
  String? wEBISTE;

  Table1(
      {this.aMCCODE,
      this.aMC,
      this.aDD1,
      this.aDD2,
      this.aDD3,
      this.eMAIL,
      this.pHONE,
      this.fAX,
      this.wEBISTE});

  Table1.fromJson(Map<String, dynamic> json) {
    aMCCODE = json['AMC_CODE'];
    aMC = json['AMC'];
    aDD1 = json['ADD1'];
    aDD2 = json['ADD2'];
    aDD3 = json['ADD3'];
    eMAIL = json['EMAIL'];
    pHONE = json['PHONE'];
    fAX = json['FAX'];
    wEBISTE = json['WEBISTE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AMC_CODE'] = this.aMCCODE;
    data['AMC'] = this.aMC;
    data['ADD1'] = this.aDD1;
    data['ADD2'] = this.aDD2;
    data['ADD3'] = this.aDD3;
    data['EMAIL'] = this.eMAIL;
    data['PHONE'] = this.pHONE;
    data['FAX'] = this.fAX;
    data['WEBISTE'] = this.wEBISTE;
    return data;
  }
}

class Table2 {
  String? rTCODE;
  String? rTNAME;
  String? sEBIREGNO;
  String? aDDRESS1;
  String? aDDRESS2;
  String? aDDRESS3;
  String? sTATE;
  String? tEL;
  String? fAX;
  String? wEBSITE;
  String? rEGADDRESS;
  String? eMAIL;

  Table2(
      {this.rTCODE,
      this.rTNAME,
      this.sEBIREGNO,
      this.aDDRESS1,
      this.aDDRESS2,
      this.aDDRESS3,
      this.sTATE,
      this.tEL,
      this.fAX,
      this.wEBSITE,
      this.rEGADDRESS,
      this.eMAIL});

  Table2.fromJson(Map<String, dynamic> json) {
    rTCODE = json['RT_CODE'];
    rTNAME = json['RT_NAME'];
    sEBIREGNO = json['SEBI_REG_NO'];
    aDDRESS1 = json['ADDRESS1'];
    aDDRESS2 = json['ADDRESS2'];
    aDDRESS3 = json['ADDRESS3'];
    sTATE = json['STATE'];
    tEL = json['TEL'];
    fAX = json['FAX'];
    wEBSITE = json['WEBSITE'];
    rEGADDRESS = json['REG_ADDRESS'];
    eMAIL = json['EMAIL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RT_CODE'] = this.rTCODE;
    data['RT_NAME'] = this.rTNAME;
    data['SEBI_REG_NO'] = this.sEBIREGNO;
    data['ADDRESS1'] = this.aDDRESS1;
    data['ADDRESS2'] = this.aDDRESS2;
    data['ADDRESS3'] = this.aDDRESS3;
    data['STATE'] = this.sTATE;
    data['TEL'] = this.tEL;
    data['FAX'] = this.fAX;
    data['WEBSITE'] = this.wEBSITE;
    data['REG_ADDRESS'] = this.rEGADDRESS;
    data['EMAIL'] = this.eMAIL;
    return data;
  }
}

class Table3 {
  String? schemeName;
  String? fundManager;
  String? cLASSNAME;
  String? rEOPENDT;
  String? benchMark;

  Table3(
      {this.schemeName,
      this.fundManager,
      this.cLASSNAME,
      this.rEOPENDT,
      this.benchMark});

  Table3.fromJson(Map<String, dynamic> json) {
    schemeName = json['SchemeName'];
    fundManager = json['FundManager'];
    cLASSNAME = json['CLASSNAME'];
    rEOPENDT = json['REOPEN_DT'];
    benchMark = json['BenchMark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SchemeName'] = this.schemeName;
    data['FundManager'] = this.fundManager;
    data['CLASSNAME'] = this.cLASSNAME;
    data['REOPEN_DT'] = this.rEOPENDT;
    data['BenchMark'] = this.benchMark;
    return data;
  }
}

class Table4 {
  String? id;
  String? iSIN;
  String? schemecode;
  String? amcCode;
  String? nseSymbol;
  String? series;
  String? rTASchemecode;
  String? aMCSchemecode;
  String? longSchemeDescrip;
  String? shortSchemeDescrip;
  String? cAMSCODE;
  String? status;
  String? bSEScripCode;
  String? sR;
  String? mKtLot;
  String? mFURTA;
  String? mFUAMC;
  String? nSEAMC;
  String? nSEPRCODE;
  String? bSECode;
  String? bSERTACode;
  String? bSERTACodeL1;
  String? bSEAMCCode;
  String? bSECode2;
  String? amfiCode;
  String? divSchemecode;

  Table4(
      {this.id,
      this.iSIN,
      this.schemecode,
      this.amcCode,
      this.nseSymbol,
      this.series,
      this.rTASchemecode,
      this.aMCSchemecode,
      this.longSchemeDescrip,
      this.shortSchemeDescrip,
      this.cAMSCODE,
      this.status,
      this.bSEScripCode,
      this.sR,
      this.mKtLot,
      this.mFURTA,
      this.mFUAMC,
      this.nSEAMC,
      this.nSEPRCODE,
      this.bSECode,
      this.bSERTACode,
      this.bSERTACodeL1,
      this.bSEAMCCode,
      this.bSECode2,
      this.amfiCode,
      this.divSchemecode});

  Table4.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    iSIN = json['ISIN'];
    schemecode = json['Schemecode'];
    amcCode = json['Amc_code'];
    nseSymbol = json['NseSymbol'];
    series = json['Series'];
    rTASchemecode = json['RTASchemecode'];
    aMCSchemecode = json['AMCSchemecode'];
    longSchemeDescrip = json['LongSchemeDescrip'];
    shortSchemeDescrip = json['ShortSchemeDescrip'];
    cAMSCODE = json['CAMS_CODE'];
    status = json['Status'];
    bSEScripCode = json['BSEScripCode'];
    sR = json['SR'];
    mKtLot = json['MKtLot'];
    mFURTA = json['MFURTA'];
    mFUAMC = json['MFUAMC'];
    nSEAMC = json['NSEAMC'];
    nSEPRCODE = json['NSEPRCODE'];
    bSECode = json['BSE_Code'];
    bSERTACode = json['BSE_RTA_Code'];
    bSERTACodeL1 = json['BSE_RTA_Code_l1'];
    bSEAMCCode = json['BSE_AMC_Code'];
    bSECode2 = json['BSE_Code_2'];
    amfiCode = json['Amfi_code'];
    divSchemecode = json['Div_Schemecode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['ISIN'] = this.iSIN;
    data['Schemecode'] = this.schemecode;
    data['Amc_code'] = this.amcCode;
    data['NseSymbol'] = this.nseSymbol;
    data['Series'] = this.series;
    data['RTASchemecode'] = this.rTASchemecode;
    data['AMCSchemecode'] = this.aMCSchemecode;
    data['LongSchemeDescrip'] = this.longSchemeDescrip;
    data['ShortSchemeDescrip'] = this.shortSchemeDescrip;
    data['CAMS_CODE'] = this.cAMSCODE;
    data['Status'] = this.status;
    data['BSEScripCode'] = this.bSEScripCode;
    data['SR'] = this.sR;
    data['MKtLot'] = this.mKtLot;
    data['MFURTA'] = this.mFURTA;
    data['MFUAMC'] = this.mFUAMC;
    data['NSEAMC'] = this.nSEAMC;
    data['NSEPRCODE'] = this.nSEPRCODE;
    data['BSE_Code'] = this.bSECode;
    data['BSE_RTA_Code'] = this.bSERTACode;
    data['BSE_RTA_Code_l1'] = this.bSERTACodeL1;
    data['BSE_AMC_Code'] = this.bSEAMCCode;
    data['BSE_Code_2'] = this.bSECode2;
    data['Amfi_code'] = this.amfiCode;
    data['Div_Schemecode'] = this.divSchemecode;
    return data;
  }
}
