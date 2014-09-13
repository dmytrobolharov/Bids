IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Material_SampleRequestWorkflowAgentLate_SELECT]') AND TYPE IN (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[spx_Material_SampleRequestWorkflowAgentLate_SELECT]
END
GO
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 22 September 2011                                                                           */
-- *                                                                                            */
-- * Copyright (c) 2002-2011 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */

/*------------------------------------------------------------------------------------------------                               
* Name        : spx_Material_SampleRequestWorkflowAgentLate_SELECT
*
* Description : To insert all data related to late submit into temporory table.
*
* Change History:                  
* ------------------
* Date			Version			Author			Comment
* 09/23/2011	  --			Yogesh Lad		Created for late submit of material for agent.
*
*
-------------------------------------------------------------------------------------------------- */ 

CREATE PROCEDURE [dbo].[spx_Material_SampleRequestWorkflowAgentLate_SELECT]
(
	@SampleWorkflowId	VARCHAR(5),
	@TradePartnerID		UNIQUEIDENTIFIER = NULL
)
AS 
BEGIN
	SET NOCOUNT ON
	IF @TradepartnerID IS NOT NULL
		BEGIN
			SELECT 
				dbo.pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID AS SampleRequestWorkflowID
				,dbo.pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID
				,dbo.pMaterialRequestSubmitWorkflow.TradePartnerID AS SampleRequestTradeID
				,dbo.pMaterialRequestSubmitWorkflow.TradePartnerVendorID
				,dbo.pMaterialRequestSubmitWorkflow.MaterialID
				,dbo.pMaterialRequestSubmitWorkflow.MaterialColorID
				,dbo.pMaterialRequestSubmitWorkflow.[Status]
				,dbo.pMaterialRequestSubmitWorkflow.Submit
				,dbo.pMaterialRequestSubmitWorkflow.StartDate
				,dbo.pMaterialRequestSubmitWorkflow.DueDate
				,dbo.pMaterialRequestSubmitWorkflow.EndDate
				,dbo.pMaterialRequestWorkflow.MaterialRequestWorkflow AS SampleWorkflowID
				,dbo.pMaterialRequestWorkflow.MaterialRequestWorkflowSort
				,dbo.pMaterialRequestWorkflow.GroupName
				,dbo.pMaterialRequestSubmitWorkflow.AssignedTo
				,dbo.Users.FirstName
				,dbo.Users.LastName
				,dbo.pMaterial.MaterialNo
				,dbo.pMaterialRequestWorkflow.MaterialRequestWorkflow 
					+ N' (' 
					+ CAST(dbo.pMaterialRequestSubmitWorkflow.Submit AS VARCHAR(4)) 
					+ ') ' AS LateHeader, 
				'<b>A: </b>' 
					+ dbo.uTradePartner.TradePartnerCode 
					+ ' / <b>V: </b>' 
					+ dbo.uTradePartnerVendor.VendorCode 
					+ '<BR>' 
					+ dbo.pmaterial.MaterialNo 
					+ ' (' 
					+ dbo.pMaterial.MaterialName+ ') ' 
					+ dbo.pComponentType.ComponentDescription AS LateDescription
				,pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID
			FROM dbo.pMaterialRequestSubmitWorkflow WITH (NOLOCK) 
				INNER JOIN	dbo.pMaterialRequestWorkflow WITH (NOLOCK) ON dbo.pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID = dbo.pMaterialRequestWorkflow.MaterialRequestWorkflowID 
				INNER JOIN  dbo.pMaterial WITH (NOLOCK) ON dbo.pMaterialRequestSubmitWorkflow.MaterialID = dbo.pMaterial.MaterialID 
				INNER JOIN	dbo.uTradePartner WITH (NOLOCK) ON dbo.pMaterialRequestSubmitWorkflow.TradePartnerID = dbo.uTradePartner.TradePartnerID 
				INNER JOIN  dbo.uTradePartnerVendor WITH (NOLOCK) ON dbo.pMaterialRequestSubmitWorkflow.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID 
				LEFT OUTER JOIN dbo.Users WITH (NOLOCK) ON dbo.pMaterialRequestSubmitWorkflow.AssignedTo = dbo.Users.UserId 
				LEFT OUTER JOIN dbo.pComponentType WITH (NOLOCK) ON pMaterial.MaterialType = dbo.pComponentType.ComponentTypeID  
			WHERE (dbo.pMaterialRequestSubmitWorkflow.DueDate <= GETDATE()) 
				AND (dbo.pMaterialRequestSubmitWorkflow.[Status] NOT IN (2, 3, 4)) 
				AND (dbo.pMaterialRequestSubmitWorkflow.TradePartnerID = @TradePartnerID) 			
				AND (dbo.pMaterialRequestWorkflow.MaterialRequestWorkflowId = @SampleWorkflowId)
			ORDER BY dbo.pMaterialRequestSubmitWorkflow.DueDate, dbo.pMaterial.MaterialNo
		END
		ELSE
		BEGIN
			SELECT 
				dbo.pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID AS SampleRequestWorkflowID
				,dbo.pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID
				,dbo.pMaterialRequestSubmitWorkflow.TradePartnerID AS SampleRequestTradeID
				,dbo.pMaterialRequestSubmitWorkflow.TradePartnerVendorID
				,dbo.pMaterialRequestSubmitWorkflow.MaterialID
				,dbo.pMaterialRequestSubmitWorkflow.MaterialColorID
				,dbo.pMaterialRequestSubmitWorkflow.[Status]
				,dbo.pMaterialRequestSubmitWorkflow.Submit
				,dbo.pMaterialRequestSubmitWorkflow.StartDate
				,dbo.pMaterialRequestSubmitWorkflow.DueDate
				,dbo.pMaterialRequestSubmitWorkflow.EndDate
				,dbo.pMaterialRequestWorkflow.MaterialRequestWorkflow AS SampleWorkflowID
				,dbo.pMaterialRequestWorkflow.MaterialRequestWorkflowSort
				,dbo.pMaterialRequestWorkflow.GroupName
				,dbo.pMaterialRequestSubmitWorkflow.AssignedTo
				,dbo.Users.FirstName
				,dbo.Users.LastName
				,dbo.pMaterial.MaterialNo
				,dbo.pMaterialRequestWorkflow.MaterialRequestWorkflow 
					+ N' (' 
					+ CAST(dbo.pMaterialRequestSubmitWorkflow.Submit AS VARCHAR(4)) 
					+ ') '	AS LateHeader, 
				'<b>A: </b>' 
					+ dbo.uTradePartner.TradePartnerCode 
					+ ' / <b>V: </b>' 
					+ dbo.uTradePartnerVendor.VendorCode 
					+ '<BR>' 
					+ dbo.pmaterial.MaterialNo 
					+ ' (' 
					+ dbo.pMaterial.MaterialName
					+ ') ' 
					+ dbo.pComponentType.ComponentDescription	AS LateDescription
				,pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID
			FROM dbo.pMaterialRequestSubmitWorkflow WITH (NOLOCK) 
				INNER JOIN dbo.pMaterialRequestWorkflow WITH (NOLOCK) ON dbo.pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID = dbo.pMaterialRequestWorkflow.MaterialRequestWorkflowID 
				INNER JOIN dbo.pMaterial WITH (NOLOCK) ON dbo.pMaterialRequestSubmitWorkflow.MaterialID = dbo.pMaterial.MaterialID 
				INNER JOIN dbo.uTradePartner WITH (NOLOCK) ON dbo.pMaterialRequestSubmitWorkflow.TradePartnerID = dbo.uTradePartner.TradePartnerID 
				INNER JOIN dbo.uTradePartnerVendor WITH (NOLOCK) ON dbo.pMaterialRequestSubmitWorkflow.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID 
				LEFT OUTER JOIN dbo.Users WITH (NOLOCK) ON dbo.pMaterialRequestSubmitWorkflow.AssignedTo = dbo.Users.UserId 
				LEFT OUTER JOIN dbo.pComponentType WITH (NOLOCK) ON pMaterial.MaterialType =dbo.pComponentType.ComponentTypeID  
			WHERE (dbo.pMaterialRequestSubmitWorkflow.DueDate <= GETDATE()) 
				AND (dbo.pMaterialRequestSubmitWorkflow.[Status] NOT IN (2, 3, 4)) 			
				AND (dbo.pMaterialRequestWorkflow.MaterialRequestWorkflowId = @SampleWorkflowId)
			ORDER BY dbo.pMaterialRequestSubmitWorkflow.DueDate, dbo.pMaterial.MaterialNo
		END
	
	SET NOCOUNT OFF	
END
GO

	IF(NOT EXISTS( SELECT * FROM sVersion WHERE LastScriptRun='01966'))
		BEGIN
			INSERT INTO sVersion
				(
					AppName, 
					[Version], 
					LastScriptRun, 
					TIMESTAMP
				)
			VALUES     
				(
					'DB_Version'
					,'4.1.0000'
					,'01966'
					,GETDATE()
				)
		END	
GO

