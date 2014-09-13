IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCostingDropDownLogic_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleCostingDropDownLogic_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_StyleCostingDropDownLogic_SELECT](
	@StyleID UNIQUEIDENTIFIER
	,@TradePartnerID UNIQUEIDENTIFIER
	,@SeasonYearID  UNIQUEIDENTIFIER = NULL
)

AS 


/************************/
/*Declare variables.	*/
/************************/
DECLARE @TradePartnerClass varchar(10)

DECLARE @StyleSeasonYearID uniqueidentifier  
SET @StyleSeasonYearID = (SELECT StyleSeasonYearID FROM pStyleSeasonYear WHERE SeasonYearID = @SeasonYearID AND StyleID = @StyleID)   


/************/
/*Logic.	*/
/************/
/*Get the "Partner Class" of the Agent you are doing an RFQ with.*/
SELECT @TradePartnerClass = TradePartnerClass FROM uTradePartner WHERE TradePartnerID = @TradePartnerID


/*Show all Costing Types.*/
--SELECT
--	pStyleCosting.StyleCostingID
--	,pStyleCosting.StyleID
--	,pStyleCostingType.StyleCostingType
--	,pStyleCostingStatus.Custom
--	,pStyleCostingStatus.CustomIcon
--	,pStyleCostingType.StyleCostingTypeID
--FROM pStyleCosting
--	INNER JOIN pStyleCostingType ON pStyleCosting.StyleCostingTypeID = pStyleCostingType.StyleCostingTypeID
--	INNER JOIN pStyleCostingStatus ON pStyleCosting.StyleCostingStatus = pStyleCostingStatus.CustomKey
--WHERE pStyleCosting.StyleID = @StyleID
--ORDER BY pStyleCosting.StyleCostingTypeID ASC


