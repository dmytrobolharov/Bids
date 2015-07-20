IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCosting_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleCosting_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_StyleCosting_INSERT](
	@StyleCostingId UNIQUEIDENTIFIER 
	,@StyleId UNIQUEIDENTIFIER 
	,@StyleCostingTypeId INT
	,@StyleCostingDate DATETIME
	,@StyleCostingStatus NVARCHAR(200)
	,@CreatedBy NVARCHAR(200)
	,@CreatedDate DATETIME
	,@StyleSeasonYearID UNIQUEIDENTIFIER 
)

AS


/************************/
/*Declare variables.	*/
/************************/
--General
DECLARE @Count INT

--pStyleCostingHeader
DECLARE @pStyleCosting_StyleCostingCustomField15 DECIMAL(18,3)
DECLARE @pStyleCosting_StyleCostingCustomField16 DECIMAL(18,3)


/****************************************************************/
/*Check to see if there is already a 'pStyleCosting' record.	*/
/****************************************************************/
IF(@StyleSeasonYearID IS NULL)
	BEGIN
		SELECT @Count = COUNT(*)
		FROM pStyleCosting
		WHERE StyleID = @StyleID AND StyleCostingHeaderId IS NULL
			AND StyleCostingTypeId = @StyleCostingTypeId
	END
ELSE
	BEGIN
		SELECT @Count = COUNT(*)
		FROM pStyleCosting
		WHERE StyleID = @StyleID AND StyleCostingHeaderId IS NULL
			AND StyleCostingTypeId = @StyleCostingTypeId
			AND StyleSeasonYearID = @StyleSeasonYearID
	END


/****************************************************************/
/*Get some initial pulls of data from the costing header area.	*/
/****************************************************************/
SELECT @pStyleCosting_StyleCostingCustomField15 = ISNULL(StyleCostingCustomField1, 0)
	,@pStyleCosting_StyleCostingCustomField16 = ISNULL(StyleCostingCustomField2, 0)
FROM pStyleCostingHeader
WHERE StyleID = @StyleID
	AND StyleSeasonYearID = @StyleSeasonYearID


/************************************************************************/
/*INSERT the pStyleCosting record for the Style, if one does not exist.	*/
/************************************************************************/
IF(@Count = 0)
	BEGIN
		/*Add the record to pStyleCosting.*/
		INSERT INTO pStyleCosting
			(StyleCostingID, StyleID, StyleCostingTypeID, StyleCostingDate, StyleCostingStatus, CUser, CDate,
			MUser, MDate, Active, StyleSeasonYearID,
			StyleCostingCustomField15, StyleCostingCustomField16)
		VALUES
			(@StyleCostingId, @StyleId, @StyleCostingTypeId, @StyleCostingDate, @StyleCostingStatus, @CreatedBy, @CreatedDate,
			@CreatedBy, @CreatedDate, 1, @StyleSeasonYearID,
			@pStyleCosting_StyleCostingCustomField15, @pStyleCosting_StyleCostingCustomField16)
	END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05339', GetDate())
GO
