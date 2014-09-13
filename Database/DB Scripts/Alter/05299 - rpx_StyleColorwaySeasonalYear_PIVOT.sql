/****** Object:  StoredProcedure [dbo].[rpx_StyleColorwaySeasonalYear_PIVOT]    Script Date: 03/14/2013 15:15:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_StyleColorwaySeasonalYear_PIVOT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_StyleColorwaySeasonalYear_PIVOT]
GO

/****** Object:  StoredProcedure [dbo].[rpx_StyleColorwaySeasonalYear_PIVOT]    Script Date: 03/14/2013 15:15:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[rpx_StyleColorwaySeasonalYear_PIVOT]
(
	@StyleId NVARCHAR(50)
	,@SeasonYearID NVARCHAR(50) = NULL
)

AS


SELECT
	b.StyleColorName
	,c.[Status]
	,dbo.fnx_int2StrDelivery(a.StyleColorDelivery1) as StyleColorDelivery1
	,dbo.fnx_int2StrDelivery(a.StyleColorDelivery2) as StyleColorDelivery2
	,dbo.fnx_int2StrDelivery(a.StyleColorDelivery3) as StyleColorDelivery3
	,dbo.fnx_int2StrDelivery(a.StyleColorDelivery4) as StyleColorDelivery4
FROM pStyleColorwaySeasonYear AS a
	INNER JOIN pStyleColorway AS b ON	a.StyleColorwayID = b.StyleColorID
	LEFT OUTER JOIN pStyleColorwayStatus AS c ON	a.StyleColorStatus = c.StatusID
	INNER JOIN pStyleSeasonYear d ON a.StyleSeasonYearID = d.StyleSeasonYearID
WHERE	d.SeasonYearID = @SeasonYearID
		and b.StyleID=@StyleId


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05299', GetDate())
GO