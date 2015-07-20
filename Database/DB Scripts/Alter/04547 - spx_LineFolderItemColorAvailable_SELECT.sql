/****** Object:  StoredProcedure [dbo].[spx_LineFolderItemColorAvailable_SELECT]    Script Date: 12/05/2012 13:38:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderItemColorAvailable_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderItemColorAvailable_SELECT]
GO


/****** Object:  StoredProcedure [dbo].[spx_LineFolderItemColorAvailable_SELECT]    Script Date: 12/05/2012 13:38:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_LineFolderItemColorAvailable_SELECT]
(
@StyleID uniqueidentifier,
@LineFolderItemID uniqueidentifier
)
AS 

DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER

SELECT @StyleSeasonYearID = StyleSeasonYearID FROM pLineFolderItem
WHERE LineFolderItemID = @LineFolderItemID

SELECT pStyleColorway.* , StyleColorName AS ColorComboDescription
FROM  pStyleColorway 
INNER JOIN pStyleColorwaySeasonYear ON pStyleColorwaySeasonYear.StyleColorwayID = pStyleColorway.StyleColorID
AND pStyleColorwaySeasonYear.StyleID = pStyleColorway.StyleID
WHERE pStyleColorway.StyleID = @StyleID 
AND  StyleColorID NOT IN 
(SELECT StyleColorID FROM pLineFolderItemColor WITH (NOLOCK) WHERE LineFolderItemID = @LineFolderItemID)
AND StyleSeasonYearID = @StyleSeasonYearID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04547', GetDate())
GO
