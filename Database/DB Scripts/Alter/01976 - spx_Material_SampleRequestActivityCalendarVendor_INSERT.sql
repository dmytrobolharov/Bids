IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Material_SampleRequestActivityCalendarVendor_INSERT]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[spx_Material_SampleRequestActivityCalendarVendor_INSERT]
END
GO
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 23 September 2011                                                                           */
-- *                                                                                            */
-- * Copyright (c) 2002-2011 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */

/*------------------------------------------------------------------------------------------------                               
* Name        : spx_Material_SampleRequestActivityCalendarVendor_INSERT
*
* Description : To insert all data related to vendor sample request activity for calender 
*
* Change History:                  
* ------------------
* Date			Version			Author			Comment
* 09/23/2011	  --			Yogesh Lad		Created for insert all data related to 
												vendor sample request activity for calender 
*
*
-------------------------------------------------------------------------------------------------- */

CREATE PROCEDURE [dbo].[spx_Material_SampleRequestActivityCalendarVendor_INSERT]
(
	@TeamId varchar(50),
	@TradePartnerId varchar(50) = NULL,
	@TradePartnerVendorId varchar(50),
	@CalendarId varchar(50),
	@StartDate datetime,
	@EndDate datetime
)
AS 
SET NOCOUNT ON
IF @TradePartnerId IS NOT NULL
	BEGIN
		INSERT INTO pStyleCalendarTemp
		(
			CalendarId
			,PKeyId
			,CalendarLinkId
			,CalendarLinkSubId
			,CalendarLinkSubId1
			,CalendarDate
			,CalendarType
			,CalendarStatus
			,CalendarDescription
			,CalendarView
		)
		SELECT 
			@CalendarId AS CalendarId
			,pMaterialRequestWorkflow.MaterialRequestWorkflowID
			,pMaterialRequestSubmit.MaterialTradePartnerID
			,pMaterialRequestWorkflow.MaterialRequestWorkflow
				+ N' (' 
				+ CAST(pMaterialRequestSubmit.Submit AS varchar(4)) 
				+ ') ' AS CalendarLinkSubId
			,pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID
			,pMaterialActivity.CDate
			,'SampleActivity' AS CalendarType
			,pMaterialActivity.ActivityType
			,'<b>A: </b>' 
				+ uTradePartner.TradePartnerCode 
				+ ' / <b>V: </b>' 
				+ uTradePartnerVendor.VendorCode 
				+ '<BR>' + pMaterial.MaterialNo 
				+ ' (' 
				+ pMaterial.MaterialName 
				+ ') ' 
				+ pComponentType.ComponentDescription AS CalendarDescription
				,pMaterialRequestSubmit.AgentView
		FROM pMaterialRequestSubmit WITH (NOLOCK) 
			INNER JOIN pMaterialRequestSubmitWorkflow WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID = dbo.pMaterialRequestSubmit.MaterialRequestSubmitWorkflowID 
			INNER JOIN pMaterialRequestWorkflow  WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID = pMaterialRequestWorkflow.MaterialRequestWorkflowID  
			INNER JOIN pMaterial WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.MaterialID = pMaterial.MaterialID 
			INNER JOIN pMaterialActivity WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.MaterialID = pMaterialActivity.MaterialID 
			INNER JOIN uTradePartner WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.TradePartnerID = uTradePartner.TradePartnerID 
			INNER JOIN uTradePartnerVendor WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID 
			INNER JOIN pComponentType WITH (NOLOCK) ON pMaterial.MaterialType= pComponentType.ComponentTypeID 
		WHERE (pMaterialRequestSubmitWorkflow.TradePartnerId = @TradePartnerId)
			AND (pMaterialRequestSubmitWorkflow.TradePartnerVendorId = @TradePartnerVendorId)    
			AND (pMaterialActivity.TradePartner = 0)
			AND (pMaterialActivity.CDate BETWEEN @StartDate AND @EndDate) 
			AND (pMaterialActivity.ActivityType NOT IN ('V','U')) 
			AND (pMaterialRequestWorkflow.MaterialRequestWorkflowID IN (SELECT SampleWorkflowId FROM pMaterialSampleWorkflowViewSubmit WITH (NOLOCK) WHERE TeamId = @TeamId)) 				
		ORDER BY  pMaterialActivity.Cdate DESC, pMaterial.MaterialNo, pMaterialRequestWorkflow.MaterialRequestWorkflowID 
	END
