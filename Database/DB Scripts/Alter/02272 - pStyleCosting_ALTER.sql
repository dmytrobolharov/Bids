ALTER TABLE pStyleCosting ADD BOMCost DECIMAL(18,3) NULL
ALTER TABLE pStyleCosting ADD BOLCost DECIMAL(18,3) NULL
ALTER TABLE pStyleCosting ADD BOLCurr NVARCHAR(5) NULL
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02272'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02272', GetDate())
END
GO