IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Sourcing_StyleBOMDetails_select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Sourcing_StyleBOMDetails_select]
GO

CREATE PROCEDURE [dbo].[spx_Sourcing_StyleBOMDetails_select]
(
	@StyleQuoteItemID UNIQUEIDENTIFIER
	, @StyleBOMDimensionId UNIQUEIDENTIFIER
	, @WhereSql NVARCHAR(MAX) = ''
)
AS 

BEGIN
	SELECT * INTO #tmp
	FROM pSourcingQuotationBOMDetails
	WHERE StyleBOMDimensionID=@StyleBOMDimensionID
		AND StyleQuoteItemID=@StyleQuoteItemID 
		AND itemdim1active=1
		AND itemdim2active=1
		AND itemdim3active=1
	ORDER BY ItemDim1Sort, ItemDim1Name, ItemDim2Sort, ItemDim2Name, ItemDim3Sort, ItemDim3Name
	
	EXEC('SELECT * FROM #tmp ' + @WhereSql)
	
	DROP TABLE #tmp
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0.0000', '05689', GetDate())
GO
