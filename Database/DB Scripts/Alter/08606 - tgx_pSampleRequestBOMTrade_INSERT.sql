IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tgx_pSampleRequestBOMTrade_INSERT]'))
DROP TRIGGER [dbo].[tgx_pSampleRequestBOMTrade_INSERT]
GO


CREATE TRIGGER [dbo].[tgx_pSampleRequestBOMTrade_INSERT]
ON [dbo].[pSampleRequestBOMTrade]
AFTER INSERT 
AS
DECLARE @Value INT

DECLARE @Config NVARCHAR(50)
SELECT @Config = AppSettingValue FROM sAppSetting WHERE AppSettingKey = 'EnableSampleRequestPages' 

SELECT @Value = 
CASE 
      WHEN UPPER(@Config) = UPPER('FALSE') THEN 0 
      WHEN UPPER(@Config) = UPPER('TRUE') THEN 1 
END 
   
UPDATE pSampleRequestBOMTrade SET EnableSampleRequestPages = @Value 
WHERE pSampleRequestBOMTrade.SampleRequestTradeID IN (SELECT SampleRequestTradeID FROM INSERTED)

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08606', GetDate())
GO