/*Show only the Costing Types that should be available for this type of Agent, based upon "Partner Class".*/
--IF @SeasonYearID IS NULL
--BEGIN
--	IF @TradePartnerClass = 1 
--		BEGIN
--			SELECT dbo.pStyleCosting.StyleCostingID, dbo.pStyleCosting.StyleID, dbo.pStyleCostingType.StyleCostingType, dbo.pStyleCostingStatus.Custom, 
--				dbo.pStyleCostingStatus.CustomIcon, dbo.pStyleCostingType.StyleCostingTypeID
--			FROM  dbo.pStyleCosting WITH (NOLOCK) INNER JOIN
--				dbo.pStyleCostingType WITH (NOLOCK) ON dbo.pStyleCosting.StyleCostingTypeID = dbo.pStyleCostingType.StyleCostingTypeID INNER JOIN
--				dbo.pStyleCostingStatus WITH (NOLOCK) ON dbo.pStyleCosting.StyleCostingStatus = dbo.pStyleCostingStatus.CustomKey
--			WHERE (dbo.pStyleCosting.StyleID = @StyleID) AND (dbo.pStyleCosting.StyleCostingTypeID = 1)
--			ORDER BY dbo.pStyleCosting.StyleCostingTypeID ASC
--		END	
--	ELSE IF @TradePartnerClass = 2
--		BEGIN
--			SELECT dbo.pStyleCosting.StyleCostingID, dbo.pStyleCosting.StyleID, dbo.pStyleCostingType.StyleCostingType, dbo.pStyleCostingStatus.Custom, 
--				dbo.pStyleCostingStatus.CustomIcon, dbo.pStyleCostingType.StyleCostingTypeID
--			FROM  dbo.pStyleCosting WITH (NOLOCK) INNER JOIN
--				dbo.pStyleCostingType WITH (NOLOCK) ON dbo.pStyleCosting.StyleCostingTypeID = dbo.pStyleCostingType.StyleCostingTypeID INNER JOIN
--				dbo.pStyleCostingStatus WITH (NOLOCK) ON dbo.pStyleCosting.StyleCostingStatus = dbo.pStyleCostingStatus.CustomKey
--			WHERE (dbo.pStyleCosting.StyleID = @StyleID) AND (dbo.pStyleCosting.StyleCostingTypeID = 3)
--			ORDER BY dbo.pStyleCosting.StyleCostingTypeID ASC
--		END	
--	ELSE IF @TradePartnerClass = 3
--		BEGIN
--			SELECT dbo.pStyleCosting.StyleCostingID, dbo.pStyleCosting.StyleID, dbo.pStyleCostingType.StyleCostingType, dbo.pStyleCostingStatus.Custom, 
--				dbo.pStyleCostingStatus.CustomIcon, dbo.pStyleCostingType.StyleCostingTypeID
--			FROM  dbo.pStyleCosting WITH (NOLOCK) INNER JOIN
--				dbo.pStyleCostingType WITH (NOLOCK) ON dbo.pStyleCosting.StyleCostingTypeID = dbo.pStyleCostingType.StyleCostingTypeID INNER JOIN
--				dbo.pStyleCostingStatus WITH (NOLOCK) ON dbo.pStyleCosting.StyleCostingStatus = dbo.pStyleCostingStatus.CustomKey
--			WHERE (dbo.pStyleCosting.StyleID = @StyleID) AND (dbo.pStyleCosting.StyleCostingTypeID = 4)
--			ORDER BY dbo.pStyleCosting.StyleCostingTypeID ASC
--		END		
--	ELSE IF @TradePartnerClass = 4
--		BEGIN
--			SELECT dbo.pStyleCosting.StyleCostingID, dbo.pStyleCosting.StyleID, dbo.pStyleCostingType.StyleCostingType, dbo.pStyleCostingStatus.Custom, 
--				dbo.pStyleCostingStatus.CustomIcon, dbo.pStyleCostingType.StyleCostingTypeID
--			FROM  dbo.pStyleCosting WITH (NOLOCK) INNER JOIN
--				dbo.pStyleCostingType WITH (NOLOCK) ON dbo.pStyleCosting.StyleCostingTypeID = dbo.pStyleCostingType.StyleCostingTypeID INNER JOIN
--				dbo.pStyleCostingStatus WITH (NOLOCK) ON dbo.pStyleCosting.StyleCostingStatus = dbo.pStyleCostingStatus.CustomKey
--			WHERE (dbo.pStyleCosting.StyleID = @StyleID) AND (dbo.pStyleCosting.StyleCostingTypeID <> 1)
--			ORDER BY dbo.pStyleCosting.StyleCostingTypeID ASC
--		END	
--	ELSE
--		BEGIN
--			SELECT dbo.pStyleCosting.StyleCostingID, dbo.pStyleCosting.StyleID, dbo.pStyleCostingType.StyleCostingType, dbo.pStyleCostingStatus.Custom, 
--				dbo.pStyleCostingStatus.CustomIcon, dbo.pStyleCostingType.StyleCostingTypeID
--			FROM  dbo.pStyleCosting WITH (NOLOCK) INNER JOIN
--				dbo.pStyleCostingType WITH (NOLOCK) ON dbo.pStyleCosting.StyleCostingTypeID = dbo.pStyleCostingType.StyleCostingTypeID INNER JOIN
--				dbo.pStyleCostingStatus WITH (NOLOCK) ON dbo.pStyleCosting.StyleCostingStatus = dbo.pStyleCostingStatus.CustomKey
--			WHERE (dbo.pStyleCosting.StyleID = @StyleID)
--			ORDER BY dbo.pStyleCosting.StyleCostingTypeID ASC
--		END
--END
--ELSE
--BEGIN
--	IF @TradePartnerClass = 1 
--		BEGIN
--			SELECT dbo.pStyleCosting.StyleCostingID, dbo.pStyleCosting.StyleID, dbo.pStyleCostingType.StyleCostingType, dbo.pStyleCostingStatus.Custom, 
--				dbo.pStyleCostingStatus.CustomIcon, dbo.pStyleCostingType.StyleCostingTypeID
--			FROM  dbo.pStyleCosting WITH (NOLOCK) INNER JOIN
--				dbo.pStyleCostingType WITH (NOLOCK) ON dbo.pStyleCosting.StyleCostingTypeID = dbo.pStyleCostingType.StyleCostingTypeID INNER JOIN
--				dbo.pStyleCostingStatus WITH (NOLOCK) ON dbo.pStyleCosting.StyleCostingStatus = dbo.pStyleCostingStatus.CustomKey
--			WHERE (dbo.pStyleCosting.StyleID = @StyleID) AND (dbo.pStyleCosting.StyleCostingTypeID = 1)
--				AND dbo.pStyleCosting.StyleSeasonYearID = @StyleSeasonYearID
--			ORDER BY dbo.pStyleCosting.StyleCostingTypeID ASC
--		END	
--	ELSE IF @TradePartnerClass = 2
--		BEGIN
--			SELECT dbo.pStyleCosting.StyleCostingID, dbo.pStyleCosting.StyleID, dbo.pStyleCostingType.StyleCostingType, dbo.pStyleCostingStatus.Custom, 
--				dbo.pStyleCostingStatus.CustomIcon, dbo.pStyleCostingType.StyleCostingTypeID
--			FROM  dbo.pStyleCosting WITH (NOLOCK) INNER JOIN
--				dbo.pStyleCostingType WITH (NOLOCK) ON dbo.pStyleCosting.StyleCostingTypeID = dbo.pStyleCostingType.StyleCostingTypeID INNER JOIN
--				dbo.pStyleCostingStatus WITH (NOLOCK) ON dbo.pStyleCosting.StyleCostingStatus = dbo.pStyleCostingStatus.CustomKey
--			WHERE (dbo.pStyleCosting.StyleID = @StyleID) AND (dbo.pStyleCosting.StyleCostingTypeID = 3)
--				AND dbo.pStyleCosting.StyleSeasonYearID = @StyleSeasonYearID
--			ORDER BY dbo.pStyleCosting.StyleCostingTypeID ASC
--		END	
--	ELSE IF @TradePartnerClass = 3
--		BEGIN
--			SELECT dbo.pStyleCosting.StyleCostingID, dbo.pStyleCosting.StyleID, dbo.pStyleCostingType.StyleCostingType, dbo.pStyleCostingStatus.Custom, 
--				dbo.pStyleCostingStatus.CustomIcon, dbo.pStyleCostingType.StyleCostingTypeID
--			FROM  dbo.pStyleCosting WITH (NOLOCK) INNER JOIN
--				dbo.pStyleCostingType WITH (NOLOCK) ON dbo.pStyleCosting.StyleCostingTypeID = dbo.pStyleCostingType.StyleCostingTypeID INNER JOIN
--				dbo.pStyleCostingStatus WITH (NOLOCK) ON dbo.pStyleCosting.StyleCostingStatus = dbo.pStyleCostingStatus.CustomKey
--			WHERE (dbo.pStyleCosting.StyleID = @StyleID) AND (dbo.pStyleCosting.StyleCostingTypeID = 4)
--				AND dbo.pStyleCosting.StyleSeasonYearID = @StyleSeasonYearID
--			ORDER BY dbo.pStyleCosting.StyleCostingTypeID ASC
--		END		
--	ELSE IF @TradePartnerClass = 4
--		BEGIN
--			SELECT dbo.pStyleCosting.StyleCostingID, dbo.pStyleCosting.StyleID, dbo.pStyleCostingType.StyleCostingType, dbo.pStyleCostingStatus.Custom, 
--				dbo.pStyleCostingStatus.CustomIcon, dbo.pStyleCostingType.StyleCostingTypeID
--			FROM  dbo.pStyleCosting WITH (NOLOCK) INNER JOIN
--				dbo.pStyleCostingType WITH (NOLOCK) ON dbo.pStyleCosting.StyleCostingTypeID = dbo.pStyleCostingType.StyleCostingTypeID INNER JOIN
--				dbo.pStyleCostingStatus WITH (NOLOCK) ON dbo.pStyleCosting.StyleCostingStatus = dbo.pStyleCostingStatus.CustomKey
--			WHERE (dbo.pStyleCosting.StyleID = @StyleID) AND (dbo.pStyleCosting.StyleCostingTypeID <> 1)
--				AND dbo.pStyleCosting.StyleSeasonYearID = @StyleSeasonYearID
--			ORDER BY dbo.pStyleCosting.StyleCostingTypeID ASC
--		END	
--	ELSE
--		BEGIN
--			SELECT dbo.pStyleCosting.StyleCostingID, dbo.pStyleCosting.StyleID, dbo.pStyleCostingType.StyleCostingType, dbo.pStyleCostingStatus.Custom, 
--				dbo.pStyleCostingStatus.CustomIcon, dbo.pStyleCostingType.StyleCostingTypeID
--			FROM  dbo.pStyleCosting WITH (NOLOCK) INNER JOIN
--				dbo.pStyleCostingType WITH (NOLOCK) ON dbo.pStyleCosting.StyleCostingTypeID = dbo.pStyleCostingType.StyleCostingTypeID INNER JOIN
--				dbo.pStyleCostingStatus WITH (NOLOCK) ON dbo.pStyleCosting.StyleCostingStatus = dbo.pStyleCostingStatus.CustomKey
--			WHERE (dbo.pStyleCosting.StyleID = @StyleID)
--				AND dbo.pStyleCosting.StyleSeasonYearID = @StyleSeasonYearID
--			ORDER BY dbo.pStyleCosting.StyleCostingTypeID ASC
--		END
--END



