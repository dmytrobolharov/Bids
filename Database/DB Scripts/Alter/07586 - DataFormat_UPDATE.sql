UPDATE pPlanningFinancial SET PlanningFinancialDataFormat = '###,###,##' + PlanningFinancialDataFormat WHERE PlanningFinancialDataFormat != '{0:p}' AND PlanningFinancialDataFormat NOT LIKE '%#%'
GO

UPDATE sSystemCulture SET DecimalValidationRegEx = '((\d{1,3})?(\' + CurrencyDigitGroupingSymbol + '\d{3})*[' + CurrencyDecimalSymbol + ']?\d*|\d*[' + CurrencyDecimalSymbol + ']?\d*)'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07586', GetDate())
GO
