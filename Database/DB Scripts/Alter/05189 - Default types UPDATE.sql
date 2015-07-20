UPDATE pSourcingType SET SourcingCode='Default', SourcingTypeName='Default Sourcing' WHERE SourcingCode='Specified' AND SourcingTypeName='Specified sourcing'
UPDATE pLineListType SET LineListCode='Default', LineListType='Line Plan Default' WHERE LineListCode='LIN0001' AND LineListType='Unspecified Line'

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05189', GetDate())

GO
