
/****** Object:  StoredProcedure spx_StyleCostingHeader_INSERT    Script Date: 03/08/2010 13:17:46 ******/

ALTER PROCEDURE spx_StyleCostingHeader_INSERT(
@StyleID uniqueidentifier,
@ModifiedBy varchar(200),
@ModifiedDate datetime ,
@StyleSeasonYearID UNIQUEIDENTIFIER 
)
AS 

-- /************************************************************
-- Alter By Daniel Pak on 03/07/10.
-- Add seasonality to style costing
-- *************************************************************/

DECLARE @Count INT 
IF @StyleSeasonYearID IS NULL 
	SELECT @Count = COUNT(*) FROM pStyleCostingHeader WHERE StyleID = @StyleID
ELSE 
	SELECT @Count = COUNT(*) FROM pStyleCostingHeader WHERE StyleID = @StyleID AND StyleSeasonYearID = @StyleSeasonYearID


/*INSERT the pStyleCostingHeader record the this Style.*/
IF @Count = 0
BEGIN
	INSERT INTO pStyleCostingHeader (StyleID, StyleCostingCustomField1, StyleCostingCustomField2, StyleCostingCustomField3, 
	StyleCostingCustomField4, CUser, MUser, CDate, MDate, StyleSeasonYearID) 
    VALUES  (@StyleID, 0, 0, 0, 0, @ModifiedBy, @ModifiedBy, @ModifiedDate, @ModifiedDate, @StyleSeasonYearID)
END

--DECLARE @Count INT 
--
--/***********************************************
--New statements added by Ryan Cabanas on 8/26/08.
--************************************************/
--
--IF @StyleSeasonYearID IS NULL 
--	SELECT @Count = COUNT(*) FROM pStyleCostingHeader WHERE StyleID = @StyleID
--ELSE 
--	SELECT @Count = COUNT(*) FROM pStyleCostingHeader WHERE StyleID = @StyleID AND StyleSeasonYearID = @StyleSeasonYearID
--
--
--/*INSERT the pStyleCostingHeader record the this Style.*/
--IF @Count = 0
--BEGIN
--	INSERT INTO pStyleCostingHeader (StyleID, StyleCostingCustomField1, StyleCostingCustomField2, StyleCostingCustomField3, 
--	StyleCostingCustomField4, CUser, MUser, CDate, MDate, StyleSeasonYearID) 
--    VALUES  (@StyleID, 0, 0, 0, 0, @ModifiedBy, @ModifiedBy, @ModifiedDate, @ModifiedDate, @StyleSeasonYearID)
--END
--
--/*Automatically add all costing types.*/
--BEGIN
--	/*Create temp table.*/
--	CREATE TABLE #temp(
--		StyleCostingTypeID int)
--
--	/*Get the Costing Types that have already been added for this Style.*/
--	IF @StyleSeasonYearID IS NULL 
--		INSERT INTO #temp(StyleCostingTypeID)
--		SELECT StyleCostingTypeID
--		FROM pStyleCosting
--		WHERE StyleID = @StyleID AND @StyleSeasonYearID IS NULL
--	ELSE 
--		INSERT INTO #temp(StyleCostingTypeID)
--		SELECT StyleCostingTypeID
--		FROM pStyleCosting
--		WHERE StyleID = @StyleID
--		AND StyleSeasonYearID = @StyleSeasonYearID
--
--
--
--	/*INSERT all of the Costing Types right up front because users won't do any work on these records, but they need them and we don't need to make them
--	add them manually.*/
--	INSERT INTO pStyleCosting(
--		StyleCostingID
--		,StyleID
--		,StyleCostingTypeID
--		,StyleCostingFreightTypeID
--		,StyleQuotaDutyID
--		,StyleCostingDate
--		,StyleCostingStatus
--		,CUser
--		,CDate
--		,MUser
--		,MDate
--		,Active
--		,StyleSeasonYearID )
--	SELECT
--		NewID() AS StyleCostingID
--		,@StyleID
--		,pStyleCostingType.StyleCostingTypeID
--		,1
--		,'00000000-0000-0000-0000-000000000000' AS StyleQuotaDutyID
--		,@ModifiedDate AS StyleCostingDate
--		,0
--		,@ModifiedBy AS CUser
--		,@ModifiedDate AS CDate
--		,@ModifiedBy AS MUser
--		,@ModifiedDate AS MDate
--		,1
--		,@StyleSeasonYearID
--	FROM	pStyleCostingType
--		LEFT OUTER JOIN #temp ON	pStyleCostingType.StyleCostingTypeID = #temp.StyleCostingTypeID
--	WHERE	#temp.StyleCostingTypeID IS NULL
--
--	/*Drop temp table.*/
--	DROP TABLE #temp
--END



--
--/************************************************************
--Original statements commented out by Ryan Cabanas on 8/26/08.
--*************************************************************/
--
--IF (SELECT COUNT(*) FROM pStyleCostingHeader WHERE StyleID = @StyleID) = 0
--BEGIN
--	INSERT INTO pStyleCostingHeader (StyleID, StyleCostingCustomField1, 
--		StyleCostingCustomField2, StyleCostingCustomField3, StyleCostingCustomField4, 
--		StyleCostingCustomField8, StyleCostingCustomField18, CUser, MUser, CDate, MDate) 
--                VALUES  (@StyleID, 0, 0, 0, 0, 0, 0, @ModifiedBy, @ModifiedBy, @ModifiedDate, @ModifiedDate)
--END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '019', GetDate())
GO


