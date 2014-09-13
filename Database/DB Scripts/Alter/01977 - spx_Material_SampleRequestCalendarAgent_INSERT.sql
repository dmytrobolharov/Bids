IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Material_SampleRequestCalendarAgent_INSERT]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[spx_Material_SampleRequestCalendarAgent_INSERT]
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
* Name        : spx_Material_SampleRequestCalendarAgent_INSERT
*
* Description : To insert all data related to agent sample request activity for calender 
*
* Change History:                  
* ------------------
* Date			Version			Author			Comment
* 09/23/2011	  --			Yogesh Lad		Created for insert all data related to agent sample 
												request for calender  
*
*
-------------------------------------------------------------------------------------------------- */

CREATE PROCEDURE [dbo].[spx_Material_SampleRequestCalendarAgent_INSERT]
(
	@TeamId varchar(50),
	@TradePartnerId varchar(50) = NULL,
	@CalendarId varchar(50),
	@StartDate datetime,
	@EndDate datetime
)
AS 
SET NOCOUNT ON
/*Holiday's INSERT SELECT Statement.*/

	INSERT INTO pStyleCalendarTemp
		(
			CalendarID
			,PKeyID
			,CalendarLinkID
			,CalendarLinkSubID
			,CalendarLinkSubID1
			,CalendarDate
			,CalendarType
			,CalendarStatus
			,CalendarDescription
		)
	SELECT 
			@CalendarID AS CalendarID, 
			'00000000-0000-0000-0000-000000000000' AS PKeyID
			,'00000000-0000-0000-0000-000000000000' AS CalendarLinkID
			,'00000000-0000-0000-0000-000000000000' AS CalendarLinkSubID
			,'00000000-0000-0000-0000-000000000000' AS CalendarLinkSubID1
			,CalendarEventDate AS CalendarDate
			,'Holiday' AS CalendarType
			,0 AS CalendarStatus
			,CalendarEventCountry 
			+  ' - ' 
			+ CalendarEventName as CalendarDescription
	FROM cCalendarEvent WITH (NOLOCK)


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
			,pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID
			,pMaterialRequestSubmitWorkflow.MaterialTradePartnerID
			,pMaterialRequestWorkflow.MaterialRequestWorkflow 
			+ N' (' 
			+ CAST(pMaterialRequestSubmitWorkflow.Submit AS varchar(4)) 
			+ ') ' AS CalendarLinkSubId
			,pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID
			,pMaterialRequestSubmitWorkflow.DueDate
			,'SampleRequest' AS CalendarType
			,pMaterialRequestSubmitWorkflow.Status
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
			,0 AS CalendarView
		FROM 
			pMaterialRequestSubmitWorkflow WITH (NOLOCK) 
			INNER JOIN pMaterialRequestWorkflow WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID = pMaterialRequestWorkflow.MaterialRequestWorkflowID 
			INNER JOIN pMaterial WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.MaterialID = pMaterial.MaterialID 
			INNER JOIN uTradePartnerVendor WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID 
			INNER JOIN uTradePartner WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.TradePartnerID = uTradePartner.TradePartnerID 
			INNER JOIN pComponentType WITH (NOLOCK) ON dbo.pComponentType.ComponentTypeID=pMaterial.MaterialType  
		WHERE 
			(pMaterialRequestSubmitWorkflow.DueDate BETWEEN @StartDate AND @EndDate) 
			AND (pMaterialRequestSubmitWorkflow.Status NOT IN (SELECT StatusID FROM dbo.pMaterialRequestSubmitStatus WHERE ApprovedType = 1 OR StatusID = 4 )) 
			AND (pMaterialRequestSubmitWorkflow.TradePartnerID = @TradePartnerId) 
			AND (pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID IN (SELECT SampleWorkflowId FROM pMaterialSampleWorkflowViewSubmit WITH (NOLOCK) WHERE TeamId = @TeamId)) 			  
		ORDER BY pMaterialRequestSubmitWorkflow.DueDate, pMaterial.MaterialNo, pMaterialRequestWorkflow.MaterialRequestWorkflowID 	

		
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
			,pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID
			,pMaterialRequestSubmitWorkflow.TradePartnerID
			,pMaterialRequestWorkflow.MaterialRequestWorkflow 
				+ N' (' 
				+ CAST(pMaterialRequestSubmitWorkflow.Submit AS varchar(4)) 
				+ ') ' AS CalendarLinkSubId
			,pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID
			,pMaterialRequestSubmitWorkflow.DueDate
			,'SampleRequest' AS CalendarType
			,pMaterialRequestSubmitWorkflow.Status
			,'<b>A: </b>' 
				+ uTradePartner.TradePartnerCode 
				+ ' / <b>V: </b>' 
				+ uTradePartnerVendor.VendorCode 
				+ '<BR>' 
				+ pMaterial.MaterialNo 
				+ ' (' 
				+ pMaterial.MaterialName 
				+ ') '
				+ pComponentType.ComponentDescription  AS CalendarDescription
			,0 AS CalendarView
		FROM 
			pMaterialRequestSubmitWorkflow WITH (NOLOCK) 
			INNER JOIN pMaterialRequestWorkflow WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID = pMaterialRequestWorkflow.MaterialRequestWorkflowID  
			INNER JOIN pMaterial WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.MaterialID = pMaterial.MaterialID 
			INNER JOIN uTradePartnerVendor WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID 
			INNER JOIN uTradePartner WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.TradePartnerID = uTradePartner.TradePartnerID 
			INNER JOIN pComponentType WITH (NOLOCK) ON dbo.pComponentType.ComponentTypeID=pMaterial.MaterialType  
		WHERE 
			(pMaterialRequestSubmitWorkflow.Status = 1) 
			AND (pMaterialRequestSubmitWorkflow.TradePartnerID = @TradePartnerId) 
			AND (pMaterialRequestSubmitWorkflow.EndDate BETWEEN @StartDate AND @EndDate) 
			AND (pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID IN (SELECT SampleWorkflowId FROM pMaterialSampleWorkflowViewSubmit WITH (NOLOCK) WHERE TeamId = @TeamId)) 				
		ORDER BY pMaterialRequestSubmitWorkflow.EndDate, pMaterial.MaterialNo, pMaterialRequestWorkflow.MaterialRequestWorkflowID
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
			,pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID
			,pMaterialRequestSubmitWorkflow.MaterialTradePartnerID
			,pMaterialRequestWorkflow.MaterialRequestWorkflow 
			+ N' (' 
			+ CAST(pMaterialRequestSubmitWorkflow.Submit AS varchar(4)) 
			+ ') ' AS CalendarLinkSubId
			,pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID
			,pMaterialRequestSubmitWorkflow.DueDate
			,'SampleRequest' AS CalendarType
			,pMaterialRequestSubmitWorkflow.Status
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
			,0 AS CalendarView
		FROM 
			pMaterialRequestSubmitWorkflow WITH (NOLOCK) INNER JOIN
			pMaterialRequestWorkflow WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID = pMaterialRequestWorkflow.MaterialRequestWorkflowID INNER JOIN
			pMaterial WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.MaterialID = pMaterial.MaterialID  INNER JOIN
			uTradePartnerVendor WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID INNER JOIN
			uTradePartner WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.TradePartnerID = uTradePartner.TradePartnerID INNER JOIN				
			pComponentType WITH (NOLOCK) ON dbo.pComponentType.ComponentTypeID=pMaterial.MaterialType  
		WHERE 
			(pMaterialRequestSubmitWorkflow.DueDate BETWEEN @StartDate AND @EndDate) 
			AND (pMaterialRequestSubmitWorkflow.Status NOT IN ( SELECT StatusID FROM dbo.pMaterialRequestSubmitStatus WHERE ApprovedType = 1 OR StatusID = 4 )) 
			AND (pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID IN (SELECT SampleWorkflowId FROM pMaterialSampleWorkflowViewSubmit WITH (NOLOCK) WHERE TeamId = @TeamId)) 			  
			ORDER BY pMaterialRequestSubmitWorkflow.DueDate, pMaterial.MaterialNo, pMaterialRequestWorkflow.MaterialRequestWorkflowID	



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
			,pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID
			,pMaterialRequestSubmitWorkflow.TradePartnerID
			,pMaterialRequestWorkflow.MaterialRequestWorkflow 
			+ N' (' 
			+ CAST(pMaterialRequestSubmitWorkflow.Submit AS varchar(4)) 
			+ ') ' AS CalendarLinkSubId
			,pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID
			,pMaterialRequestSubmitWorkflow.DueDate
			,'SampleRequest' AS CalendarType
			,pMaterialRequestSubmitWorkflow.Status
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
			,0 AS CalendarView
		FROM 
			pMaterialRequestSubmitWorkflow WITH (NOLOCK) INNER JOIN
			pMaterialRequestWorkflow WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID = pMaterialRequestWorkflow.MaterialRequestWorkflowID INNER JOIN
			pMaterial WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.MaterialID = pMaterial.MaterialID INNER JOIN
			uTradePartnerVendor WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID INNER JOIN
			uTradePartner WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.TradePartnerID = uTradePartner.TradePartnerID INNER JOIN				
			pComponentType WITH (NOLOCK) ON dbo.pComponentType.ComponentTypeID=pMaterial.MaterialType  
		WHERE 
			(pMaterialRequestSubmitWorkflow.Status = 1) 
			AND (pMaterialRequestSubmitWorkflow.EndDate BETWEEN @StartDate AND @EndDate) 
			AND (pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID IN (SELECT SampleWorkflowId FROM pMaterialSampleWorkflowViewSubmit WITH (NOLOCK) WHERE TeamId = @TeamId)) 			  
		ORDER BY pMaterialRequestSubmitWorkflow.EndDate, pMaterial.MaterialNo,pMaterialRequestWorkflow.MaterialRequestWorkflowID
	END
SET NOCOUNT OFF
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01977'))
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
			'DB_Version'
			,'4.1.0000'
			,'01977'
			,GetDate()
		)
END	
GO
	








