IF OBJECT_ID(N'[dbo].[vwx_ChangeLogItem_ShowroomStyleColor_SEL]') IS NOT NULL
 DROP VIEW [dbo].[vwx_ChangeLogItem_ShowroomStyleColor_SEL]
GO

CREATE VIEW [dbo].[vwx_ChangeLogItem_ShowroomStyleColor_SEL]
AS

SELECT b.ChangeTableID, b.ChangeTablePKID, b.ChangeUserName, b.ChangeDate, a.*,
       c.ChangeTransTablePKID, e.StyleNo, h.Custom AS Showroom,
       dbo.fnx_GetStreamingColorImageHTML(g.ColorFolderID, g.ColorPaletteID, 20, 'border="0"') AS Color
FROM dbo.pChangeLogItem a WITH (NOLOCK)
	INNER JOIN dbo.pChangeLog b WITH (NOLOCK) ON a.ChangeLogID = b.ChangeLogID
	INNER JOIN dbo.pChangeTransaction c  WITH (NOLOCK) ON c.ChangeTransID = a.ChangeTransID
	INNER JOIN dbo.pLinePlanShowroomStyleColor d  WITH (NOLOCK) ON d.LinePlanShowroomStyleColorID = b.ChangeTablePKID
	INNER JOIN dbo.pStyleHeader e  WITH (NOLOCK) ON e.StyleID =  d.StyleID
	INNER JOIN dbo.pStyleColorway f  WITH (NOLOCK) ON f.StyleColorID = d.StyleColorID
	INNER JOIN dbo.pColorPalette  g  WITH (NOLOCK) ON g.ColorPaletteID =  f.ColorPaletteID
	INNER JOIN dbo.pShowroom h  WITH (NOLOCK) ON h.CustomID =  d.ShowroomID
WHERE  b.ChangeTableID = '00000008-C1CC-DF11-AF06-005056C00008'



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10318', GetUTCDate())
GO
