IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_ChangeLogItem_ShowroomStyleColor_SEL]') AND type = N'V' )
	DROP VIEW [dbo].[vwx_ChangeLogItem_ShowroomStyleColor_SEL]
GO


CREATE VIEW [dbo].[vwx_ChangeLogItem_ShowroomStyleColor_SEL]
AS

SELECT b.ChangeTableID, b.ChangeTablePKID, b.ChangeUserName, b.ChangeDate,a.*,
c.ChangeTransTablePKID, e.StyleNo,
'<img src="../System/Control/ColorStream.ashx?S=20&CFID=' + CAST(g.ColorFolderID AS NVARCHAR(40))
+ '&CPID=' + CAST(g.ColorPaletteID AS NVARCHAR(40)) +  '" border="0" />' AS Color, h.Custom AS Showroom
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
VALUES     ('DB_Version', '4.0.0000', '686', GetDate())
GO