ELSE
	BEGIN
		INSERT INTO pStyleCalendarTemp
		   (
				CalendarId
				,PKeyId
				,CalendarLinkId
				,CalendarLinkSubId
				,CalendarLinkSubId1
				,CalendarDate
				,CalendarType
				,CalendarStatus
				,CalendarDescription
				,CalendarView
			)
		SELECT 
				@CalendarId AS CalendarId
				,pMaterialRequestWorkflow.MaterialRequestWorkflowID
				,pMaterialRequestSubmit.MaterialTradePartnerID
				,pMaterialRequestWorkflow.MaterialRequestWorkflow 
					+ N' (' 
					+ CAST(pMaterialRequestSubmit.Submit AS varchar(4)) 
					+ ') ' AS CalendarLinkSubId
				,pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID
				,pMaterialActivity.CDate
				,'SampleActivity' AS CalendarType
				,pMaterialActivity.ActivityType
				,'<b>A: </b>' 
					+ uTradePartner.TradePartnerCode 
					+ ' / <b>V: </b>' 
					+ uTradePartnerVendor.VendorCode 
					+ '<BR>' 
					+ pMaterial.MaterialNo 
					+ ' (' 
					+ pMaterial.MaterialName 
					+ ') ' 
					+ pComponentType.ComponentDescription AS CalendarDescription
				,pMaterialRequestSubmit.AgentView
		FROM	pMaterialRequestSubmit WITH (NOLOCK) 
				INNER JOIN pMaterialRequestSubmitWorkflow WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID = dbo.pMaterialRequestSubmit.MaterialRequestSubmitWorkflowID 
				INNER JOIN pMaterialRequestWorkflow  WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID = pMaterialRequestWorkflow.MaterialRequestWorkflowID  
				INNER JOIN pMaterial WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.MaterialID = pMaterial.MaterialID 
				INNER JOIN pMaterialActivity WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.MaterialID = pMaterialActivity.MaterialID 
				INNER JOIN uTradePartner WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.TradePartnerID = uTradePartner.TradePartnerID 
				INNER JOIN uTradePartnerVendor WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID 
				INNER JOIN pComponentType WITH (NOLOCK) ON pMaterial.MaterialType= pComponentType.ComponentTypeID 
		WHERE (pMaterialRequestSubmitWorkflow.TradePartnerVendorId = @TradePartnerVendorId)    
				AND (pMaterialActivity.TradePartner = 0)
				AND (pMaterialActivity.CDate BETWEEN @StartDate AND @EndDate) 
				AND (pMaterialActivity.ActivityType NOT IN ('V','U')) 
				AND (pMaterialRequestWorkflow.MaterialRequestWorkflowID IN (SELECT SampleWorkflowId FROM pMaterialSampleWorkflowViewSubmit WITH (NOLOCK) WHERE TeamId = @TeamId)) 				
		ORDER BY  pMaterialActivity.Cdate DESC, pMaterial.MaterialNo, pMaterialRequestWorkflow.MaterialRequestWorkflowID 
	END

SET NOCOUNT OFF

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01976'))
BEGIN
	INSERT INTO sVersion
	(	 
		AppName
		,[Version]
		,LastScriptRun
		,[TimeStamp]
	)
	VALUES     
	(
		'DB_Version', 
		'4.1.0000',
		'01976',
		GetDate()
	)
END	
GO

				

				
				
			