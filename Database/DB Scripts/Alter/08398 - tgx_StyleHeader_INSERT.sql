/****** Object:  Trigger [tgx_StyleHeader_INSERT]    Script Date: 07/23/2014 15:48:49 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tgx_StyleHeader_INSERT]'))
DROP TRIGGER [dbo].[tgx_StyleHeader_INSERT]
GO

/****** Object:  Trigger [dbo].[tgx_StyleHeader_INSERT]    Script Date: 07/23/2014 15:48:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE TRIGGER [dbo].[tgx_StyleHeader_INSERT]
ON [dbo].[pStyleHeader]
AFTER INSERT 
AS
DECLARE @Value int

DECLARE @Config NVARCHAR(50)
select @Config = AppSettingValue from sAppSetting where AppSettingKey='EnableStylePages' 

select @Value = 
CASE 
      WHEN UPPER(@Config) = UPPER('FALSE') THEN 0 
      WHEN UPPER(@Config) = UPPER('TRUE') THEN 1 
   END 
   
update pStyleHeader set EnableProductPages=@Value where pStyleHeader.StyleID  IN (SELECT StyleID FROM INSERTED)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08398', GetDate())
GO
