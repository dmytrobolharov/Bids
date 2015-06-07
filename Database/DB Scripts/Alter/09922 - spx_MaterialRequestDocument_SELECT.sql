IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestDocument_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestDocument_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_MaterialRequestDocument_SELECT] (   
	@MaterialID uniqueidentifier,  
	@MaterialTradePartnerID uniqueidentifier,  
	@MaterialTradePartnerColorID uniqueidentifier,  
	@MaterialRequestSubmitWorkflowID uniqueidentifier,  
	@MaterialRequest int,
	@SqlFilter NVARCHAR(MAX) = NULL,
	@PageNo INT = NULL,
	@PageSize INT = NULL,
	@SortOrder NVARCHAR(MAX) = NULL
)
AS   
  
IF @MaterialRequest = 1
BEGIN

	SELECT MaterialRequestDocumentID
		, MaterialID
		, MaterialTradePartnerID
		, MaterialTradePartnerColorID
		, MaterialRequestSubmitWorkflowID
		, MaterialDocumentName
		, MaterialDocumentDescription
		, MaterialDocumentExt
		, MaterialDocumentSize
		, MaterialDocumentShared
		, CUser
		, CDate
		, MUser
		, MDate
		, MChange
		, SystemServerStorageID
	INTO #tmp0
	FROM pMaterialRequestDocument
	WHERE MaterialID = @MaterialID
		AND MaterialTradePartnerID = @MaterialTradePartnerID
		AND MaterialTradePartnerColorID = @MaterialTradePartnerColorID
		AND MaterialRequestSubmitWorkflowID = @MaterialRequestSubmitWorkflowID
		AND MaterialDocumentShared = @MaterialRequest
		
	DECLARE @sqlString  NVARCHAR(MAX) = dbo.fnx_CreatePagingString('#tmp0',@PageNo,@PageSize,@SortOrder, @SqlFilter)
	exec sp_executesql @sqlString
	DROP TABLE #tmp0
		
END
ELSE
BEGIN
	SELECT MaterialRequestDocumentID
		, MaterialID
		, MaterialTradePartnerID
		, MaterialTradePartnerColorID
		, MaterialRequestSubmitWorkflowID
		, MaterialDocumentName
		, MaterialDocumentDescription
		, MaterialDocumentExt
		, MaterialDocumentSize
		, MaterialDocumentShared
		, CUser
		, CDate
		, MUser
		, MDate
		, MChange
		, SystemServerStorageID
	INTO #tmp1
	FROM pMaterialRequestDocument
	WHERE MaterialID = @MaterialID
		AND MaterialTradePartnerID = @MaterialTradePartnerID
		AND MaterialTradePartnerColorID = @MaterialTradePartnerColorID
		AND MaterialRequestSubmitWorkflowID = @MaterialRequestSubmitWorkflowID
		
	DECLARE @sqlString1  NVARCHAR(MAX) = dbo.fnx_CreatePagingString('#tmp1',@PageNo,@PageSize,@SortOrder, @SqlFilter)
	exec sp_executesql @sqlString1
	DROP TABLE #tmp1
		
END
 
 

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09922', GetDate())
GO
