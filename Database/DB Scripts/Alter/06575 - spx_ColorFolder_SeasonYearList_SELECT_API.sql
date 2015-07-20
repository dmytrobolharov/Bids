/****** Object:  StoredProcedure [dbo].[spx_ColorFolder_SeasonYearList_SELECT_API]    Script Date: 11/13/2013 11:58:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorFolder_SeasonYearList_SELECT_API]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorFolder_SeasonYearList_SELECT_API]
GO

/****** Object:  StoredProcedure [dbo].[spx_ColorFolder_SeasonYearList_SELECT_API]    Script Date: 11/13/2013 11:58:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_ColorFolder_SeasonYearList_SELECT_API] (
	@ColorFolderId uniqueidentifier
)
AS

SELECT pColorFolderSeasonYear.seasonYearId, pSeasonYear.Season+' '+ pSeasonYear.Year as 'SeasonYear'  from pColorFolderSeasonYear
INNER JOIN pSeasonYear on pSeasonYear.SeasonYearID = pColorFolderSeasonYear.SeasonYearID where ColorFolderID = @ColorFolderId

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06575', GetDate())
GO