/*Show only the Costing Types that should be available for this type of Agent, based upon "Partner Class" (BitMask for Multi-select).*/

IF @SeasonYearID IS NOT NULL
BEGIN
	SELECT dbo.pStyleCosting.StyleCostingID, dbo.pStyleCosting.StyleID, dbo.pStyleCostingType.StyleCostingType, dbo.pStyleCostingStatus.Custom, 
		dbo.pStyleCostingStatus.CustomIcon, dbo.pStyleCostingType.StyleCostingTypeID
	FROM  dbo.pStyleCosting WITH (NOLOCK) INNER JOIN
		dbo.pStyleCostingType WITH (NOLOCK) ON dbo.pStyleCosting.StyleCostingTypeID = dbo.pStyleCostingType.StyleCostingTypeID INNER JOIN
		dbo.pStyleCostingStatus WITH (NOLOCK) ON dbo.pStyleCosting.StyleCostingStatus = dbo.pStyleCostingStatus.CustomKey
	WHERE (dbo.pStyleCosting.StyleID = @StyleID) 
		AND ((power(2,(dbo.pStyleCosting.StyleCostingTypeID - 1)) & CAST(@TradePartnerClass AS INT)) <> 0)
		AND dbo.pStyleCosting.StyleSeasonYearID = @StyleSeasonYearID
	ORDER BY dbo.pStyleCosting.StyleCostingTypeID ASC
END
ELSE
BEGIN
	SELECT dbo.pStyleCosting.StyleCostingID, dbo.pStyleCosting.StyleID, dbo.pStyleCostingType.StyleCostingType, dbo.pStyleCostingStatus.Custom, 
		dbo.pStyleCostingStatus.CustomIcon, dbo.pStyleCostingType.StyleCostingTypeID
	FROM  dbo.pStyleCosting WITH (NOLOCK) INNER JOIN
		dbo.pStyleCostingType WITH (NOLOCK) ON dbo.pStyleCosting.StyleCostingTypeID = dbo.pStyleCostingType.StyleCostingTypeID INNER JOIN
		dbo.pStyleCostingStatus WITH (NOLOCK) ON dbo.pStyleCosting.StyleCostingStatus = dbo.pStyleCostingStatus.CustomKey
	WHERE (dbo.pStyleCosting.StyleID = @StyleID) 
		AND ((power(2,(dbo.pStyleCosting.StyleCostingTypeID - 1)) & CAST(@TradePartnerClass AS INT)) <> 0)
	ORDER BY dbo.pStyleCosting.StyleCostingTypeID ASC
END
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03167'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03167', GetDate())
END
GO	