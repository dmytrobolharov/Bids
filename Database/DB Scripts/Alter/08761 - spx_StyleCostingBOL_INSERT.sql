IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCostingBOL_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleCostingBOL_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_StyleCostingBOL_INSERT](
	@StyleCostingScenarioItemsId UNIQUEIDENTIFIER 
	,@StyleId UNIQUEIDENTIFIER 
	,@BOLWorkflowItemID UNIQUEIDENTIFIER 
	,@CreatedBy NVARCHAR(200)
	,@CreatedDate DATETIME
)

AS
BEGIN

DECLARE @ExchangeRateItemID UNIQUEIDENTIFIER
DECLARE @ExchangeRateID UNIQUEIDENTIFIER
DECLARE @ConvCurrType NVARCHAR(5)
DECLARE @ConvCurrRate DECIMAL(18,4)

SELECT @ExchangeRateItemID = ExchangeRateItemID FROM pStyleNBOLHeader WHERE WorkFlowItemID = @BOLWorkflowItemID

SELECT @ConvCurrType = CurrencyType, @ExchangeRateID = ExchangeRateID, @ConvCurrRate = Rate 
FROM sExchangeRateItem WHERE ExchangeRateItemID = @ExchangeRateItemID

CREATE TABLE #tmpStyleBolItems
(
	[ExceptionId] uniqueidentifier NULL,
	[ExceptionName] [nvarchar](200) collate database_default NULL,
	[StyleNBOLItemID] [uniqueidentifier] NOT NULL,
	[StyleID] [uniqueidentifier] NULL,
	[StyleSet] [int] NULL,
	[Sort] [nvarchar](5) collate database_default NULL,
	[Sort1] [nvarchar](50) collate database_default NULL,
	[Sort2] [nvarchar](5) collate database_default NULL,
	[IsLinked] [int] NULL,
	[TemplateItemID] [uniqueidentifier] NULL,
	[OperationID] [uniqueidentifier] NULL,
	[MacroID] [uniqueidentifier] NULL,
	[ParentID] [uniqueidentifier] NULL,
	[Code] [nvarchar](200) collate database_default NULL,
	[Name] [nvarchar](200) collate database_default NULL,
	[ImageID] [uniqueidentifier] NULL,
	[ImageType] [nvarchar](10) collate database_default NULL,
	[Image] [nvarchar](200) collate database_default NULL,
	[MachineID] [uniqueidentifier] NULL,
	[OperationTypeID] [uniqueidentifier] NULL,
	[BaseRate] [decimal](18, 2) NULL,
	[CurrencyType] [nvarchar](5) NULL,
	[ConvBaseRate] [decimal](18, 2) NULL,
	[SAM] [decimal](18, 2) NULL,
	[Coef] [decimal](18, 2) NULL,
	[Adj] [decimal](18, 2) NULL,
	[TotalTime] [decimal](18, 2) NULL,
	[Total] [decimal](18, 2) NULL,
	[Comments] [nvarchar](800) collate database_default NULL,
	[CUser] [nvarchar](200) collate database_default NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) collate database_default NULL,
	[MDate] [datetime] NULL
)


/*****************************************************************/
/* INSERT standard (!!!) BOL list of operation to TMP table   *****/	
/* (Linked, Unlinked and Custom operations)                   *****/
/*****************************************************************/

INSERT INTO #tmpStyleBolItems(ExceptionId, ExceptionName,
		StyleNBOLItemID, StyleID, StyleSet,
		TemplateItemID, MacroID, OperationID, IsLinked, ImageID, ImageType,
		Code, Name, MachineID, OperationTypeID, BaseRate, CurrencyType, SAM, ParentID,
		Sort, Sort1, Sort2, Coef, Adj, Comments)

SELECT '00000000-0000-0000-0000-000000000000', 'Standard',
		sbi.StyleNBOLItemID, sbi.StyleID, sbi.StyleSet,
		ti.TemplateItemID, ti.MacroID, ti.OperationID, sbi.IsLinked, ti.ImageID, 
		ImageType = CASE
			WHEN sbi.MacroID IS NOT NULL THEN 'BOLMOP'
			WHEN sbi.OperationID IS NOT NULL THEN 'BOLOP'
		END,
		ti.Code, ti.Name, ti.MachineID, ti.OperationTypeID, 
		sbi.BaseRate, sbi.CurrencyType, sbi.SAM, ti.ParentID,
		sbi.Sort, Sort1 = CASE
			WHEN sbi.MacroID IS NOT NULL THEN sbi.TemplateItemID
			WHEN sbi.OperationID IS NOT NULL THEN sbi.ParentID
		END,
		sbi.Sort2, sbi.Coef, sbi.Adj, sbi.Comments
