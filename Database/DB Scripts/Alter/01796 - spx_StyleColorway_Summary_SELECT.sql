IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleColorway_Summary_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleColorway_Summary_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_StyleColorway_Summary_SELECT]  (
@StyleID UNIQUEIDENTIFIER , 
@StyleSet INT,
@SeasonYearID NVARCHAR(50) =''
)
AS 


IF @SeasonYearID = '' 
BEGIN
	SELECT TOP 1 @SeasonYearID = SeasonYearID FROM pStyleSeasonYear WHERE StyleID = @StyleID
END 


DECLARE @StyleSeasonYearID  UNIQUEIDENTIFIER 
DECLARE @LinePlanItemID UNIQUEIDENTIFIER 
DECLARE @LinePlanRangeID UNIQUEIDENTIFIER 


SELECT @StyleSeasonYearID  = StyleSeasonYearID  , @LinePlanItemID = LinePlanItemID
FROM  pStyleSeasonYear
WHERE StyleID = @StyleID 
AND SeasonYearID  = @SeasonYearID 



IF @LinePlanItemID  IS NOT NULL
BEGIN 
	SELECT @LinePlanRangeID = LinePlanRangeID FROM pLinePlanItem  WHERE LinePlanItemID = @LinePlanItemID 

	-- LinePlanStyle 
	SELECT a.StyleColorwayID as StyleColorID , c.StyleColorName, c.StyleColorNo, d.ColorName, 
	c.Sort, c.PLMCode, c.SAPCode,
    '<A HREF=''Style_Colorway_LinePlan_Select.aspx?SN=' + CAST ( @StyleSet AS NVARCHAR(50)) +
	'&SID=' + CAST(@StyleID AS NVARCHAR(50)) +
    '&SCID=' + CAST(a.StyleColorwayID AS NVARCHAR(50)) +
	'&LPID=' + CAST(b.LinePlanID AS NVARCHAR(50)) +
	'&LPRID=' + CAST(@LinePlanRangeID AS NVARCHAR(50))  + 
	'&SYID='  + CAST(b.SeasonYearID AS NVARCHAR(50))  +
	'''><IMG BORDER=''0'' ALT=''...'' src=''../System/Icons/icon_search.gif''></A>' 
	AS SearchImage, c.ColorPaletteID
	FROM  pStyleColorwaySeasonYear a
	INNER JOIN pStyleColorway c ON a.StylecolorwayID =  c.StylecolorID
	INNER JOIN pColorPalette d ON c.ColorPaletteID = d.ColorPaletteID
	INNER JOIN pStyleSeasonYear b ON a.StyleSeasonYearID =  b.StyleSeasonYearID
	WHERE a.StyleSeasonYearID = @StyleSeasonYearID 


END
ELSE
BEGIN

	-- No a lineplan Style 
	SELECT a.StyleColorwayID as StyleColorID , c.StyleColorName, c.StyleColorNo, d.ColorName,
	c.Sort, c.PLMCode, c.SAPCode,
	'<A HREF=''Style_Colorway_Select_Palette.aspx?UPDT=1&SN=' + CAST ( @StyleSet AS NVARCHAR(50)) +
	'&SID=' +  CAST(@StyleID AS NVARCHAR(50)) +
	'&SCID=' +  CAST(a.StyleColorwayID AS NVARCHAR(50)) +
	'&SYID=' +  CAST(b.SeasonYearID AS NVARCHAR(50)) + '''><IMG BORDER=''0'' ALT=''...'' src=''../System/Icons/icon_search.gif''></A>' 
	AS SearchImage, c.ColorPaletteID
	FROM pStyleColorwaySeasonYear a
	INNER JOIN pStyleColorway c ON a.StylecolorwayID =  c.StyleColorID 
	INNER JOIN pColorPalette d ON c.ColorPaletteID = d.ColorPaletteID
	INNER JOIN pStyleSeasonYear b ON a.StyleSeasonYearID =  b.StyleSeasonYearID
	WHERE a.StyleSeasonYearID = @StyleSeasonYearID 

END 

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01796'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01796', GetDate())

END

GO 

























