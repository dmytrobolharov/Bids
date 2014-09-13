IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Material_SampleRequestActivityCalendarAgent_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Material_SampleRequestActivityCalendarAgent_INSERT]
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
* Name        : spx_Material_SampleRequestActivityCalendarAgent_INSERT
*
* Description : To insert all data related to agent sample request activity for calender 
*
* Change History:                  
* ------------------
* Date			Version			Author			Comment
* 09/23/2011	  --			Yogesh Lad		Created for insert all data related to agent sample 
												request activity for calender. 
*
*
-------------------------------------------------------------------------------------------------- */

CREATE PROCEDURE [dbo].[spx_Material_SampleRequestActivityCalendarAgent_INSERT]
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

SELECT @CalendarId AS CalendarId,
	mrw.MaterialRequestWorkflowID AS PKeyId,
	mrs.MaterialTradePartnerID AS CalendarLinkId,
	mrw.MaterialRequestWorkflow + N' (' + CAST(mrs.Submit AS nVARCHAR(4)) + ') ' AS CalendarLinkSubId,
	mrsw.MaterialTradePartnerColorID AS CalendarLinkSubId1,
	ma.CDate AS CalendarDate,
	'SampleActivity' AS CalendarType,
	ma.ActivityType AS CalendarStatus,
	CASE WHEN mtp.TradePartnerRelationshipLevelID IS NOT NULL
		THEN SUBSTRING(ISNULL('/' + tprl.AgentName, '') + ISNULL('/' + tprl.VendorName, '') + ISNULL('/' + tprl.FactoryName, ''), 2, 2000)
		ELSE '<b>A: </b>' + tp.TradePartnerCode + ' / <b>V: </b>' + tpv.VendorCode
	END + '<BR>' + m.MaterialNo + ' (' + m.MaterialName + ') ' + ct.ComponentDescription AS CalendarDescription,
	mrs.AgentView AS CalendarView,
	-- columns for search purposes
	tp.TradePartnerID, tpv.TradePartnerVendorID,
	tprl.AgentID, tprl.VendorID, tprl.FactoryID
INTO #tmpCal
FROM pMaterialRequestSubmit mrs WITH (NOLOCK)
INNER JOIN pMaterialRequestSubmitWorkflow mrsw WITH (NOLOCK) ON mrsw.MaterialRequestSubmitWorkflowID = mrs.MaterialRequestSubmitWorkflowID
INNER JOIN pMaterialRequestWorkflow mrw WITH (NOLOCK) ON mrsw.MaterialRequestWorkflowID = mrw.MaterialRequestWorkflowID
INNER JOIN pMaterial m WITH (NOLOCK) ON mrsw.MaterialID = m.MaterialID
INNER JOIN pComponentType ct WITH (NOLOCK) ON m.MaterialType = ct.ComponentTypeID
INNER JOIN pMaterialActivity ma WITH (NOLOCK) ON mrsw.MaterialID = ma.MaterialID
INNER JOIN pMaterialTradePartner mtp ON mrsw.MaterialTradePartnerID = mtp.MaterialTradePartnerID
LEFT JOIN uTradePartnerVendor tpv WITH (NOLOCK) ON mtp.TradePartnerVendorID = tpv.TradePartnerVendorID AND mtp.TradePartnerRelationshipLevelID IS NULL
LEFT JOIN uTradePartner tp WITH (NOLOCK) ON mtp.TradePartnerID = tp.TradePartnerID AND mtp.TradePartnerRelationshipLevelID IS NULL
LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON mtp.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
WHERE (@TradePartnerId IS NULL OR mrsw.TradePartnerID = @TradePartnerId)
	AND ma.TradePartner = 0
	AND ma.CDate BETWEEN @StartDate AND @EndDate
	AND ma.ActivityType NOT IN ('V', 'U')
	AND mrw.MaterialRequestWorkflow IN (
			SELECT SampleWorkflowId FROM pMaterialSampleWorkflowViewSubmit WITH (NOLOCK) WHERE TeamId = @TeamId)
ORDER BY ma.Cdate DESC, m.MaterialNo, mrw.MaterialRequestWorkflowID

exec(N'
INSERT INTO pStyleCalendarTemp (
	CalendarId, PKeyId, CalendarLinkId,  CalendarLinkSubId, CalendarLinkSubId1,
	CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
SELECT CalendarId, PKeyId, CalendarLinkId,  CalendarLinkSubId, CalendarLinkSubId1,
	CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView
FROM #tmpCal ' + @SearchCond)

SET NOCOUNT OFF	


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06775', GetDate())
GO
