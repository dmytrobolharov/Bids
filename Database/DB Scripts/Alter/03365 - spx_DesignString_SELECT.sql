IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_DesignString_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_DesignString_SELECT]
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
CREATE PROCEDURE [dbo].[spx_DesignString_SELECT]
	@sSystemHelpID UNIQUEIDENTIFIER
AS
BEGIN --01
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	--Used to create Image folder for Wiki Help project
	--Function removes the characters other than valid characters
	SELECT dbo.fnx_GetCharacters(DesignString, '0-9 a-z') AS ImageFolder
	FROM sSystemHelp 
	WHERE sSystemHelpID = @sSystemHelpID
END --01
GO


	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03365', GetDate())

GO