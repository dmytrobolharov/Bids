IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCosting_INSERT2]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleCosting_INSERT2]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_StyleCosting_INSERT2](
	@StyleCostingId UNIQUEIDENTIFIER 
	,@StyleId UNIQUEIDENTIFIER 
	,@StyleCostingTypeId INT
	,@StyleCostingDate DATETIME
	,@StyleCostingStatus NVARCHAR(200)
	,@CreatedBy NVARCHAR(200)
	,@CreatedDate DATETIME
	,@StyleSeasonYearID UNIQUEIDENTIFIER
	,@BOMWorkflowItemID UNIQUEIDENTIFIER 
	,@BOLWorkflowItemID UNIQUEIDENTIFIER 
)

AS


/************************/
/*Declare variables.	*/
/************************/
--General
DECLARE @Count INT

--pStyleCostingHeader
DECLARE @StyleCostingHeaderId UNIQUEIDENTIFIER
DECLARE @StyleCostingCustomField3 INT
DECLARE @StyleCostingCustomField4 INT
DECLARE @StyleCostingCustomField15 DECIMAL(18, 5)
DECLARE @StyleCostingCustomField16 DECIMAL(18, 3)

DECLARE @StyleBOMDimensionId UNIQUEIDENTIFIER
DECLARE @StyleNBOLHeaderId UNIQUEIDENTIFIER

SELECT @StyleBOMDimensionId = StyleBOMDimensionID FROM pStyleBOMDimension WHERE WorkFlowItemID = @BOMWorkflowItemID
SELECT @StyleNBOLHeaderId = StyleNBOLHeaderID FROM pStyleNBOLHeader WHERE WorkFlowItemID = @BOLWorkflowItemID

/****************************************************************/
/*Get some initial pulls of data from the costing header area.	*/
/****************************************************************/
SELECT @StyleCostingHeaderId = StyleCostingHeaderId
	,@StyleCostingCustomField3 = ISNULL(StyleCostingCustomField6, 0)
	,@StyleCostingCustomField4 = ISNULL(StyleCostingCustomField7, 0)
	,@StyleCostingCustomField15 = ISNULL(StyleCostingCustomField1, 0)
	,@StyleCostingCustomField16 = ISNULL(StyleCostingCustomField2, 0)
FROM pStyleCostingHeader
WHERE StyleID = @StyleID
	AND StyleSeasonYearID = @StyleSeasonYearID


/************************************/
/*INSERT the pStyleCosting record 	*/
/************************************/
INSERT INTO pStyleCosting
	(StyleCostingID, StyleID, StyleCostingTypeID, StyleCostingDate, StyleCostingStatus, StyleCostingHeaderId, StyleCostingName,
	CUser, CDate, MUser, MDate, Active, StyleSeasonYearID, StyleBOMDimensionID, StyleNBOLHeaderID, 
	StyleCostingCustomField3, StyleCostingCustomField4, StyleCostingCustomField15, StyleCostingCustomField16)
VALUES
	(@StyleCostingId, @StyleId, @StyleCostingTypeId, @StyleCostingDate, @StyleCostingStatus, @StyleCostingHeaderId, 'SYSTEM COSTSHEET',
	@CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate, 1, @StyleSeasonYearID, @StyleBOMDimensionId, @StyleNBOLHeaderId, 
	@StyleCostingCustomField3, @StyleCostingCustomField4, @StyleCostingCustomField15, @StyleCostingCustomField16)
/************************************/


/*****************************************************/
/*INSERT the pStyleCostingScenarioItems records 	*/
/****************************************************/
DECLARE @CountScenarios INT = 3
DECLARE @i INT = 1

DECLARE @StyleCostingName NVARCHAR(100)

WHILE @i <= @CountScenarios
BEGIN

	DECLARE @StyleCostingScenarioItemsID UNIQUEIDENTIFIER = NEWID()
	
	SET @StyleCostingName = 'COSTSHEET NAME ' + CAST (@i AS NVARCHAR(2))

	INSERT INTO pStyleCostingScenarioItems
		(StytleCostingScenarioItemsID, StyleCostingScenarioNo, StyleCostingName, 
		StyleCostingID, StyleID, StyleCostingTypeID, StyleCostingDate, StyleCostingStatus, StyleCostingHeaderId, 
		CUser, CDate, MUser, MDate, Active, StyleSeasonYearID, StyleBOMDimensionID, StyleNBOLHeaderID, 
		StyleCostingCustomField3, StyleCostingCustomField4, StyleCostingCustomField15, StyleCostingCustomField16)
	VALUES
		(@StyleCostingScenarioItemsID, @i, @StyleCostingName, 
		@StyleCostingId, @StyleId, @StyleCostingTypeId, @StyleCostingDate, @StyleCostingStatus, @StyleCostingHeaderId, 
		@CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate, 1, @StyleSeasonYearID, @StyleBOMDimensionId, @StyleNBOLHeaderId, 
		@StyleCostingCustomField3, @StyleCostingCustomField4, @StyleCostingCustomField15, @StyleCostingCustomField16)

	-- set SystemCostsheet 
	IF @i = 1
		UPDATE pStyleCosting SET StyleCostingScenarioItemsId = @StyleCostingScenarioItemsID WHERE StyleCostingID = @StyleCostingId
		
	
	-- insert to pstyleCostingBOM records for particular StytleCostingScenario
	IF @BOMWorkflowItemID IS NOT NULL
		EXEC spx_StyleCostingBOM_INSERT
				@StyleCostingScenarioItemsID,
				@StyleId,
				@BOMWorkflowItemID,
				@CreatedBy,
				@CreatedDate

	-- insert to pstyleCostingBOL records for particular StytleCostingScenario
	IF @BOLWorkflowItemID IS NOT NULL
		EXEC spx_StyleCostingBOL_INSERT
				@StyleCostingScenarioItemsID,
				@StyleId,
				@BOLWorkflowItemID,
				@CreatedBy,
				@CreatedDate


	SET @i = @i + 1

END

GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03906', GetDate())
GO
