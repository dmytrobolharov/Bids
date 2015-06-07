IF OBJECT_ID(N'[dbo].[rpx_Material_SampleRequestWorkflowAgentLate_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[rpx_Material_SampleRequestWorkflowAgentLate_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_Material_SampleRequestWorkflowAgentLate_SELECT]
(
    @TradePartnerID UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000'
    , @TeamID UNIQUEIDENTIFIER
    , @Filter NVARCHAR (MAX)
    , @NoOfSubmits NVARCHAR (10)
    , @UserID NVARCHAR(10)
    , @AssignedTo NVARCHAR (MAX)
    , @SeasonYear NVARCHAR (MAX)
    , @Agent NVARCHAR (MAX)
    , @Vendor NVARCHAR (MAX)
    , @Factory NVARCHAR (MAX) 
)
AS
BEGIN

	DECLARE @PrefLanguage NVARCHAR(10) = (SELECT PreferredLang FROM Users WHERE TeamID = @TeamId)

	SELECT
		m.MaterialNo
		, m.MaterialName
		, ct.ComponentDescription
		, cp.ColorName
		, sy.Season
		, sy.Year
		, tprl.AgentName
		, tprl.VendorName
		, tprl.FactoryName
		, mrw.MaterialRequestWorkflow
		, mrsw.DueDate
		, dbo.fnx_DatetimeToString(mrsw.DueDate, @PrefLanguage) AS DueDateTxt
		, CASE
			WHEN mrss.ApprovedType = 1 THEN 'Apprvd'
			WHEN DATEDIFF(d, GETDATE(), mrsw.DueDate)<0 THEN CAST(ABS(DATEDIFF(d, GETDATE(), mrsw.DueDate)) AS NVARCHAR(5)) + 'd Late'
			ELSE CAST(ABS(DATEDIFF(d, GETDATE(), mrsw.DueDate)) AS NVARCHAR(5)) + 'd Remain'
		  END AS TextMessage	
		, CASE
			WHEN mrss.ApprovedType = 1 THEN 'PaleGreen'
			WHEN DATEDIFF(d, GETDATE(), mrsw.DueDate)<=0 THEN 'IndianRed'
			ELSE 'No Color'
		  END AS Color
		, ISNULL(tprl.AgentID, '00000000-0000-0000-0000-000000000000') AS AgentID
		, ISNULL(tprl.VendorID, '00000000-0000-0000-0000-000000000000') AS VendorID
		, ISNULL(tprl.FactoryID, '00000000-0000-0000-0000-000000000000') AS FactoryID
		, mtp.TradePartnerRelationshipLevelID
		, mrsw.Status
		, sy.SeasonYearID
		, m.MaterialType
		, mrsw.MaterialRequestWorkflowID
		, mtpc.MaterialTradePartnerColorID
		, m.MaterialID
		, m.MaterialCode
		, mrsw.Submit
	INTO #tmpMatRequest
	FROM pMaterial m
		INNER JOIN pMaterialTradePartner mtp ON m.MaterialID = mtp.MaterialId
		INNER JOIN pMaterialTradePartnerColor mtpc ON mtp.MaterialTradePartnerId = mtpc.MaterialTradePartnerID
		INNER JOIN pMaterialRequestSubmitWorkflow mrsw ON mtpc.MaterialTradePartnerColorID = mrsw.MaterialTradePartnerColorID
		INNER JOIN pComponentType ct ON m.MaterialType = ct.ComponentTypeID
		LEFT JOIN pColorPalette cp ON mtpc.ColorPaletteID = cp.ColorPaletteID
		LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON mtp.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
		LEFT JOIN pMaterialRequestWorkflow mrw ON mrsw.MaterialRequestWorkflowID = mrw.MaterialRequestWorkflowID
		LEFT JOIN pSeasonYear sy ON mtp.SeasonYearID = sy.SeasonYearID
		LEFT JOIN pMaterialRequestSubmitStatus mrss ON mrsw.Status = mrss.StatusID
		INNER JOIN Users u ON mrsw.AssignedTo = u.UserId
		INNER JOIN pMaterialSampleWorkflowViewSubmit mrvs ON mrw.MaterialRequestWorkflowID = mrvs.SampleWorkflowID AND mrvs.TeamID = @TeamID
	WHERE
		mrsw.DueDate <= GETDATE()
		AND mrsw.[Status] IN (0, 1)
		AND mrw.Active='1'
		AND (mrsw.Submit >= @NoOfSubmits OR @NoOfSubmits IS NULL OR @NoOfSubmits = '')
		AND (tprl.AgentID = @TradePartnerID OR tprl.VendorID = @TradePartnerID OR tprl.FactoryID = @TradePartnerID OR @TradePartnerID = '00000000-0000-0000-0000-000000000000')
		AND (mrsw.AssignedTo = @UserID OR @UserID IS NULL OR @UserID = '')
		AND (mrsw.AssignedTo IN (SELECT value FROM dbo.fnx_Split(@AssignedTo, ',')) OR @AssignedTo IS NULL OR @AssignedTo = '')
		AND (sy.SeasonYearID IN (SELECT value FROM dbo.fnx_Split(@SeasonYear, ',')) OR @SeasonYear IS NULL OR @SeasonYear = '')
		AND (tprl.AgentID IN (SELECT value FROM dbo.fnx_Split(@Agent, ',')) OR @Agent IS NULL OR @Agent = '')
		AND (tprl.VendorID IN (SELECT value FROM dbo.fnx_Split(@Vendor, ',')) OR @Vendor IS NULL OR @Vendor = '')
		AND (tprl.FactoryID IN (SELECT value FROM dbo.fnx_Split(@Factory, ',')) OR @Factory IS NULL OR @Factory = '')
	ORDER BY
		m.MaterialNo
		, cp.ColorName
		, sy.Season + ' ' + sy.Year

	IF LEN(@Filter)>0
		EXEC ('SELECT * FROM #tmpMatRequest WHERE ' + @Filter)
	ELSE
		EXEC ('SELECT * FROM #tmpMatRequest')
	
	DROP TABLE #tmpMatRequest		
	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10429', GetUTCDate())
GO
