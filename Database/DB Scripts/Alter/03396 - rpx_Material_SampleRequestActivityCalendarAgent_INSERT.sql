/****** Object:  StoredProcedure [dbo].[rpx_Material_SampleRequestActivityCalendarAgent_INSERT]    Script Date: 04/27/2012 12:07:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Material_SampleRequestActivityCalendarAgent_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Material_SampleRequestActivityCalendarAgent_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[rpx_Material_SampleRequestActivityCalendarAgent_INSERT]    Script Date: 04/27/2012 12:07:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[rpx_Material_SampleRequestActivityCalendarAgent_INSERT]
	@StartDate	DATETIME,
	@EndDate	DATETIME,	
	@TeamId [varchar](50),
	@TradePartnerId [varchar](50)=NULL,
	@RequestedDate DATETIME 
WITH EXECUTE AS CALLER
AS 
SET NOCOUNT ON

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
	[PKeyId] [varchar](200) NULL,
	[CalendarId] [uniqueidentifier] NULL,
	[CalendarLinkId] [uniqueidentifier] NULL,
	[CalendarLinkSubId] [varchar](200) NULL,
	[CalendarType] [varchar](50) NULL,
	[CalendarStatus] [varchar](50) NULL,
	[CalendarDate] [datetime] NULL,
	[CalendarDescription] [varchar](200) NULL,
	[CalendarView] [int] NULL,
	[CalendarSN] [int] NULL,
	[CalendarSubmit] [int] NULL,
	[CalendarLinkSubId1] [uniqueidentifier] NULL,
	[StyleID] [uniqueidentifier] NULL,
	[SubmitComment] NTEXT
) ON [PRIMARY]




IF @TradePartnerId IS NOT NULL
BEGIN
	INSERT INTO #pStyleCalendarTemp
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
		,SubmitComment
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
		,'A: ' 
			+ uTradePartner.TradePartnerCode 
			+ ' / V: ' + uTradePartnerVendor.VendorCode 
			+ '   ' + pMaterial.MaterialNo 
			+ ' (' + pMaterial.MaterialName 
			+ ') ' 
			+ pComponentType.ComponentDescription AS CalendarDescription
		,pMaterialRequestSubmit.AgentView
		,CONVERT(NTEXT,pMaterialRequestSubmit.SubmitComment)
	FROM 
		pMaterialRequestSubmit WITH (NOLOCK) INNER JOIN	pMaterialRequestSubmitWorkflow WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID = dbo.pMaterialRequestSubmit.MaterialRequestSubmitWorkflowID 
		INNER JOIN pMaterialRequestWorkflow  WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID = pMaterialRequestWorkflow.MaterialRequestWorkflowID  
		INNER JOIN pMaterial WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.MaterialID = pMaterial.MaterialID 
		INNER JOIN pMaterialActivity WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.MaterialID = pMaterialActivity.MaterialID 
		INNER JOIN uTradePartner WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.TradePartnerID = uTradePartner.TradePartnerID 
		INNER JOIN uTradePartnerVendor WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID 
		INNER JOIN pComponentType WITH (NOLOCK) ON pMaterial.MaterialType= pComponentType.ComponentTypeID 
	WHERE (pMaterialRequestSubmitWorkflow.TradePartnerID = @TradePartnerId) 
		AND (pMaterialActivity.TradePartner = 0)
		AND (pMaterialActivity.CDate BETWEEN @StartDate AND @EndDate) 
		AND (pMaterialActivity.ActivityType NOT IN ('V','U')) 
		AND (pMaterialRequestWorkflow.MaterialRequestWorkflow 
		IN  (
				SELECT SampleWorkflowId FROM pMaterialSampleWorkflowViewSubmit WITH (NOLOCK) 
				WHERE TeamId = @TeamId)
			) 				
	ORDER BY pMaterialActivity.Cdate DESC,pMaterial.MaterialNo,pMaterialRequestWorkflow.MaterialRequestWorkflowID 
END
ELSE
BEGIN
	INSERT INTO #pStyleCalendarTemp
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
		,SubmitComment
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
		,'A: ' 
			+ uTradePartner.TradePartnerCode 
			+ ' / V: ' 
			+ uTradePartnerVendor.VendorCode 
			+ '   ' + pMaterial.MaterialNo 
			+ ' (' 
			+ pMaterial.MaterialName 
			+ ') ' 
			+ pComponentType.ComponentDescription AS CalendarDescription
		,pMaterialRequestSubmit.AgentView
		,CONVERT(NTEXT,pMaterialRequestSubmit.SubmitComment)
	FROM pMaterialRequestSubmit WITH (NOLOCK) INNER JOIN				
		pMaterialRequestSubmitWorkflow WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID = dbo.pMaterialRequestSubmit.MaterialRequestSubmitWorkflowID 
		INNER JOIN pMaterialRequestWorkflow  WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID = pMaterialRequestWorkflow.MaterialRequestWorkflowID  
		INNER JOIN pMaterial WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.MaterialID = pMaterial.MaterialID 
		INNER JOIN pMaterialActivity WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.MaterialID = pMaterialActivity.MaterialID 
		INNER JOIN uTradePartner WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.TradePartnerID = uTradePartner.TradePartnerID 
		INNER JOIN uTradePartnerVendor WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID 
		INNER JOIN pComponentType WITH (NOLOCK) ON pMaterial.MaterialType= pComponentType.ComponentTypeID 
	WHERE (pMaterialActivity.TradePartner = 0)
		AND (pMaterialActivity.CDate BETWEEN @StartDate AND @EndDate) 
		AND (pMaterialActivity.ActivityType NOT IN ('V','U')) 
		AND (pMaterialRequestWorkflow.MaterialRequestWorkflowID IN (SELECT SampleWorkflowId FROM pMaterialSampleWorkflowViewSubmit WITH (NOLOCK) WHERE TeamId = @TeamId)) 				
	ORDER BY pMaterialActivity.Cdate DESC, pMaterial.MaterialNo,pMaterialRequestWorkflow.MaterialRequestWorkflowID 		
END

SELECT CM.[Order],CM.[DATE],CM.[WeekDay],CM.[Day],CM.[Month],SC.CalendarDescription,
SC.PKeyId AS SampleRequestWorkflowID,
SC.CalendarLinkId AS SampleRequestTradeID,SC.CalendarLinkSubId1 AS MaterialTradePartnerColorID,
CM.CurrentMonth,SC.SubmitComment
FROM #CurrentMonth CM
LEFT OUTER JOIN #pStyleCalendarTemp SC ON CAST(CONVERT(VARCHAR(10),SC.CalendarDate,101) AS DATETIME) = CM.[Date]

DROP TABLE #CurrentMonth
DROP TABLE #pStyleCalendarTemp


SET NOCOUNT OFF	


GO

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03396', GetDate())
GO
