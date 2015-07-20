IF OBJECT_ID(N'[dbo].[spx_LinePlanTempItemShowroomStyleMenu_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_LinePlanTempItemShowroomStyleMenu_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_LinePlanTempItemShowroomStyleMenu_SELECT] (
@LinePlanTempItemShowroomID UNIQUEIDENTIFIER ,  
@LinePlanRangeID UNIQUEIDENTIFIER
)
AS 


DECLARE  @TradepartnerVendorID  UNIQUEIDENTIFIER 
select   @TradepartnerVendorID  = TradepartnerVendorID  from  pLinePlanTempItemShowroom
where LinePlanTempItemShowroomID = @LinePlanTempItemShowroomID


SELECT  a.StyleID, b.StyleNo, b.Description
FROM pLinePlanItem  a
INNER JOIN pStyleHeader b ON a.StyleID = b.StyleID
INNER JOIN pStyleQuoteItem c On a.StyleID = c.StyleID   
INNER JOIN pStyleColorway d ON d.StyleColorID =  c.StyleColorID
INNER JOIN pLinePlanTempItemShowroomStyleColor f ON f.StyleColorID = c.StyleColorID 
INNER JOIN pStyleSourcing g ON g.StyleSourcingID = c.StyleSourcingID 
LEFT JOIN pSizeClass sc ON sc.CustomID = b.SizeClassId
LEFT JOIN pSizeRange sr ON sr.CustomId = b.SizeRangeId
WHERE a.LinePlanRangeID = @LinePlanRangeID
AND a.StyleID <> '00000000-0000-0000-0000-000000000000' 
AND c.StyleQuoteItemStatusID = 3
AND d.StyleColorStatus = 200
AND g.TradePartnerVendorID = @TradePartnerVendorID
AND f.LinePlanTempItemShowroomID   = @LinePlanTempItemShowroomID
GROUP BY d.ColorPaletteId, c.StyleColorID , a.StyleID, b.StyleNo, b.Description, 
         COALESCE(sc.Custom, b.SizeClass), COALESCE(sr.SizeRangeCode, b.SizeRange), 
		 b.StyleNo + '- ' + b.Description, d.StyleColorNo + '- ' + d.StyleColorName , 
		 d.MainColor, d.Sort, g.StyleSourcingID
ORDER BY b.Description , d.Sort

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09635', GetDate())
GO
