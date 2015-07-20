
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 14 March 2012                                                                             	*/
-- * WorkItem #7318                                                                             */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--

/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestSubmitWorkflowTreeWithColors_SELECT]    Script Date: 03/14/2012 12:30:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestSubmitWorkflowTreeWithColors_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestSubmitWorkflowTreeWithColors_SELECT]
GO



/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestSubmitWorkflowTreeWithColors_SELECT]    Script Date: 03/14/2012 12:30:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_MaterialRequestSubmitWorkflowTreeWithColors_SELECT](
	@MaterialTradePartnerColorID UNIQUEIDENTIFIER
)    
AS     
    
DECLARE @MaterialTradePartnerID UNIQUEIDENTIFIER    
    
SELECT TOP 1 @MaterialTradePartnerID = MaterialTradePartnerID FROM pMaterialRequestSubmitWorkflow     
WHERE MaterialTradePartnerColorID = @MaterialTradePartnerColorID    
    
    
SELECT pMaterialTradePartnerColor.MaterialTradePartnerColorID, pMaterialTradePartnerColor.ColorCode, pMaterialRequestSubmit.MaterialRequestSubmitID,     
  pMaterialTradePartnerColor.ColorNo, pMaterialTradePartnerColor.ColorName, pMaterialTradePartnerColor.VendorColorCode,     
  pMaterialTradePartnerColor.VendorColorNo, pMaterialTradePartnerColor.VendorColorName, pMaterialRequestWorkflow.MaterialRequestWorkflowID,     
  pMaterialRequestWorkflow.GroupName, pMaterialRequestWorkflow.GroupID, pMaterialRequestSubmitStatus.Status,     
  pMaterialRequestSubmitWorkflow.Submit, pMaterialRequestSubmitWorkflow.DueDate, pMaterialRequestSubmitWorkflow.EndDate,     
  pMaterialRequestWorkflow.MaterialRequestWorkflow, pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID,     
  pMaterialRequestWorkflow.MaterialRequestWorkflowSort, pMaterialTradePartnerColor.MaterialID,     
     '../System/Icons/' + pMaterialRequestSubmitStatus.StatusIcon AS Icon,   
 pMaterialRequestSubmitWorkflow.MaterialTradePartnerID, pMaterialRequestWorkflow.MaterialRequestWorkflowColor, pMaterialTradePartnerColor.ColorFolderID, pMaterialTradePartnerColor.ColorPaletteID,    
 pMaterialTradePartnerColor.MaterialColorImageID, pMaterialTradePartnerColor.MaterialColorImageVersion, pMaterialRequestSubmitWorkflow.MaterialRequestSubmitAllColors    
FROM pMaterialRequestSubmitStatus INNER JOIN    
  pMaterialRequestWorkflow INNER JOIN    
  pMaterialRequestSubmitWorkflow ON     
  pMaterialRequestWorkflow.MaterialRequestWorkflowID = pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID ON     
  pMaterialRequestSubmitStatus.StatusID = pMaterialRequestSubmitWorkflow.Status INNER JOIN    
  pMaterialTradePartnerColor ON     
  pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID = pMaterialTradePartnerColor.MaterialTradePartnerColorID INNER JOIN    
  pMaterialRequestSubmit ON     
  pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID = pMaterialRequestSubmit.MaterialRequestSubmitWorkflowID    
WHERE pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID = @MaterialTradePartnerColorID AND pMaterialRequestSubmitWorkflow.MaterialRequestSubmitAllColors = 0    
AND pMaterialRequestSubmitWorkflow.Active = 1     
--ORDER BY pMaterialRequestWorkflow.MaterialRequestWorkflowSort,  pMaterialRequestWorkflow.MaterialRequestWorkflow
ORDER BY pMaterialRequestWorkflow.MaterialRequestWorkflowSort,  pMaterialRequestWorkflow.MaterialRequestWorkflowID
    



GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03221'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03221', GetDate())

END

GO 

