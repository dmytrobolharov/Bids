IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOLSourcing_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOLSourcing_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_Style_Sourcing_BOL_SELECT]    Script Date: 11/11/2011 13:09:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Style_Sourcing_BOL_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Style_Sourcing_BOL_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_Style_Sourcing_BOL_SELECT]    Script Date: 11/11/2011 13:09:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_Style_Sourcing_BOL_SELECT] 
	@StyleID as nvarchar (50),
	@StyleSet as int,
	@ExchangeRateID as nvarchar (50),
	@StyleSourcingId as nvarchar (50), 
	@VendorId as nvarchar (50),
	@SeasonYearID as nvarchar (50),
	@ExceptionId as nvarchar (50)
AS

DECLARE @ConvCurr as nvarchar(5) -- base currency of exchange rate

BEGIN
CREATE TABLE #TMP(
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
	IsException int NULL,
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
	);

CREATE TABLE #TMP_total(
	Sort int NOT NULL,
	BaseRateId uniqueidentifier NULL,
	BaseRateCode nvarchar(200) NULL,
	Totaltime numeric(10,2) NULL,
	ConvCost numeric(10,2) NULL,
	ConvCurr nvarchar(5) NULL,
	sTotaltime nvarchar(50) NULL,	-- variables
	sConvCost nvarchar(50) NULL		-- for output
)

-- select BOL list with sourcing data for one BOL page (standart or some exception)
IF @ExceptionId = '00000000-0000-0000-0000-000000000000'  -- standart
BEGIN
	INSERT INTO #TMP (PageOperationId, Code, Name, OpToMacroId, Sort, Sort1, Sort2, Comments, ImageID,
		ImageType, SAM, Coef, Adj, BaseRateId, MachineId, IsLinked, MacroId, OperationId, MacroParentId,
		StyleID, StyleSet, IsException, SourceBOLId, TradePartnerId, TradePartnerVendorId, SourcingAdj)
	SELECT s.*, b.SourceBOLId, b.TradePartnerId, b.TradeVendorId, b.Adj AS SourcingAdj
			FROM vw_StyleBOL_SELECT s
			LEFT JOIN pStyleSourcingBOL b ON s.PageOperationId = b.PageOperationId
			AND ISNULL(s.OpToMacroId, '00000000-0000-0000-0000-000000000000') = ISNULL(b.OpToMacroId, '00000000-0000-0000-0000-000000000000')
			AND b.StyleSourcingId = @StyleSourcingId
			AND ISNULL(b.ExceptionId, '00000000-0000-0000-0000-000000000000') = @ExceptionId
			WHERE IsException = 0 AND StyleID = @StyleID AND StyleSet = @StyleSet
			ORDER BY Sort ASC, Sort1 ASC, Sort2 ASC
END
ELSE -- some exception
BEGIN
	INSERT INTO #TMP (PageOperationId, Code, Name, OpToMacroId, Sort, Sort1, Sort2, Comments, ImageID,
		ImageType, SAM, Coef, Adj, BaseRateId, MachineId, IsLinked, MacroId, OperationId, MacroParentId,
		StyleID, StyleSet, IsException, SourceBOLId, TradePartnerId, TradePartnerVendorId, SourcingAdj)
	SELECT s.*, b.SourceBOLId, b.TradePartnerId, b.TradeVendorId, b.Adj AS SourcingAdj
			FROM vw_StyleBOL_SELECT s
			LEFT JOIN pStyleSourcingBOL b ON s.PageOperationId = b.PageOperationId
			AND ISNULL(s.OpToMacroId, '00000000-0000-0000-0000-000000000000') = ISNULL(b.OpToMacroId, '00000000-0000-0000-0000-000000000000')
			AND b.StyleSourcingId = @StyleSourcingId
			AND ISNULL(b.ExceptionId, '00000000-0000-0000-0000-000000000000') = @ExceptionId
			WHERE s.PageOperationId NOT IN(SELECT PageOperationId FROM pStyleBOLExceptionEntries WHERE BOLExceptionId = @ExceptionId) AND StyleID = @StyleID AND StyleSet = @StyleSet
			ORDER BY Sort ASC, Sort1 ASC, Sort2 ASC
END

-- set default vendor
UPDATE #TMP SET TradePartnerVendorId = @VendorId WHERE TradePartnerVendorId IS NULL

