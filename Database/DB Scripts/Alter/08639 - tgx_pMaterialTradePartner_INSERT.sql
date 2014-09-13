IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tgx_pMaterialTradePartner_INSERT]'))
DROP TRIGGER [dbo].[tgx_pMaterialTradePartner_INSERT]
GO


CREATE TRIGGER [dbo].[tgx_pMaterialTradePartner_INSERT]
ON [dbo].[pMaterialTradePartner]
AFTER INSERT 
AS
DECLARE @Value INT

DECLARE @Config NVARCHAR(50)
SELECT @Config = AppSettingValue FROM sAppSetting WHERE AppSettingKey = 'EnableMaterialRequestPages' 

SELECT @Value = 
CASE 
      WHEN UPPER(@Config) = UPPER('FALSE') THEN 0 
      WHEN UPPER(@Config) = UPPER('TRUE') THEN 1 
END 
   
UPDATE pMaterialTradePartner SET EnableMaterialRequestPages = @Value 
WHERE pMaterialTradePartner.MaterialTradePartnerId IN (SELECT MaterialTradePartnerId FROM INSERTED)

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08639', GetDate())
GO
