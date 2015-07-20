IF OBJECT_ID(N'[dbo].[rpx_SampleRequestActivityCalendarAgent_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[rpx_SampleRequestActivityCalendarAgent_INSERT]
GO

CREATE PROCEDURE [dbo].[rpx_SampleRequestActivityCalendarAgent_INSERT]
	@StartDate	DATETIME,
	@EndDate	DATETIME,	
	@TeamId [NVARCHAR](50),
	@TradePartnerId [NVARCHAR](50)=NULL,
	@RequestedDate DATETIME 
WITH EXECUTE AS CALLER
AS

IF  @TradePartnerID IS NULL OR @TradePartnerID=''
BEGIN
	SET @TradePartnerID =NULL
END

DECLARE @CalendarId AS NVARCHAR(50)


SET	@CalendarId=NEWID()

CREATE TABLE #CurrentMonth(
	[Order] INT NOT NULL,
	[Date] [datetime] NOT NULL,
	[WeekDay] INT NOT NULL,
	[Day] INT NOT NULL,
	[Month] INT NOT NULL,
	[CurrentMonth] INT NOT NULL
)

; WITH Dates([Date]) AS (
SELECT CONVERT(DATETIME,@StartDate) AS [Date]
UNION ALL 
SELECT DATEADD(DAY, 1, [Date]) FROM Dates WHERE Date < CONVERT(DATETIME,@EndDate)
)
INSERT INTO #CurrentMonth
( [Order]
,[Date]
,[WeekDay]
,[Day]
,[Month]
,[CurrentMonth]
)
SELECT   
[Order]= DENSE_RANK() OVER (ORDER BY d.[Date]), 
d.[Date],
[WeekDay] = DATEPART(WEEKDAY, d.[Date]),
[Day] = DATEPART(DAY,d.[Date]),
[Month] = DATEPART(MONTH,d.[Date]),
[CurrentMonth]=DATEPART(MONTH,@RequestedDate)
FROM Dates d

CREATE TABLE #pStyleCalendarTemp(
	RowID INT NOT NULL IDENTITY (0, 1),
	[PKeyId] [NVARCHAR](200) NULL,
	[CalendarId] [uniqueidentifier] NULL,
	[CalendarLinkId] [uniqueidentifier] NULL,
	[CalendarLinkSubId] [NVARCHAR](200) NULL,
	[CalendarType] [NVARCHAR](50) NULL,
	[CalendarStatus] [NVARCHAR](50) NULL,
	[CalendarDate] [datetime] NULL,
	[CalendarDescription] [NVARCHAR](600) NULL,
	[CalendarView] [int] NULL,
	[CalendarSN] [int] NULL,
	[CalendarSubmit] [int] NULL,
	[CalendarLinkSubId1] [uniqueidentifier] NULL,
	[StyleID] [uniqueidentifier] NULL,
	Comment NTEXT
) ON [PRIMARY]


IF @TradePartnerId IS NULL

BEGIN
INSERT INTO #pStyleCalendarTemp
	(
		CalendarId, 
		PKeyId, 
		CalendarLinkId, 
		CalendarLinkSubId, 
		CalendarDate, 
		CalendarType, 
		CalendarStatus, 
		CalendarDescription, 
		CalendarView,
		Comment
	)
SELECT     
		@CalendarId AS CalendarId, 
		pSampleRequestSubmit.SampleRequestWorkflowID, 
		pSampleRequestSubmit.SampleRequestTradeID, 
		pSampleWorkflow.SampleWorkflow + N' (' + CAST(pSampleRequestSubmit.Submit AS nvarchar(4)) + ') ' AS CalendarLinkSubId, 
		pSampleRequestActivity.CDate, 
		'SampleActivity' AS CalendarType, 
		pSampleRequestActivity.ActivityType, 
		'A: ' + uTradePartner.TradePartnerCode + ' / V: ' + uTradePartnerVendor.VendorCode + '' + sh.StyleNo + ' (' +
		COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription, 
		pSampleRequestSubmit.AgentView,
		REPLACE(CAST(pSampleRequestSubmit.Comment AS NVARCHAR(2000)), 'span', 'u')
FROM    pSampleRequestSubmit WITH (NOLOCK) INNER JOIN
		pStyleHeader sh WITH (NOLOCK) ON pSampleRequestSubmit.StyleID = sh.StyleID INNER JOIN
		pSampleWorkflow WITH (NOLOCK) ON pSampleRequestSubmit.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID INNER JOIN
		pSampleRequestActivity WITH (NOLOCK) ON 
		pSampleRequestSubmit.SampleRequestSubmitID = pSampleRequestActivity.SampleRequestSubmitID INNER JOIN
		uTradePartner WITH (NOLOCK) ON pSampleRequestActivity.TradePartnerId = uTradePartner.TradePartnerID INNER JOIN
		uTradePartnerVendor WITH (NOLOCK) ON pSampleRequestActivity.TradePartnerVendorId = uTradePartnerVendor.TradePartnerVendorID INNER JOIN
		pSampleRequestTrade WITH (NOLOCK) ON pSampleRequestSubmit.SampleRequestTradeID = pSampleRequestTrade.SampleRequestTradeID INNER JOIN
		fnx_Permissions_GetIntProductType_WorkflowPermissions(@TeamID, 5, NULL) access ON pSampleWorkflow.SampleWorkflowGUID = access.WorkflowId AND sh.StyleType = access.ProductTypeID
		LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