FROM pStyleNBOLItems sbi
	LEFT JOIN pNBOLTemplateItem ti ON sbi.TemplateItemID = ti.TemplateItemID
WHERE sbi.IsLinked = 1 
	AND sbi.WorkFlowItemID = @BOLWorkflowItemID
	AND sbi.StyleNBOLItemID NOT IN (SELECT StyleNBOLItemID FROM pStyleNBOLExceptionEntries WHERE ExceptionId = '00000000-0000-0000-0000-000000000000')

UNION

SELECT '00000000-0000-0000-0000-000000000000', 'Standard',
		sbi.StyleNBOLItemID, sbi.StyleID, sbi.StyleSet,
		sbi.TemplateItemID, sbi.MacroID, sbi.OperationID, sbi.IsLinked, sbi.ImageID, 
		ImageType = CASE
			WHEN sbi.MacroID IS NOT NULL THEN 'BOLMOP'
			WHEN sbi.OperationID IS NOT NULL THEN 'BOLOP'
		END,
		sbi.Code, sbi.Name, sbi.MachineID, sbi.OperationTypeID, sbi.BaseRate, sbi.CurrencyType, sbi.SAM, sbi.ParentID,
		sbi.Sort, Sort1 = CASE
			WHEN sbi.MacroID IS NOT NULL THEN sbi.TemplateItemID
			WHEN sbi.OperationID IS NOT NULL THEN sbi.ParentID
		END,
		sbi.Sort2, sbi.Coef, sbi.Adj, sbi.Comments
FROM pStyleNBOLItems sbi
WHERE (sbi.IsLinked = 0 OR sbi.IsLinked = -1)
	AND sbi.WorkFlowItemID = @BOLWorkflowItemID
	AND sbi.StyleNBOLItemID NOT IN (SELECT StyleNBOLItemID FROM pStyleNBOLExceptionEntries WHERE ExceptionId = '00000000-0000-0000-0000-000000000000')

ORDER BY Sort, Sort1, Sort2


-- calc Total
UPDATE #tmpStyleBolItems
SET TotalTime = SAM * ISNULL(Coef,1) + (SAM * ISNULL(Coef,1)) * ISNULL(Adj,0) / 100
WHERE MacroID IS NULL

--UPDATE #tmpStyleBolItems
--SET Total = TotalTime * BaseRate

/**** Calc converted Rate ****/
UPDATE #tmpStyleBolItems
SET ConvBaseRate = BaseRate * @ConvCurrRate / (SELECT TOP 1 Rate FROM sExchangeRateItem WHERE ExchangeRateID = @ExchangeRateID AND CurrencyType = #tmpStyleBolItems.CurrencyType)
WHERE MacroID IS NULL
AND CurrencyType IS NOT NULL AND CurrencyType <> ''

UPDATE #tmpStyleBolItems
SET ConvBaseRate = BaseRate
WHERE MacroID IS NULL
AND (CurrencyType IS NULL OR CurrencyType = '')

IF @ExchangeRateItemID IS NOT NULL
BEGIN
	UPDATE #tmpStyleBolItems
	SET Total = TotalTime * ConvBaseRate
END
ELSE
BEGIN
	UPDATE #tmpStyleBolItems
	SET Total = TotalTime * BaseRate
END
/**************************/

DECLARE @StyleNBOLHeaderID UNIQUEIDENTIFIER
SELECT @StyleNBOLHeaderID = StyleNBOLHeaderID FROM pStyleNBOLHeader 
WHERE WorkFlowItemID = @BOLWorkflowItemID


-- insert to pstyleCostingBOL records for particular StytleCostingScenario
INSERT INTO pstyleCostingBOL (StytleCostingScenarioItemsID, StyleID, StyleNBOLHeaderID,
		StyleNBOLItemId, OperationCode, OperationName, OperationTypeID, OperationCost, CurrencyType,
		CUser, CDate, MUser, MDate)
SELECT @StyleCostingScenarioItemsId, @StyleId, @StyleNBOLHeaderID,
		StyleNBOLItemID, Code, Name, OperationTypeID, 
		Total AS OperationCost, CurrencyType,
		@CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate
FROM #tmpStyleBolItems
WHERE MacroID IS NULL

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08761', GetDate())
GO
