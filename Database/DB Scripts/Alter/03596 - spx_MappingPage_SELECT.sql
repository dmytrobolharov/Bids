IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MappingPage_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MappingPage_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_MappingPage_SELECT]
	@MappingPage VARCHAR(100)
AS
BEGIN --01
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SELECT h.sSystemHelpID, p.MappingPage, f.sSystemFolder
	FROM sSystemHelp h INNER JOIN sSystemPage p ON h.sSystemPageID = p.sSystemPageID 
		INNER JOIN sSystemFolder f ON p.sSystemFolderID = f.sSystemFolderID
	WHERE p.MappingPage = @MappingPage
END --01
GO


	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03596', GetDate())

GO