WHERE  (pSampleRequestActivity.TradePartner = 0)
		AND (pSampleRequestActivity.CDate BETWEEN @StartDate AND @EndDate) 
		AND (pSampleRequestActivity.ActivityType NOT IN ('V','U')) 
		AND (pSampleRequestSubmit.SampleWorkflowID IN (SELECT SampleWorkflowId FROM  pSampleWorkflowViewSubmit WITH (NOLOCK) WHERE TeamId = @TeamId))  
		AND (access.PermissionRoleId = 3 OR access.PermissionView = 1)
		ORDER BY pSampleRequestActivity.Cdate DESC, sh.StyleNo, pSampleWorkflow.SampleWorkflowID 	
END
ELSE

BEGIN
INSERT INTO #pStyleCalendarTemp
	(
		CalendarId, 
		PKeyId, 
		CalendarLinkId, 
		CalendarLinkSubId, 
		CalendarDate, 
		CalendarType, 
		CalendarStatus, 
		CalendarDescription, 
		CalendarView,
		Comment
	)
SELECT     
		@CalendarId AS CalendarId, 
		pSampleRequestSubmit.SampleRequestWorkflowID, 
		pSampleRequestSubmit.SampleRequestTradeID, 
		pSampleWorkflow.SampleWorkflow + N' (' + CAST(pSampleRequestSubmit.Submit AS nvarchar(4)) + ') ' AS CalendarLinkSubId, 
		pSampleRequestActivity.CDate, 
		'SampleActivity' AS CalendarType, 
		pSampleRequestActivity.ActivityType, 
		'A: ' + uTradePartner.TradePartnerCode + ' / V: ' + uTradePartnerVendor.VendorCode + '' + sh.StyleNo + ' (' +
		COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription, 
		pSampleRequestSubmit.AgentView,
		REPLACE(CAST(pSampleRequestSubmit.Comment AS NVARCHAR(2000)), 'span', 'u')
FROM    pSampleRequestSubmit WITH (NOLOCK) INNER JOIN
		pStyleHeader sh WITH (NOLOCK) ON pSampleRequestSubmit.StyleID = sh.StyleID INNER JOIN
		pSampleWorkflow WITH (NOLOCK) ON pSampleRequestSubmit.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID INNER JOIN
		pSampleRequestActivity WITH (NOLOCK) ON 
		pSampleRequestSubmit.SampleRequestSubmitID = pSampleRequestActivity.SampleRequestSubmitID INNER JOIN
		uTradePartner WITH (NOLOCK) ON pSampleRequestActivity.TradePartnerId = uTradePartner.TradePartnerID INNER JOIN
		uTradePartnerVendor WITH (NOLOCK) ON pSampleRequestActivity.TradePartnerVendorId = uTradePartnerVendor.TradePartnerVendorID INNER JOIN
		pSampleRequestTrade WITH (NOLOCK) ON pSampleRequestSubmit.SampleRequestTradeID = pSampleRequestTrade.SampleRequestTradeID INNER JOIN 
		fnx_Permissions_GetIntProductType_WorkflowPermissions(@TeamID, 5, NULL) access ON pSampleWorkflow.SampleWorkflowGUID = access.WorkflowId AND sh.StyleType = access.ProductTypeID
		LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
WHERE	(pSampleRequestActivity.TradePartnerId = @TradePartnerId) 
		AND (pSampleRequestActivity.TradePartner = 0)
		AND (pSampleRequestActivity.CDate BETWEEN @StartDate AND @EndDate) 
		AND (pSampleRequestActivity.ActivityType NOT IN ('V','U')) 
		AND (pSampleRequestSubmit.SampleWorkflowID IN (SELECT SampleWorkflowId FROM  pSampleWorkflowViewSubmit WITH (NOLOCK) WHERE TeamId = @TeamId))  
		AND (access.PermissionRoleId = 3 OR access.PermissionView = 1)
		ORDER BY pSampleRequestActivity.Cdate DESC, sh.StyleNo, pSampleWorkflow.SampleWorkflowID 	
END


SELECT CM.[Order],CM.[DATE],CM.[WeekDay],CM.[Day],CM.[Month],SC.CalendarDescription,SC.PKeyId AS SampleRequestWorkflowID,
SC.CalendarLinkId AS SampleRequestTradeID,CM.CurrentMonth,SC.Comment
FROM #CurrentMonth CM
LEFT OUTER JOIN #pStyleCalendarTemp SC ON CAST(CONVERT(nVARCHAR(10),SC.CalendarDate,101) AS DATETIME) = CM.[Date]

DROP TABLE #CurrentMonth
DROP TABLE #pStyleCalendarTemp


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09611', GetDate())
GO
