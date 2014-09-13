/****** Object:  StoredProcedure [dbo].[spx_LineFolderStyleCategories_DELETE_INSERT]    Script Date: 03/16/2013 11:38:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderStyleCategories_DELETE_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderStyleCategories_DELETE_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineFolderStyleCategories_DELETE_INSERT]    Script Date: 03/16/2013 11:38:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_LineFolderStyleCategories_DELETE_INSERT]
	@LineFolderID UNIQUEIDENTIFIER,
	@SelectedStyleCategories VARCHAR(MAX)
AS
BEGIN
	    
    DELETE FROM pLineFolderStyleCategory WHERE LineFolderID = @LineFolderID
    
    INSERT INTO pLineFolderStyleCategory (LineFolderID, StyleCategoryID)
    SELECT @LineFolderID, LTRIM(RTRIM(value))
	FROM dbo.fnx_Split(@SelectedStyleCategories, ',')
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05319', GetDate())
GO
