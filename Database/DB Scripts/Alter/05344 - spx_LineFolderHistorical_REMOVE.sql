/****** Object:  StoredProcedure [dbo].[spx_LineFolderHistorical_REMOVE]    Script Date: 03/19/2013 15:19:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderHistorical_REMOVE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderHistorical_REMOVE]
GO

CREATE PROCEDURE [dbo].[spx_LineFolderHistorical_REMOVE]
	@LineFolderMasterID UNIQUEIDENTIFIER,
	@LineFolderID UNIQUEIDENTIFIER
AS
BEGIN
	
	DELETE FROM pLineFolderHistorical WHERE LineFolderMasterID = @LineFolderMasterID AND LineFolderID = @LineFolderID
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05344', GetDate())
GO
