
IF EXISTS (select * from sysobjects where id = object_id('rpx_StyleColorwaySeasonalYear_PIVOT') and sysstat & 0xf = 4)
	drop procedure rpx_StyleColorwaySeasonalYear_PIVOT
GO


CREATE PROCEDURE rpx_StyleColorwaySeasonalYear_PIVOT (@StyleId uniqueidentifier, @StyleSeasonYearID NVARCHAR(50)= NULL)    
AS  

SELECT     b.StyleColorName, c.Status, dbo.fnx_int2StrDelivery(a.StyleColorDelivery1) as StyleColorDelivery1, dbo.fnx_int2StrDelivery(a.StyleColorDelivery2) as StyleColorDelivery2, 
dbo.fnx_int2StrDelivery(a.StyleColorDelivery3) as StyleColorDelivery3, dbo.fnx_int2StrDelivery(a.StyleColorDelivery4) as StyleColorDelivery4
FROM         pStyleColorwaySeasonYear AS a INNER JOIN
                      pStyleColorway AS b ON a.StyleColorwayID = b.StyleColorID
LEFT OUTER JOIN pStyleColorwayStatus AS c ON a.StyleColorStatus = c.StatusID
WHERE     (a.StyleSeasonYearID = @StyleSeasonYearId and b.StyleID=@StyleId)   

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '031', GetDate())
GO