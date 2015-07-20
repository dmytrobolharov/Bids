IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Culture_DEFAULT_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Culture_DEFAULT_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Rajul Radadia
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[spx_Culture_DEFAULT_SELECT]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SELECT CultureIndentifierID, CultureName, CultureCountry
	FROM sSystemCulture
	WHERE Active=1
	ORDER BY CultureCountry DESC
END
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03320'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03320', GetDate())
END

GO