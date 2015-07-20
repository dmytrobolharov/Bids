/****** Object:  StoredProcedure [dbo].[spx_LineFolderStyleTypes_DELETE_INSERT]    Script Date: 03/16/2013 11:36:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderStyleTypes_DELETE_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderStyleTypes_DELETE_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineFolderStyleTypes_DELETE_INSERT]    Script Date: 03/16/2013 11:36:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_LineFolderStyleTypes_DELETE_INSERT]
	@LineFolderID UNIQUEIDENTIFIER,
	@SelectedStyleTypes VARCHAR(MAX)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    
    DELETE FROM pLineFolderStyleType WHERE LineFolderID = @LineFolderID
    
    INSERT INTO pLineFolderStyleType (LineFolderID, StyleTypeID)
    SELECT @LineFolderID, LTRIM(RTRIM(value))
	FROM dbo.fnx_Split(@SelectedStyleTypes, ',')
    
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05318', GetDate())
GO
