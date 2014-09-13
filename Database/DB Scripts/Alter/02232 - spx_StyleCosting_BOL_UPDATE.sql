IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCosting_BOL_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleCosting_BOL_UPDATE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleCosting_BOL_UPDATE]
	@StyleSourcingId uniqueidentifier,
	@StyleSet int,
	@StyleCostingId uniqueidentifier
AS

DECLARE	@ExceptionId_Standard as nvarchar (50) = '00000000-0000-0000-0000-000000000000' -- Standard BOL Page (not exception)

DECLARE @StyleID as nvarchar (50)
DECLARE @VendorId as nvarchar (50)
DECLARE @SeasonYearID as nvarchar (50)
DECLARE @ExchangeRateID as nvarchar (50)

DECLARE @ConvCurr as nvarchar(5)
DECLARE @BOLCosting as nvarchar(20)

BEGIN

CREATE TABLE #tmp_bol_list(
	PageOperationId uniqueidentifier NOT NULL,
	Code nvarchar(200) NULL,
	Name nvarchar(200) NULL,
	OpToMacroId uniqueidentifier NULL,
	Sort nvarchar(5) NULL,
	Sort1 uniqueidentifier NULL,
	Sort2 nvarchar(5) NULL,		
	Comments nvarchar(200) NULL,
	ImageID uniqueidentifier NULL,
	ImageType nvarchar(50) NULL,
	SAM numeric(10, 2) NULL,
	Coef numeric(10, 2) NULL,
	Adj nvarchar(20) NULL,
	BaseRateId uniqueidentifier NULL,
	MachineId uniqueidentifier NULL,
	IsLinked int NULL,
	MacroId uniqueidentifier NULL,
	OperationId uniqueidentifier NULL,
	MacroParentId uniqueidentifier NULL,
	StyleID uniqueidentifier NULL,
	StyleSet int NULL,	
--	SetName nvarchar(50) NULL,
	IsException int NULL,
	ExceptionId uniqueidentifier NULL,
	ExceptionName nvarchar(200) NULL,
--	StyleColorID uniqueidentifier NULL,
	SourceBOLId uniqueidentifier NULL,
	TradePartnerId uniqueidentifier NULL,
	TradePartnerVendorId uniqueidentifier NULL,	
	SourcingAdj numeric(10, 2) NULL,
	Totaltime numeric(10,2) NULL,
	IsFixed int NULL,
	FactoryRate numeric(10,2) NULL,
	Cost numeric(10,2) NULL,
	FactoryCurr nvarchar(5) NULL,
	CurrRate numeric(10,2) NULL,
	ConvCurrRate numeric(10,2) NULL,
	ConvCurr nvarchar(5) NULL,
	ConvCost numeric(10,2) NULL,
	sTotaltime nvarchar(50) NULL,			-- variables
	sCost nvarchar(50) NULL,				-- for
	sConvCost nvarchar(50) NULL				-- output
	);

CREATE TABLE #tmp_bol_list_Total(
	StyleSet int,
--	SetName nvarchar(50) NULL,
	ExceptionId uniqueidentifier NULL,
	ExceptionName nvarchar(200) NULL,
--	StyleColorID uniqueidentifier NULL,
	Sort int NULL,
	BaseRateId uniqueidentifier NULL,
	BaseRateCode nvarchar(200) NULL,
	Totaltime numeric(10,2) NULL,
	ConvCost numeric(10,2) NULL,
	ConvCurr nvarchar(5) NULL,
	sTotaltime nvarchar(50) NULL,			-- variables
	sConvCost nvarchar(50) NULL				-- for output
)

-- Get StyleID from pStyleSourcing table
SELECT  @StyleID = StyleID 
FROM	pStyleSourcing	
WHERE	StyleSourcingID = @StyleSourcingId

-- Get VendorID from pStyleSourcing table
SELECT  @VendorId = TradePartnerVendorID 
FROM	pStyleSourcing	
WHERE	StyleSourcingID = @StyleSourcingId

-- Get SeasonYearID from pStyleSourcing table
SELECT  @SeasonYearID = pStyleSeasonYear.SeasonYearID 
FROM	pStyleSourcing	
	INNER JOIN pStyleSeasonYear ON pStyleSourcing.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
WHERE	StyleSourcingID = @StyleSourcingId

-- Get ExchangeRateID from pStyleSourcing table
SELECT  @ExchangeRateID = pStyleSourcing.Custom2
FROM	pStyleSourcing	
WHERE	StyleSourcingID = @StyleSourcingId

-- insert into temp table BOL list for Standard page
INSERT INTO #tmp_bol_list (PageOperationId, Code, Name, OpToMacroId, Sort, Sort1, Sort2, Comments, ImageID,
	ImageType, SAM, Coef, Adj, BaseRateId, MachineId, IsLinked, MacroId, OperationId, MacroParentId,
	StyleID, StyleSet, IsException, ExceptionId, ExceptionName, SourceBOLId, TradePartnerId, TradePartnerVendorId, SourcingAdj)
