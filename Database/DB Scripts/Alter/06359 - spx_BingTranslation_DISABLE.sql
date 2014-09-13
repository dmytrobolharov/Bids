IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BingTranslation_DISABLE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BingTranslation_DISABLE]
GO

/****** Object:  StoredProcedure [dbo].[spx_BingTranslation_DISABLE]    Script Date: 09/23/2013 13:11:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Rajul Radadia
-- Create date: 
-- Description:	Disable Translation checkbox if API key is invalid
-- Page affected: Help_New_Language.aspx
-- =============================================
CREATE PROCEDURE [dbo].[spx_BingTranslation_DISABLE]
(
	@ConfigFile NVARCHAR (256) = 'system.config'
)
AS
BEGIN --01
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	UPDATE sAppSetting
	SET AppSettingValue = 'False',
		MDate = GETDATE()
	WHERE ConfigFileName = @ConfigFile AND
		  AppSettingKey = 'BingTranslation'
END --01

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06359', GetDate())
GO
