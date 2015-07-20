IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Material_SampleRequestCalendarVendor_INSERT]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[spx_Material_SampleRequestCalendarVendor_INSERT]
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
* Name        : spx_Material_SampleRequestCalendarVendor_INSERT
*
* Description : To insert all data related to vendor sample request activity for calender 
*
* Change History:                  
* ------------------
* Date			Version			Author			Comment
* 09/23/2011	  --			Yogesh Lad		Created for insert all data related to vendor sample 
												request for calender  
*
*
-------------------------------------------------------------------------------------------------- */


CREATE PROCEDURE [dbo].[spx_Material_SampleRequestCalendarVendor_INSERT]
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
			,pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID
			,pMaterialRequestSubmitWorkflow.MaterialTradePartnerID
			,pMaterialRequestWorkflow.MaterialRequestWorkflow 
				+ N' (' 
				+ CAST(pMaterialRequestSubmitWorkflow.Submit AS varchar(4)) 
				+ ') ' AS CalendarLinkSubId
			,dbo.pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID
			,dbo.pMaterialRequestSubmitWorkflow.DueDate
			,'SampleRequest'
			,pMaterialRequestSubmitWorkflow.Status
			,'<b>A: </b>' 
				+ uTradePartner.TradePartnerCode 
				+ ' / <b>V: </b>' 
				+ uTradePartnerVendor.VendorCode 
				+ '<BR>' 
				+ dbo.pMaterial.MaterialNo 
				+ ' (' 
				+ dbo.pMaterial.MaterialName 
				+ ') ' 
				+ dbo.pComponentType.ComponentDescription AS CalendarDescription
			,0				
		FROM 
			dbo.pMaterialRequestSubmitWorkflow WITH (NOLOCK) 
			INNER JOIN dbo.pMaterialRequestWorkflow WITH (NOLOCK) ON dbo.pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID = dbo.pMaterialRequestWorkflow.MaterialRequestWorkflowID 
			INNER JOIN dbo.pMaterial WITH (NOLOCK) ON dbo.pMaterialRequestSubmitWorkflow.MaterialID = dbo.pMaterial.MaterialID 
			INNER JOIN dbo.uTradePartnerVendor WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID 
			INNER JOIN dbo.uTradePartner WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.TradePartnerID = dbo.uTradePartner.TradePartnerID 
			INNER JOIN dbo.pComponentType WITH (NOLOCK) ON dbo.pComponentType.ComponentTypeID=pMaterial.MaterialType  
		WHERE 
			(dbo.pMaterialRequestSubmitWorkflow.DueDate BETWEEN @StartDate AND @EndDate) 
			AND (dbo.pMaterialRequestSubmitWorkflow.Status NOT IN (SELECT StatusID FROM dbo.pSampleRequestSubmitStatus WHERE ApprovedType = 1 OR StatusID = 4)) 
			AND (pMaterialRequestSubmitWorkflow.TradePartnerID = @TradePartnerId ) 
			AND (pMaterialRequestSubmitWorkflow.TradePartnerVendorID = @TradePartnerVendorId)
			AND (pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID IN (SELECT SampleWorkflowId FROM pMaterialSampleWorkflowViewSubmit WITH (NOLOCK) WHERE TeamId = @TeamId)) 			    
		ORDER BY dbo.pMaterialRequestSubmitWorkflow.DueDate, dbo.pMaterial.MaterialNo, dbo.pMaterialRequestWorkflow.MaterialRequestWorkflowID 	


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
			,dbo.pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID
			,dbo.pMaterialRequestSubmitWorkflow.DueDate
			,'SampleRequest'
			,pMaterialRequestSubmitWorkflow.Status
			,'<b>A: </b>' 
				+ uTradePartner.TradePartnerCode 
				+ ' / <b>V: </b>' 
				+ uTradePartnerVendor.VendorCode 
				+ '<BR>' 
				+ dbo.pMaterial.MaterialNo 
				+ ' (' 
				+ dbo.pMaterial.MaterialName 
				+ ') ' 
				+ dbo.pComponentType.ComponentDescription AS CalendarDescription
			,0
		FROM 
			dbo.pMaterialRequestSubmitWorkflow WITH (NOLOCK) INNER JOIN
			dbo.pMaterialRequestWorkflow WITH (NOLOCK) ON dbo.pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID = dbo.pMaterialRequestWorkflow.MaterialRequestWorkflowID INNER JOIN
			dbo.pMaterial WITH (NOLOCK) ON dbo.pMaterialRequestSubmitWorkflow.MaterialID = dbo.pMaterial.MaterialID INNER JOIN
			dbo.uTradePartnerVendor WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID INNER JOIN
			dbo.uTradePartner WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.TradePartnerID = dbo.uTradePartner.TradePartnerID INNER JOIN
			dbo.pComponentType WITH (NOLOCK) ON dbo.pComponentType.ComponentTypeID=pMaterial.MaterialType  
		WHERE (pMaterialRequestSubmitWorkflow.EndDate BETWEEN @StartDate AND @EndDate) 
			AND (pMaterialRequestSubmitWorkflow.Status = 1) 
			AND pMaterialRequestSubmitWorkflow.TradePartnerID = @TradePartnerId 
			AND pMaterialRequestSubmitWorkflow.TradePartnerVendorID = @TradePartnerVendorId  
			AND (pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID IN (SELECT SampleWorkflowId FROM pMaterialSampleWorkflowViewSubmit WITH (NOLOCK) WHERE TeamId = @TeamId)) 			    
		ORDER BY pMaterialRequestSubmitWorkflow.EndDate, dbo.pMaterial.MaterialNo, dbo.pMaterialRequestWorkflow.MaterialRequestWorkflowID											
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
			+ ') ' AS CalendarLinkSubId,
			dbo.pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID
			,dbo.pMaterialRequestSubmitWorkflow.DueDate
			,'SampleRequest'
			,pMaterialRequestSubmitWorkflow.Status
			,'<b>A: </b>' 
				+ uTradePartner.TradePartnerCode 
				+ ' / <b>V: </b>' 
				+ uTradePartnerVendor.VendorCode 
				+ '<BR>' 
				+ dbo.pMaterial.MaterialNo 
				+ ' (' 
				+ dbo.pMaterial.MaterialName 
				+ ') ' 
				+ dbo.pComponentType.ComponentDescription AS CalendarDescription
			,0
		FROM dbo.pMaterialRequestSubmitWorkflow WITH (NOLOCK) 
			INNER JOIN dbo.pMaterialRequestWorkflow WITH (NOLOCK) ON dbo.pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID = dbo.pMaterialRequestWorkflow.MaterialRequestWorkflowID 
			INNER JOIN dbo.pMaterial WITH (NOLOCK) ON dbo.pMaterialRequestSubmitWorkflow.MaterialID = dbo.pMaterial.MaterialID 
			INNER JOIN dbo.uTradePartnerVendor WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID 
			INNER JOIN dbo.uTradePartner WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.TradePartnerID = dbo.uTradePartner.TradePartnerID 
			INNER JOIN dbo.pComponentType WITH (NOLOCK) ON dbo.pComponentType.ComponentTypeID=pMaterial.MaterialType  
		WHERE 
			(dbo.pMaterialRequestSubmitWorkflow.DueDate BETWEEN @StartDate AND @EndDate) 
			AND (dbo.pMaterialRequestSubmitWorkflow.Status NOT IN (SELECT StatusID FROM dbo.pSampleRequestSubmitStatus WHERE ApprovedType = 1 OR StatusID = 4)) 				
			AND (pMaterialRequestSubmitWorkflow.TradePartnerVendorID = @TradePartnerVendorId)
			AND (pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID IN (SELECT SampleWorkflowId FROM pMaterialSampleWorkflowViewSubmit WITH (NOLOCK) WHERE TeamId = @TeamId)) 			    
		ORDER BY dbo.pMaterialRequestSubmitWorkflow.DueDate, dbo.pMaterial.MaterialNo, dbo.pMaterialRequestWorkflow.MaterialRequestWorkflowID 	


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
			,dbo.pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID
			,dbo.pMaterialRequestSubmitWorkflow.DueDate
			,'SampleRequest'
			,pMaterialRequestSubmitWorkflow.Status
			,'<b>A: </b>' 
				+ uTradePartner.TradePartnerCode 
				+ ' / <b>V: </b>' 
				+ uTradePartnerVendor.VendorCode 
				+ '<BR>' 
				+ dbo.pMaterial.MaterialNo 
				+ ' (' 
				+ dbo.pMaterial.MaterialName 
				+ ') ' 
				+ dbo.pComponentType.ComponentDescription AS CalendarDescription
			,0
		FROM dbo.pMaterialRequestSubmitWorkflow WITH (NOLOCK) 
			INNER JOIN dbo.pMaterialRequestWorkflow WITH (NOLOCK) ON dbo.pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID = dbo.pMaterialRequestWorkflow.MaterialRequestWorkflowID 
			INNER JOIN dbo.pMaterial WITH (NOLOCK) ON dbo.pMaterialRequestSubmitWorkflow.MaterialID = dbo.pMaterial.MaterialID 
			INNER JOIN dbo.uTradePartnerVendor WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID 
			INNER JOIN dbo.uTradePartner WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.TradePartnerID = dbo.uTradePartner.TradePartnerID 
			INNER JOIN dbo.pComponentType WITH (NOLOCK) ON dbo.pComponentType.ComponentTypeID=pMaterial.MaterialType  
		WHERE (pMaterialRequestSubmitWorkflow.EndDate BETWEEN @StartDate AND @EndDate) 
			AND (pMaterialRequestSubmitWorkflow.Status = 1) 				
			AND pMaterialRequestSubmitWorkflow.TradePartnerVendorID = @TradePartnerVendorId  
			AND (pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID IN (SELECT SampleWorkflowId FROM pMaterialSampleWorkflowViewSubmit WITH (NOLOCK) WHERE TeamId = @TeamId)) 				
		ORDER BY pMaterialRequestSubmitWorkflow.EndDate, dbo.pMaterial.MaterialNo, dbo.pMaterialRequestWorkflow.MaterialRequestWorkflowID								
	END
SET NOCOUNT OFF	

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01978'))
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
			,'01978'
			,GetDate()
		)
END	
GO




