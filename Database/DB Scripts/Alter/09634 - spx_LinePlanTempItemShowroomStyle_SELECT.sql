IF OBJECT_ID(N'[dbo].[spx_LinePlanTempItemShowroomStyle_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_LinePlanTempItemShowroomStyle_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_LinePlanTempItemShowroomStyle_SELECT] (
@LinePlanID UNIQUEIDENTIFIER,
@LinePlanRangeID UNIQUEIDENTIFIER,
@TradePartnerVendorID UNIQUEIDENTIFIER
)
AS 


SELECT d.StyleID ,d.StyleNo, d.Description, 
       COALESCE(sc.Custom, d.SizeClass) AS SizeClass, 
	   COALESCE(sr.SizeRangeCode, d.SizeRange) AS SizeRange, 
	   d.StyleNo + '- ' + d.Description AS StyleDescription, 
       d.DesignSketchId, d.DesignSketchVersion  
FROM pStyleHeader d
LEFT JOIN pSizeClass sc ON sc.CustomID = d.SizeClassId
LEFT JOIN pSizeRange sr ON sr.CustomId = d.SizeRangeId
WHERE d.StyleID IN ( 
	SELECT  b.StyleID 
	FROM pLinePlanRange a
	INNER JOIN pLinePlanItem b ON a.LinePlanRangeID = b.LinePlanRangeID
	INNER JOIN pStyleSeasonYear c ON ( c.LinePlanItemID = b.LinePlanItemID  AND c.StyleID = b.StyleID )
	INNER JOIN pStyleSourcing d ON  d.StyleSeasonYearID = c.StyleSeasonYearID
	INNER JOIN pStyleColorwaySeasonYear e ON e.StyleSeasonYearID = c.StyleSeasonYearID
	INNER JOIN pStyleColorway f ON f.StyleColorID =  e.StyleColorwayID
	INNER JOIN pStyleQuoteItem g ON ( g.StyleSourcingID = d.StyleSourcingID  AND  g.StyleColorID = f.StyleColorID ) 
	WHERE a.LinePlanRangeID = @LinePlanRangeID
	AND b.StyleID <> '00000000-0000-0000-0000-000000000000' 
	AND g.StyleQuoteItemStatusID = 3
	AND e.StyleColorStatus = 200
	AND d.TradePartnerVendorID = @TradePartnerVendorID
)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09634', GetDate())
GO