SELECT s.*, @ExceptionId_Standard, 'Standart', b.SourceBOLId, b.TradePartnerId, b.TradeVendorId, b.Adj AS SourcingAdj
		FROM vw_StyleBOL_SELECT s
		LEFT JOIN pStyleSourcingBOL b ON s.PageOperationId = b.PageOperationId
		AND ISNULL(s.OpToMacroId, '00000000-0000-0000-0000-000000000000') = ISNULL(b.OpToMacroId, '00000000-0000-0000-0000-000000000000')
		AND b.StyleSourcingId = @StyleSourcingId
		AND ISNULL(b.ExceptionId, '00000000-0000-0000-0000-000000000000') = @ExceptionId_Standard
		WHERE IsException = 0 AND s.StyleID = @StyleID AND s.StyleSet = @StyleSet
		ORDER BY StyleSet ASC, Sort ASC, Sort1 ASC, Sort2 ASC

-- insert into temp table BOL list for Exceptions pages
INSERT INTO #tmp_bol_list (PageOperationId, Code, Name, OpToMacroId, Sort, Sort1, Sort2, Comments, ImageID,
	ImageType, SAM, Coef, Adj, BaseRateId, MachineId, IsLinked, MacroId, OperationId, MacroParentId,
	StyleID, StyleSet, IsException, ExceptionId, ExceptionName, SourceBOLId, TradePartnerId, TradePartnerVendorId, SourcingAdj)
SELECT s.*, e.BOLExceptionId, e.BOLExceptionName, b.SourceBOLId, b.TradePartnerId, b.TradeVendorId, b.Adj AS SourcingAdj
		FROM vw_StyleBOL_SELECT s
		LEFT JOIN pStyleBOLException e ON s.StyleID = e.StyleId AND s.StyleSet = e.StyleSet
		LEFT JOIN pStyleSourcingBOL b ON s.PageOperationId = b.PageOperationId
		AND ISNULL(s.OpToMacroId, '00000000-0000-0000-0000-000000000000') = ISNULL(b.OpToMacroId, '00000000-0000-0000-0000-000000000000')
		AND b.StyleSourcingId = @StyleSourcingId
		AND ISNULL(b.ExceptionId, '00000000-0000-0000-0000-000000000000') = e.BOLExceptionId
		WHERE s.PageOperationId NOT IN(SELECT PageOperationId FROM pStyleBOLExceptionEntries WHERE BOLExceptionId = e.BOLExceptionId) 
		AND s.StyleID = @StyleID AND s.StyleSet = @StyleSet
		ORDER BY StyleSet ASC, Sort ASC, Sort1 ASC, Sort2 ASC



-- set default vendor
UPDATE #tmp_bol_list SET TradePartnerVendorId = @VendorId WHERE TradePartnerVendorId IS NULL

