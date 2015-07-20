
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestSubmitItem_SELECT_srmOn]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestSubmitItem_SELECT_srmOn]
GO

CREATE PROCEDURE [dbo].[spx_MaterialRequestSubmitItem_SELECT_srmOn](@MaterialRequestSubmitID uniqueidentifier)    
AS 

SELECT    B.Status AS MaterialRequestSubmitItemStatus,  A.MaterialRequestSubmitItemID AS MaterialRequestSubmitItemID, A.MaterialRequestSubmitID AS MaterialRequestSubmitID, A.MaterialRequestWorkflowItemID, 
                      A.MaterialRequestSubmitItemCustom1, A.MaterialRequestSubmitItemCustom2, A.MaterialRequestSubmitItemCustom3, A.MaterialRequestSubmitItemCustom4, 
                      A.MaterialRequestSubmitItemCustom5, A.MaterialRequestSubmitItemCustom6, A.MaterialRequestSubmitItemCustom7, A.MaterialRequestSubmitItemCustom8, 
                      A.MaterialRequestSubmitItemCustom9, A.MaterialRequestSubmitItemCustom10, A.MaterialRequestSubmitItemSort, A.CUser, A.CDate, A.MUser, A.MDate, 
                      A.MaterialRequestSubmitGroupID
FROM         pMaterialRequestSubmitItem AS A INNER JOIN dbo.pMaterialRequestSubmitItemStatus AS B ON A.MaterialRequestSubmitItemStatus=B.StatusID
    
WHERE MaterialRequestSubmitID  = @MaterialRequestSubmitID    
ORDER BY MaterialRequestSubmitItemSort, MaterialRequestSubmitItemCustom1  

GO 

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '466', GetDate())
GO