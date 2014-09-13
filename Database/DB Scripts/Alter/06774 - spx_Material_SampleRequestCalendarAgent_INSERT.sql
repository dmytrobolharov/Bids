IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Material_SampleRequestCalendarAgent_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Material_SampleRequestCalendarAgent_INSERT]
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
	@TeamId nvarchar(50),
	@TradePartnerId nvarchar(50) = NULL,
	@CalendarId nvarchar(50),
	@StartDate datetime,
	@EndDate datetime,
	@SearchCond NVARCHAR(MAX) = N''
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
	
SELECT @CalendarId AS CalendarId,
	mrsw.MaterialRequestWorkflowID AS PKeyId,
	mrsw.MaterialTradePartnerID AS CalendarLinkId,
	mrw.MaterialRequestWorkflow + N' (' + CAST(mrsw.Submit AS nVARCHAR(4)) + ') ' AS CalendarLinkSubId,
	mrsw.MaterialTradePartnerColorID AS CalendarLinkSubId1,
	mrsw.DueDate AS CalendarDate,
	'SampleRequest' AS CalendarType,
	mrsw.Status as CalendarStatus,
	CASE WHEN mtp.TradePartnerRelationshipLevelID IS NOT NULL
		THEN SUBSTRING(ISNULL('/' + tprl.AgentName, '') + ISNULL('/' + tprl.VendorName, '') + ISNULL('/' + tprl.FactoryName, ''), 2, 2000)
		ELSE '<b>A: </b>' + tp.TradePartnerCode + ' / <b>V: </b>' + tpv.VendorCode
	END + '<BR>' + m.MaterialNo + ' (' + m.MaterialName + ') ' + ct.ComponentDescription AS CalendarDescription,
	0 AS CalendarView,
	-- columns for search purposes
	tp.TradePartnerID, tpv.TradePartnerVendorID,
	tprl.AgentID, tprl.VendorID, tprl.FactoryID
INTO #tmpCal
FROM pMaterialRequestSubmitWorkflow mrsw WITH (NOLOCK)
INNER JOIN pMaterialRequestWorkflow mrw WITH (NOLOCK) ON mrsw.MaterialRequestWorkflowID = mrw.MaterialRequestWorkflowID
INNER JOIN pMaterial m WITH (NOLOCK) ON mrsw.MaterialID = m.MaterialID
INNER JOIN pComponentType ct WITH (NOLOCK) ON ct.ComponentTypeID = m.MaterialType
INNER JOIN pMaterialTradePartner mtp ON mrsw.MaterialTradePartnerID = mtp.MaterialTradePartnerID
LEFT JOIN uTradePartnerVendor tpv WITH (NOLOCK) ON mtp.TradePartnerVendorID = tpv.TradePartnerVendorID AND mtp.TradePartnerRelationshipLevelID IS NULL
LEFT JOIN uTradePartner tp WITH (NOLOCK) ON mtp.TradePartnerID = tp.TradePartnerID AND mtp.TradePartnerRelationshipLevelID IS NULL
LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON mtp.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
WHERE (mrsw.DueDate BETWEEN @StartDate AND @EndDate
	AND mrsw.STATUS NOT IN (
		SELECT StatusID FROM dbo.pMaterialRequestSubmitStatus
		WHERE ApprovedType = 1 OR StatusID = 4)
	) OR (
		mrsw.Status = 1 AND mrsw.EndDate BETWEEN @StartDate AND @EndDate
	) AND mrsw.MaterialRequestWorkflowID IN (
		SELECT SampleWorkflowId FROM pMaterialSampleWorkflowViewSubmit WITH (NOLOCK) WHERE TeamId = @TeamId)
	AND (@TradePartnerId IS NULL OR @TradePartnerId IN (tprl.AgentID, tprl.VendorID, tprl.FactoryID, tp.TradePartnerID))
ORDER BY mrsw.DueDate, m.MaterialNo, mrw.MaterialRequestWorkflowID

exec(N'
INSERT INTO pStyleCalendarTemp (
	CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarLinkSubId1,
	CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
SELECT CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarLinkSubId1,
	CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView
FROM #tmpCal ' + @SearchCond)

DROP TABLE #tmpCal

SET NOCOUNT OFF

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06774', GetDate())
GO