-- calc total time
UPDATE #TMP SET Totaltime = 
	CASE 
		WHEN #TMP.MacroId IS NOT NULL AND #TMP.IsLinked = 1 THEN
			(SELECT SUM(SAM) FROM pBOLOperations 
				INNER JOIN pBOLOpToMacro ON pBOLOperations.OperationId = pBOLOpToMacro.OperationId 
				WHERE pBOLOpToMacro.MacroId = #TMP.MacroId)
		WHEN #TMP.MacroId IS NOT NULL AND #TMP.IsLinked = 0 THEN
			(SELECT SUM((S1.SAM * ISNULL(S1.Coef, 1)) + (S1.SAM * ISNULL(S1.Coef, 1) * ISNULL(cast(S1.Adj AS numeric(10, 2)), 0) / 100))
				FROM pStyleBOLPageOperations AS S1
				WHERE S1.MacroParentId = #TMP.PageOperationId)
		ELSE
			(#TMP.SAM * ISNULL(#TMP.Coef, 1) + #TMP.SAM * ISNULL(#TMP.Coef, 1) * ISNULL(cast(#TMP.Adj AS numeric(10, 2)), 0) / 100)
		END

-- check if operation has fixed cost for this vendor
UPDATE #TMP SET IsFixed = 
	CASE
		WHEN (SELECT opf.FixedCost FROM pBOLOperationFixed opf
				WHERE opf.OperationId = #TMP.OperationId
				AND opf.TradePartnerVendorID = #TMP.TradePartnerVendorId
				AND opf.SeasonYearId = @SeasonYearID) IS NOT NULL THEN
			1
		ELSE
			0
		END

-- get factory rate and factory currency by base rate
UPDATE #TMP SET FactoryRate = 
	(SELECT fr.RateValue FROM pBOLFactoryRates fr 
		WHERE fr.TradePartnerVendorID = #TMP.TradePartnerVendorId
		AND fr.SeasonYearId = @SeasonYearID
		AND fr.BaseRateId = #TMP.BaseRateId),
				FactoryCurr = 
	(SELECT fr.CurrencyCode FROM vw_pBOLFactory_Rates fr 
		WHERE fr.TradePartnerVendorID = #TMP.TradePartnerVendorId
		AND fr.SeasonYearId = @SeasonYearID
		AND fr.BaseRateId = #TMP.BaseRateId)

-- calc cost in factory currency
UPDATE #TMP SET Cost = ( Totaltime + (Totaltime * ISNULL(SourcingAdj, 0) / 100) ) * FactoryRate

-- select cost for fixed operation
UPDATE #TMP SET Cost = 
	(SELECT opf.FixedCost FROM pBOLOperationFixed opf
		WHERE opf.OperationId = #TMP.OperationId
		AND opf.TradePartnerVendorID = #TMP.TradePartnerVendorId
		AND opf.SeasonYearId = @SeasonYearID)
	WHERE #TMP.IsFixed = 1
UPDATE #TMP SET FactoryCurr = 
	(SELECT ct.CustomKey FROM sCurrencyType ct INNER JOIN uTradePartnerVendor v
		ON ct.CustomID = v.CurrencyType
		WHERE v.TradePartnerVendorID = @VendorId)
	WHERE #TMP.IsFixed = 1 AND #TMP.FactoryCurr IS NULL

-- select base currency of exchange rate
SET @ConvCurr = 
	(SELECT CurrencyType FROM vwx_Control_ExchangeRateItem
		WHERE ExchangeRateID = @ExchangeRateID
		AND BaseCurrency = 1)

UPDATE #TMP SET ConvCurr = @ConvCurr

-- rate of converted currency
UPDATE #TMP SET ConvCurrRate = 
	(SELECT Rate FROM vwx_Control_ExchangeRateItem
		WHERE ExchangeRateID = @ExchangeRateID
		AND BaseCurrency = 1)

-- rate of factory currency
UPDATE #TMP SET CurrRate = 
	(SELECT TOP 1 Rate FROM vwx_Control_ExchangeRateItem
		WHERE ExchangeRateID = @ExchangeRateID
		AND CurrencyType = #TMP.FactoryCurr
		AND #TMP.FactoryCurr IS NOT NULL)
								
UPDATE #TMP SET CurrRate = NULL WHERE CurrRate = '0.00'
								
-- calc converted cost for operations
UPDATE #TMP SET ConvCost = Cost * ConvCurrRate / CurrRate
	WHERE MacroId IS NULL

-- calc converted cost for macro
UPDATE #TMP SET ConvCost = 
	CASE
		WHEN (SELECT COUNT(*) from #TMP as t1
				WHERE #TMP.PageOperationId = t1.MacroParentId
				AND t1.ConvCost IS NULL) > 0 THEN
			NULL
		ELSE
			(SELECT SUM(t2.ConvCost) FROM #TMP as t2
				WHERE #TMP.PageOperationId = t2.MacroParentId)
		END	
	WHERE MacroId IS NOT NULL

-- sum and group by base rate for total table
INSERT #TMP_total(Sort, BaseRateId, BaseRateCode, Totaltime, ConvCost, ConvCurr)
	SELECT 0 as Sort, #TMP.BaseRateId, 'Type ' + pBOLBaseRateType.RateCode, SUM (Totaltime), 
		CASE
			WHEN (SELECT COUNT(*) FROM #TMP as t1
					WHERE t1.BaseRateId = #TMP.BaseRateId
					AND t1.ConvCost IS NULL) > 0 THEN
				NULL
			ELSE
				SUM(ConvCost)
		END, @ConvCurr
	FROM #TMP LEFT JOIN pBOLBaseRateType
		ON #TMP.BaseRateId = pBOLBaseRateType.BaseRateTypeId
		WHERE MacroId IS NULL
	GROUP BY BaseRateId, pBOLBaseRateType.RateCode
UNION
	SELECT 2 as Sort, '00000000-0000-0000-0000-000000000001' as BaseRateId, 'Total' as BaseRateCode, SUM(Totaltime), SUM(ConvCost), @ConvCurr
	FROM #TMP WHERE MacroId IS NULL
	
UPDATE #TMP_total SET Sort = 1, BaseRateCode = 'Other' 
		WHERE BaseRateId = '00000000-0000-0000-0000-000000000000'
	
UPDATE #TMP_total SET sTotaltime = CAST (Totaltime as nvarchar(50))	
UPDATE #TMP_total SET sConvCost = 
	CASE
		WHEN ConvCost IS NULL THEN 'Missing rate!'
		ELSE CAST (ConvCost as nvarchar(50))
	END


SELECT * FROM #TMP
SELECT * FROM #TMP_total Order By Sort

DROP TABLE #TMP
DROP TABLE #TMP_total

END

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02132'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02132', GetDate())
	END
GO