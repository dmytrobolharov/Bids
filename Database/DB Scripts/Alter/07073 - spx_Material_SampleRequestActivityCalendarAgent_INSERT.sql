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
	@SearchCond NVARCHAR(MAX) = N'',
	@UserID INT = NULL,
	@AssignedTo NVARCHAR (MAX) = NULL,
	@SeasonYear NVARCHAR (MAX) = NULL,
	@Agent NVARCHAR (MAX) = NULL,
	@Vendor NVARCHAR (MAX) = NULL,
	@Factory NVARCHAR (MAX)	= NULL
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
	END + '<BR>' + ISNULL(m.MaterialNo,'') + ' (' + ISNULL(m.MaterialName,'') + ') ' + ct.ComponentDescription AS CalendarDescription,
	mrs.AgentView AS CalendarView,
	-- columns for search purposes
	tp.TradePartnerID, tpv.TradePartnerVendorID,
	tprl.AgentID, tprl.VendorID, tprl.FactoryID,
	ct.ComponentTypeID AS MaterialTypeId, m.MaterialNo, m.MaterialName,
	cp.ColorCode, cp.ColorName
INTO #tmpCal
FROM pMaterialRequestSubmit mrs WITH (NOLOCK)
INNER JOIN pMaterialRequestSubmitWorkflow mrsw WITH (NOLOCK) ON mrsw.MaterialRequestSubmitWorkflowID = mrs.MaterialRequestSubmitWorkflowID
INNER JOIN pMaterialRequestWorkflow mrw WITH (NOLOCK) ON mrsw.MaterialRequestWorkflowID = mrw.MaterialRequestWorkflowID
INNER JOIN pMaterial m WITH (NOLOCK) ON mrsw.MaterialID = m.MaterialID
INNER JOIN pComponentType ct WITH (NOLOCK) ON m.MaterialType = ct.ComponentTypeID
INNER JOIN pMaterialActivity ma WITH (NOLOCK) ON mrsw.MaterialID = ma.MaterialID
INNER JOIN pMaterialTradePartner mtp ON mrsw.MaterialTradePartnerID = mtp.MaterialTradePartnerID
INNER JOIN pMaterialTradePartnerColor mtpc WITH (NOLOCK) ON mrsw.MaterialTradePartnerColorID = mtpc.MaterialTradePartnerColorID
LEFT JOIN pMaterialColor mc ON mc.MaterialColorID = mtpc.MaterialColorID   
LEFT JOIN pColorPalette cp ON cp.ColorPaletteID = mc.ColorPaletteID 
LEFT JOIN uTradePartnerVendor tpv WITH (NOLOCK) ON mtp.TradePartnerVendorID = tpv.TradePartnerVendorID AND mtp.TradePartnerRelationshipLevelID IS NULL
LEFT JOIN uTradePartner tp WITH (NOLOCK) ON mtp.TradePartnerID = tp.TradePartnerID AND mtp.TradePartnerRelationshipLevelID IS NULL
LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON mtp.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
WHERE ma.TradePartner = 0
	AND ma.CDate BETWEEN @StartDate AND @EndDate
	AND ma.ActivityType NOT IN ('V', 'U')
	AND mrw.MaterialRequestWorkflow IN (
			SELECT SampleWorkflowId FROM pMaterialSampleWorkflowViewSubmit WITH (NOLOCK) WHERE TeamId = @TeamId)
	AND (mrsw.AssignedTo = @UserID OR @UserID IS NULL)
	AND (mrsw.AssignedTo IN (SELECT value FROM dbo.fnx_Split(@AssignedTo, ',')) OR @AssignedTo IS NULL)
	AND (mtp.SeasonYearID IN (SELECT value FROM dbo.fnx_Split(@SeasonYear, ',')) OR @SeasonYear IS NULL)
	AND (tprl.AgentID IN (SELECT value FROM dbo.fnx_Split(@Agent, ',')) OR @Agent IS NULL)
	AND (tprl.VendorID IN (SELECT value FROM dbo.fnx_Split(@Vendor, ',')) OR @Vendor IS NULL)
	AND (tprl.FactoryID IN (SELECT value FROM dbo.fnx_Split(@Factory, ',')) OR @Factory IS NULL)
ORDER BY ma.Cdate DESC, m.MaterialNo, mrw.MaterialRequestWorkflowID

exec(N'
INSERT INTO pStyleCalendarTemp (
	CalendarId, PKeyId, CalendarLinkId,  CalendarLinkSubId, CalendarLinkSubId1,
	CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
SELECT CalendarId, PKeyId, CalendarLinkId,  CalendarLinkSubId, CalendarLinkSubId1,
	CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView
FROM #tmpCal ' + @SearchCond)

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07073', GetDate())
GO
