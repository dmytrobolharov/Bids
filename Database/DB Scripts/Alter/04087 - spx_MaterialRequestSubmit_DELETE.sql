
/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestSubmit_DELETE]    Script Date: 10/03/2012 11:42:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestSubmit_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestSubmit_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestSubmit_DELETE]    Script Date: 10/03/2012 11:42:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


    
CREATE PROCEDURE [dbo].[spx_MaterialRequestSubmit_DELETE] (    
 @MaterialTradePartnerColorID UNIQUEIDENTIFIER,    
 @MaterialTradePartnerID UNIQUEIDENTIFIER,      
 @MaterialRequestSubmitWorkflowID UNIQUEIDENTIFIER,    
 @MaterialSubmit VARCHAR(2)    
)    
AS    
    

    
DECLARE @MaterialRequestSubmitID UNIQUEIDENTIFIER    
DECLARE @MaterialRequestWorkflowID VARCHAR(5)     
DECLARE 
	@NewMaterialSubmit INT,
	@NewStatus INT    
    
    
SELECT TOP 1 @MaterialRequestSubmitID = MaterialRequestSubmitID    
FROM pMaterialRequestSubmit WITH(NOLOCK)
WHERE MaterialTradePartnerColorID = @MaterialTradePartnerColorID    
	AND MaterialTradePartnerID = @MaterialTradePartnerID    
	AND MaterialRequestSubmitWorkflowID = @MaterialRequestSubmitWorkflowID    
	AND Submit = @MaterialSubmit    
     
     
DELETE pMaterialRequestSubmitItem WHERE MaterialRequestSubmitID = @MaterialRequestSubmitID    
DELETE pMaterialRequestSubmit WHERE MaterialRequestSubmitID = @MaterialRequestSubmitID    


--** Get new submit no.  and status
 
SET @NewMaterialSubmit = 1
 
IF @MaterialSubmit <> 1      
BEGIN    
	SET @NewMaterialSubmit = ISNULL(CAST(@MaterialSubmit AS INT), 2) - 1    
END    

IF @NewMaterialSubmit = 1 
	-- There are resubmits
	SET @NewStatus = 0  -- Open 
ELSE 
	SET @NewStatus = 1 -- resubmit

UPDATE pMaterialRequestSubmitWorkflow SET     
	pMaterialRequestSubmitWorkflow.Submit = @NewMaterialSubmit,     
	pMaterialRequestSubmitWorkflow.Status = @NewStatus
	--pMaterialRequestSubmitWorkflow.AssignedTo = @AssignedTo,     
	--   pMaterialRequestSubmitWorkflow.StartDate = CONVERT(DATETIME, @StartDate, 112),     
	--   pMaterialRequestSubmitWorkflow.DueDate = CONVERT(DATETIME, @DueDate, 112),     
	--   pMaterialRequestSubmitWorkflow.EndDate = CONVERT(DATETIME, @EndDate, 112),    
	--   pMaterialRequestSubmitWorkflow.MDate = @MDate,    
	--   pMaterialRequestSubmitWorkflow.MUser = @MUser    
WHERE MaterialRequestSubmitWorkflowID = @MaterialRequestSubmitWorkflowID    

  
    
       



--** Find out if the workflow is a 'All colors' workflow.  

DECLARE @MaterialRequestWorkflowColor int    

-- ** Get the workflow id.
SELECT @MaterialRequestWorkflowID = MaterialRequestWorkflowID    
FROM pMaterialRequestSubmitWorkflow    
WHERE MaterialRequestSubmitWorkflowID = @MaterialRequestSubmitWorkflowID    

--** Get flag.  If '1', then it's a 'All Colors' workflow.*/    
SELECT @MaterialRequestWorkflowColor = MaterialRequestWorkflowColor    
FROM pMaterialRequestWorkflow    
WHERE MaterialRequestWorkflowID = @MaterialRequestWorkflowID    
    

    
IF @MaterialRequestWorkflowColor = 1    
BEGIN    
	--** all colors
	
	DECLARE @MaterialRequestSubmitID_Original uniqueidentifier    
	DECLARE @MaterialRequestSubmitID_Other uniqueidentifier    
	DECLARE @TotalCount int    
	DECLARE @RowCounter int    
    
    
	-- **Create temp table.
	CREATE TABLE #temp_MaterialRequestSubmitIDs(    
		TableRow int identity(1,1),
		MaterialRequestSubmitID UNIQUEIDENTIFIER
	)    

	-- Use my own variable names.
	SET @MaterialRequestSubmitID_Original = @MaterialRequestSubmitID    
	
    
	-- **Get IDs of the other 'All colors' records, using the MaterialRequestWorkflowID
	--** Submits to be deleted
	INSERT INTO #temp_MaterialRequestSubmitIDs (MaterialRequestSubmitID)
	SELECT a.MaterialRequestSubmitID
	FROM pMaterialRequestSubmit a WITH(NOLOCK)
		INNER JOIN pMaterialRequestSubmitWorkflow b WITH(NOLOCK) ON a.MaterialRequestSubmitWorkflowID = b.MaterialRequestSubmitWorkflowID
	WHERE a.MaterialTradePartnerID  = @MaterialTradePartnerID
	AND b.MaterialRequestWorkflowID = @MaterialRequestWorkflowID
	AND a.Submit > @NewMaterialSubmit
	
    
    --** Delete submits information(template items)
    DELETE pMaterialRequestSubmitItem
    FROM pMaterialRequestSubmitItem a
		INNER JOIN #temp_MaterialRequestSubmitIDs b ON a.MaterialRequestSubmitID = b.MaterialRequestSubmitID

	--** Delete submits 
    DELETE pMaterialRequestSubmit
    FROM pMaterialRequestSubmitItem a
		INNER JOIN #temp_MaterialRequestSubmitIDs b ON a.MaterialRequestSubmitID = b.MaterialRequestSubmitID
    
	--** update status and submit of submitWorkflow 	    
	UPDATE pMaterialRequestSubmitWorkflow SET   
		pMaterialRequestSubmitWorkflow.Submit = @NewMaterialSubmit,   
		pMaterialRequestSubmitWorkflow.Status = @NewStatus 
	WHERE MaterialTradePartnerID = 	@MaterialTradePartnerID
		AND MaterialRequestWorkflowID = @MaterialRequestWorkflowID      
    
	--** Drop temp table.
	DROP TABLE #temp_MaterialRequestSubmitIDs    
	
END 


--** for all color /all no color workflow types
UPDATE pMaterialRequestSubmit    
SET Status = 0
FROM pMaterialRequestSubmit a
	INNER JOIN pMaterialRequestSubmitWorkflow b ON a.MaterialRequestSubmitWorkflowID  = b.MaterialRequestSubmitWorkflowID
WHERE a.MaterialTradePartnerID = @MaterialTradePartnerID
	AND b.MaterialRequestWorkflowID = @MaterialRequestWorkflowID 
	AND a.Submit = @NewMaterialSubmit
	

	


GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04087', GetDate())
GO