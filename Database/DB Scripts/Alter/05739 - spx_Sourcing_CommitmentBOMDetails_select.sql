IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Sourcing_CommitmentBOMDetails_select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Sourcing_CommitmentBOMDetails_select]
GO

CREATE PROCEDURE [dbo].[spx_Sourcing_CommitmentBOMDetails_select]
(
	@CommitmentItemId UNIQUEIDENTIFIER
	, @StyleBOMDimensionId UNIQUEIDENTIFIER
	, @WhereSql NVARCHAR(MAX) = ''
)
AS 


BEGIN
	SELECT * INTO #tmp
	FROM pSourcingCommitmentBOMDetails
	WHERE StyleBOMDimensionID=@StyleBOMDimensionID
		AND SourcingCommitmentItemID=@CommitmentItemId 
		AND ItemDim1Active=1
		AND ItemDim2Active=1
		AND ItemDim3Active=1
	ORDER BY ItemDim1Sort, ItemDim1Name, ItemDim2Sort, ItemDim2Name, ItemDim3Sort, ItemDim3Name
	EXEC('SELECT * FROM #tmp ' + @WhereSql)
	
	DROP TABLE #tmp	
END



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05739', GetDate())
GO

