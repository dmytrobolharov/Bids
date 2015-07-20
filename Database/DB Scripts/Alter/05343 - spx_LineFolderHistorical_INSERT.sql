/****** Object:  StoredProcedure [dbo].[spx_LineFolderHistorical_INSERT]    Script Date: 03/19/2013 15:19:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderHistorical_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderHistorical_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_LineFolderHistorical_INSERT]
	@LineFolderMasterID UNIQUEIDENTIFIER,
	@LineFolderID UNIQUEIDENTIFIER
AS
BEGIN
	
	INSERT INTO pLineFolderHistorical(LineFolderMasterID, LineFolderID)
	VALUES (@LineFolderMasterID, @LineFolderID)
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05343', GetDate())
GO
