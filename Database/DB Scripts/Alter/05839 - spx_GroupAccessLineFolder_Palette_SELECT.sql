/****** Object:  StoredProcedure [dbo].[spx_GroupAccessLineFolder_Palette_SELECT]    Script Date: 06/11/2013 14:17:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_GroupAccessLineFolder_Palette_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_GroupAccessLineFolder_Palette_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_GroupAccessLineFolder_Palette_SELECT]    Script Date: 06/11/2013 14:17:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[spx_GroupAccessLineFolder_Palette_SELECT] (   
@GroupID uniqueidentifier,
@LineListTypeID UNIQUEIDENTIFIER  
)  
AS   
  DECLARE @TempPaletteList TABLE
	(
		LinePaletteID UNIQUEIDENTIFIER,
		LinePaletteName NVARCHAR(500),
		LinePaletteDescription NVARCHAR(500),
		LinePaletteSort VARCHAR(5)
	)

	INSERT INTO @TempPaletteList
	EXEC spx_LineFolderPalette_SELECT @LineListTypeID
  
SELECT a.LinePaletteID, a.LinePaletteName, a.LinePaletteSort, a.LinePaletteDescription,  
 b.AccessLinePaletteID, b.AccessLineID,  b.AccessRoleId, b.AccessView, b.AccessCreate,   
 b.AccessModify, b.AccessDelete, b.AccessPrint,
 b.GroupID, b.CUser, b.CDate,  b.MUser,   
 b.MDate  
FROM  @TempPaletteList a INNER JOIN   sAccessGroupLineFolderPalette  b WITH (NOLOCK) ON a.LinePaletteID = b.LinePaletteID  
WHERE b.GroupID = @GroupID  AND b.LineTypeID = @LineListTypeID
ORDER BY a.LinePaletteSort


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '05839', GetDate())
GO
