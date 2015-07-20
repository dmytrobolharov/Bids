Alter Table pBOLBaseRateType alter column RateCode nvarchar(200)
Alter Table pBOLBaseRateType alter column RateName nvarchar(200)
Alter Table pBOLBaseRateType alter column RateComment nvarchar(200)
Alter Table pBOLBaseRateType alter column Custom1 nvarchar(200)
Alter Table pBOLBaseRateType alter column Custom2 nvarchar(200)
Alter Table pBOLBaseRateType alter column Custom3 nvarchar(200)
Alter Table pBOLBaseRateType alter column Custom4 nvarchar(200)
Alter Table pBOLBaseRateType alter column Custom5 nvarchar(200)
Alter Table pBOLBaseRateType alter column CUser nvarchar(200)
Alter Table pBOLBaseRateType alter column MUser nvarchar(200)
go

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02339'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02339', GetDate())

END
GO