-- calc total time
UPDATE #tmp_bol_list SET Totaltime = 
	CASE 
		WHEN #tmp_bol_list.MacroId IS NOT NULL AND #tmp_bol_list.IsLinked = 1 THEN
			(SELECT SUM(SAM) FROM pBOLOperations 
				INNER JOIN pBOLOpToMacro ON pBOLOperations.OperationId = pBOLOpToMacro.OperationId 
				WHERE pBOLOpToMacro.MacroId = #tmp_bol_list.MacroId)
		WHEN #tmp_bol_list.MacroId IS NOT NULL AND #tmp_bol_list.IsLinked = 0 THEN
			(SELECT SUM((S1.SAM * ISNULL(S1.Coef, 1)) + (S1.SAM * ISNULL(S1.Coef, 1) * ISNULL(cast(S1.Adj AS numeric(10, 2)), 0) / 100))
				FROM pStyleBOLPageOperations AS S1
				WHERE S1.MacroParentId = #tmp_bol_list.PageOperationId)
		ELSE
			(#tmp_bol_list.SAM * ISNULL(#tmp_bol_list.Coef, 1) + #tmp_bol_list.SAM * ISNULL(#tmp_bol_list.Coef, 1) * ISNULL(cast(#tmp_bol_list.Adj AS numeric(10, 2)), 0) / 100)
		END
			
-- check if operation has fixed cost for this vendor
UPDATE #tmp_bol_list SET IsFixed = 
	CASE
		WHEN (SELECT opf.FixedCost FROM pBOLOperationFixed opf
				WHERE opf.OperationId = #tmp_bol_list.OperationId
				AND opf.TradePartnerVendorID = #tmp_bol_list.TradePartnerVendorId
				AND opf.SeasonYearId = @SeasonYearID) IS NOT NULL THEN
			1
		ELSE
			0
		END
			
-- get factory rate and factory currency by base rate
UPDATE #tmp_bol_list SET FactoryRate = 
	(SELECT fr.RateValue FROM pBOLFactoryRates fr 
		WHERE fr.TradePartnerVendorID = #tmp_bol_list.TradePartnerVendorId
		AND fr.SeasonYearId = @SeasonYearID
		AND fr.BaseRateId = #tmp_bol_list.BaseRateId),
				FactoryCurr = 
	(SELECT fr.CurrencyCode FROM vw_pBOLFactory_Rates fr 
		WHERE fr.TradePartnerVendorID = #tmp_bol_list.TradePartnerVendorId
		AND fr.SeasonYearId = @SeasonYearID
		AND fr.BaseRateId = #tmp_bol_list.BaseRateId)

-- calc cost in factory currency
UPDATE #tmp_bol_list SET Cost = ( Totaltime + (Totaltime * ISNULL(SourcingAdj, 0) / 100) ) * FactoryRate

-- select cost for fixed operation
UPDATE #tmp_bol_list SET Cost = 
	(SELECT opf.FixedCost FROM pBOLOperationFixed opf
		WHERE opf.OperationId = #tmp_bol_list.OperationId
		AND opf.TradePartnerVendorID = #tmp_bol_list.TradePartnerVendorId
		AND opf.SeasonYearId = @SeasonYearID)
	WHERE #tmp_bol_list.IsFixed = 1
UPDATE #tmp_bol_list SET FactoryCurr = 
	(SELECT ct.CustomKey FROM sCurrencyType ct INNER JOIN uTradePartnerVendor v
		ON ct.CustomID = v.CurrencyType
		WHERE v.TradePartnerVendorID = @VendorId)
	WHERE #tmp_bol_list.IsFixed = 1 AND #tmp_bol_list.FactoryCurr IS NULL
	
-- select base currency of exchange rate
SET @ConvCurr = 
	(SELECT CurrencyType FROM vwx_Control_ExchangeRateItem
		WHERE ExchangeRateID = @ExchangeRateID
		AND BaseCurrency = 1)

UPDATE #tmp_bol_list SET ConvCurr = @ConvCurr

-- rate of converted currency
UPDATE #tmp_bol_list SET ConvCurrRate = 
	(SELECT Rate FROM vwx_Control_ExchangeRateItem
		WHERE ExchangeRateID = @ExchangeRateID
		AND BaseCurrency = 1)

-- rate of factory currency
UPDATE #tmp_bol_list SET CurrRate = 
	(SELECT TOP 1 Rate FROM vwx_Control_ExchangeRateItem
		WHERE ExchangeRateID = @ExchangeRateID
		AND CurrencyType = #tmp_bol_list.FactoryCurr
		AND #tmp_bol_list.FactoryCurr IS NOT NULL)
								
UPDATE #tmp_bol_list SET CurrRate = NULL WHERE CurrRate = '0.00'
								
-- calc converted cost for operations
UPDATE #tmp_bol_list SET ConvCost = Cost * ConvCurrRate / CurrRate
	WHERE MacroId IS NULL

-- calc converted cost for macro
UPDATE #tmp_bol_list SET ConvCost = 
	CASE
		WHEN (SELECT COUNT(*) from #tmp_bol_list as t1
				WHERE #tmp_bol_list.PageOperationId = t1.MacroParentId
				AND t1.ConvCost IS NULL) > 0 THEN
			NULL
		ELSE
			(SELECT SUM(t2.ConvCost) FROM #tmp_bol_list as t2
				WHERE #tmp_bol_list.PageOperationId = t2.MacroParentId)
		END	
		WHERE MacroId IS NOT NULL


-- insert data into temp total table and calc sum using group by Exceptions
INSERT #tmp_bol_list_Total (StyleSet, ExceptionId, ExceptionName, Totaltime, ConvCost, ConvCurr)
	SELECT StyleSet, ExceptionId, ExceptionName, SUM(Totaltime), SUM(ConvCost), @ConvCurr
	FROM #tmp_bol_list WHERE MacroId IS NULL
	GROUP BY StyleSet, ExceptionId, ExceptionName

-- calc average cost for all exceptions
SELECT @BOLCosting = cast (AVG(ConvCost) as decimal(18,2)) from #tmp_bol_list_Total

-- update data in costing table
UPDATE pStyleCosting 
SET StyleCostingCustomField29 = @BOLCosting,
	StyleCostingCustomField30 = @ConvCurr
WHERE StyleCostingID = @StyleCostingId




DROP TABLE #tmp_bol_list
DROP TABLE #tmp_bol_list_Total

END

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02232'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02232', GetDate())
END
GO