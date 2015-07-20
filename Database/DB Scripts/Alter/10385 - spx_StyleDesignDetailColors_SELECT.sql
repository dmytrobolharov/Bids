IF OBJECT_ID(N'[dbo].[spx_StyleDesignDetailColors_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleDesignDetailColors_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleDesignDetailColors_SELECT](
	@StyleSeasonYearID UNIQUEIDENTIFIER,
	@MDate DATETIME,
	@MUser NVARCHAR(200)
)
AS

	INSERT INTO pStyleDesignDetailColorway(DesignDetailStyleColorID,StyleSeasonYearID, StyleColorwaySeasonYearID, Notes, MDate, MUser)
	SELECT NEWID() AS DesignDetailStyleColorID,a.StyleSeasonYearID, a.StyleColorwaySeasonYearID, NULL, @MDate, @MUser
	FROM dbo.pStyleColorwaySeasonYear a
		LEFT OUTER JOIN pStyleDesignDetailColorway b WITH(NOLOCK) ON a.StyleColorwaySeasonYearID =  b.StyleColorwaySeasonYearID
	WHERE a.StyleSeasonYearID = @StyleSeasonYearID 
	AND b.StyleColorwaySeasonYearID IS NULL 
	

	SELECT '<table class=''fontHead'' border=0 ><tr><td><img src="../System/Control/ColorStream.ashx?S=60&CFID=' + CAST(d.ColorFolderID AS NVARCHAR(50))
		+ '&CPID=' + CAST(d.ColorPaletteID AS NVARCHAR(50)) +  '" border="0" /></td></tr><tr><td>' + d.ColorCode + '</td></tr>
		<tr><td width=60 >' + d.ColorName+ '</td></tr></table>' 
	AS Colorway ,a.* 
	FROM pStyleDesignDetailColorway a WITH(NOLOCK)
		INNER JOIN dbo.pStyleColorwaySeasonYear b WITH(NOLOCK) ON a.StyleColorwaySeasonYearID =  b.StyleColorwaySeasonYearID
		INNER JOIN dbo.pStyleColorway c ON c.StyleColorID =  b.StyleColorwayID
		INNER JOIN dbo.pColorPalette d WITH(NOLOCK) ON d.ColorPaletteID =  c.ColorPaletteID
	WHERE a.StyleSeasonYearID = @StyleSeasonYearID
	

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10385', GetUTCDate())
GO
