IF OBJECT_ID(N'[dbo].[dpx_Material_Availability_Tracking_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[dpx_Material_Availability_Tracking_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_Material_Availability_Tracking_SELECT] (
    @SeasonYearID UNIQUEIDENTIFIER
    , @Material NVARCHAR(MAX)
    , @MaterialPartner NVARCHAR(MAX)
    , @MaterialType NVARCHAR(MAX)
    , @Style NVARCHAR(MAX)
    , @StylePartner NVARCHAR(MAX)
    , @StyleType NVARCHAR(MAX)
) AS
BEGIN
	
	DECLARE @tmpMaterial TABLE (MaterialID UNIQUEIDENTIFIER)
	DECLARE @tmpMaterialPartner TABLE (MaterialPartnerID UNIQUEIDENTIFIER)
	DECLARE @tmpMaterialType TABLE (MaterialTypeID INT)
	
	DECLARE @tmpStyle TABLE (StyleID UNIQUEIDENTIFIER)
	DECLARE @tmpStylePartner TABLE (StylePartnerID UNIQUEIDENTIFIER)
	DECLARE @tmpStyleType TABLE (StyleTypeID INT)

	INSERT INTO @tmpMaterial SELECT CAST(value AS UNIQUEIDENTIFIER) FROM dbo.fnx_Split(@Material,',')
	INSERT INTO @tmpMaterialPartner SELECT CAST(value AS UNIQUEIDENTIFIER) FROM dbo.fnx_Split(@MaterialPartner,',')
	INSERT INTO @tmpMaterialType SELECT CAST(value AS INT) FROM dbo.fnx_Split(@MaterialType,',')
	
	INSERT INTO @tmpStyle SELECT CAST(value AS UNIQUEIDENTIFIER) FROM dbo.fnx_Split(@Style,',')
	INSERT INTO @tmpStylePartner SELECT CAST(value AS UNIQUEIDENTIFIER) FROM dbo.fnx_Split(@StylePartner,',')
	INSERT INTO @tmpStyleType SELECT CAST(value AS INT) FROM dbo.fnx_Split(@StyleType,',')

	IF @SeasonYearID IS NULL OR @SeasonYearID = '00000000-0000-0000-0000-000000000000'
		SELECT TOP 1 @SeasonYearID = SeasonYearID FROM pSeasonYear WHERE CurrentSeason = 1

    SELECT DISTINCT
          m.MaterialID
        , m.MaterialNo
        , ct.ComponentDescription
        , m.MaterialName
        , m.B AS Content
    INTO #tmpMaterial
    FROM pMaterial m
    INNER JOIN pComponentType ct ON m.MaterialType = ct.ComponentTypeID
    INNER JOIN pStyleBOM sb ON m.MaterialID = sb.MaterialID
    INNER JOIN pStyleHeader sh ON sb.StyleID = sh.StyleID
    INNER JOIN pStyleSeasonYear ssy ON sh.StyleID = ssy.StyleID
    INNER JOIN @tmpMaterial tm ON m.MaterialID = tm.MaterialID
    INNER JOIN @tmpMaterialType tmt ON m.MaterialType = tmt.MaterialTypeID
    INNER JOIN @tmpStyle ts ON sh.StyleID = ts.StyleID
    INNER JOIN @tmpStyleType tst ON sh.StyleType = tst.StyleTypeID
    WHERE ssy.SeasonYearID = @SeasonYearID
	ORDER BY m.MaterialNo
	
    -- Material Request --
    SELECT 
          0 AS RequestType
        , tm.*
        , tprl.AgentName
        , tprl.VendorName
        , tprl.FactoryName
        , mtpc.ColorName    
        , mtpc.MaterialTradePartnerColorID
        , NULL AS StyleNo
        , NULL AS Description
        , NULL AS StyleCategory
        , NULL AS SizeClass
        , NULL AS WorkflowItemId
        , NULL AS WorkFlowItemName
        , NULL AS StyleID
        , NULL AS SampleRequestTradeID
        , MAX(mrs.DueDate) AS DueDate
        , CASE 
            WHEN COUNT(CASE WHEN mrs.Status = 3 THEN NULL ELSE 1 END) = 0 THEN 'Complete'
            WHEN DATEDIFF(DAY, GETDATE(), MAX(mrs.DueDate)) < 0 THEN CAST(ABS(DATEDIFF(DAY, GETDATE(), MAX(mrs.DueDate))) AS nVARCHAR(5)) + 'd Late'
            ELSE CAST(ABS(DATEDIFF(DAY, GETDATE(), MAX(mrs.DueDate))) AS nVARCHAR(5)) + 'd Remain'
          END AS DaysMessage    
        , CASE 
            WHEN COUNT(CASE WHEN mrs.Status = 3 THEN NULL ELSE 1 END) = 0 THEN 'LightGreen'
            WHEN DATEDIFF(DAY, GETDATE(), MAX(mrs.DueDate)) < 0 THEN 'IndianRed'
            WHEN DATEDIFF(DAY, GETDATE(), MAX(mrs.DueDate)) BETWEEN 0 AND 7 THEN 'Khaki'
            ELSE 'None'
          END AS Color
        , CASE 
            WHEN COUNT(CASE WHEN mrs.Status = 3 THEN NULL ELSE 1 END) = 0 THEN 1 --complete
            WHEN DATEDIFF(DAY, GETDATE(), MAX(mrs.DueDate)) < 0 THEN 2 --late
            ELSE 3 --remain
          END AS DueDateStatus          
    FROM #tmpMaterial tm
    INNER JOIN pMaterialTradePartner mtp ON tm.MaterialID = mtp.MaterialId AND mtp.SeasonYearID = @SeasonYearID
    INNER JOIN pMaterialTradePartnerColor mtpc ON mtp.MaterialTradePartnerId = mtpc.MaterialTradePartnerID
    INNER JOIN pMaterialRequestSubmitWorkflow mrsw ON mtpc.MaterialTradePartnerColorID = mrsw.MaterialTradePartnerColorID
    INNER JOIN pMaterialRequestSubmit mrs ON mrsw.MaterialRequestSubmitWorkflowID = mrs.MaterialRequestSubmitWorkflowID
    INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON mtp.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
    INNER JOIN @tmpMaterialPartner tmp ON ISNULL(mtp.TradePartnerRelationshipLevelID, '00000000-0000-0000-0000-000000000000') = tmp.MaterialPartnerID
    INNER JOIN pStyleBOM sb ON tm.MaterialID = sb.MaterialID
    INNER JOIN pStyleHeader sh ON sb.StyleID = sh.StyleID
    INNER JOIN pStyleSeasonYear ssy ON sh.StyleID = ssy.StyleID AND ssy.SeasonYearID = @SeasonYearID
    GROUP BY 
          tm.MaterialID
        , tm.MaterialNo
        , tm.ComponentDescription
        , tm.MaterialName
        , tm.Content
        , tprl.AgentName 
        , tprl.VendorName
        , tprl.FactoryName
        , mtpc.ColorName
        , mtpc.MaterialTradePartnerColorID
    UNION
    -- Sample Requests --
    SELECT 
          1 AS RequestType
        , tm.*
        , tprl.AgentName
        , tprl.VendorName
        , tprl.FactoryName
        , NULL AS ColorName
        , NULL AS MaterialTradePartnerColorID
        , sh.StyleNo
        , sh.Description
        , sc.StyleCategory
        , COALESCE(scc.Custom, sh.SizeClass) AS SizeClass
        , sb.WorkflowItemId
        , wi.WorkFlowItemName
        , sh.StyleID
        , srt.SampleRequestTradeID
        , MIN(srw.DueDate) AS DueDate    
        , CASE 
            WHEN COUNT(CASE WHEN srw.Status = 3 THEN NULL ELSE 1 END) = 0 THEN 'Complete'
            WHEN DATEDIFF(DAY, GETDATE(), MAX(srw.DueDate)) < 0 THEN CAST(ABS(DATEDIFF(DAY, GETDATE(), MAX(srw.DueDate))) AS nVARCHAR(5)) + 'd Late'
            ELSE CAST(ABS(DATEDIFF(DAY, GETDATE(), MAX(srw.DueDate))) AS nVARCHAR(5)) + 'd Remain'
          END AS DaysMessage    
        , CASE 
            WHEN COUNT(CASE WHEN srw.Status = 3 THEN NULL ELSE 1 END) = 0 THEN 'LightGreen'
            WHEN DATEDIFF(DAY, GETDATE(), MAX(srw.DueDate)) < 0 THEN 'IndianRed'
            WHEN DATEDIFF(DAY, GETDATE(), MAX(srw.DueDate)) BETWEEN 0 AND 7 THEN 'Khaki'
            ELSE 'None'
          END AS Color
        , CASE 
            WHEN COUNT(CASE WHEN srw.Status = 3 THEN NULL ELSE 1 END) = 0 THEN 1 --complete
            WHEN DATEDIFF(DAY, GETDATE(), MAX(srw.DueDate)) < 0 THEN 2 --late
            ELSE 3 --remain
          END AS DueDateStatus             
    FROM #tmpMaterial tm
    INNER JOIN pStyleBOM sb ON tm.MaterialID = sb.MaterialID
    INNER JOIN pWorkFlowItem wi ON sb.WorkflowItemId = wi.WorkFlowItemID
    INNER JOIN pStyleHeader sh ON sb.StyleID = sh.StyleID
    LEFT JOIN pStyleCategory sc ON sh.StyleCategory = sc.StyleCategoryId
	LEFT JOIN pSizeClass scc ON scc.CustomID = sh.SizeClassId
    INNER JOIN pStyleSeasonYear ssy ON sh.StyleID = ssy.StyleID AND ssy.SeasonYearID = @SeasonYearID
    LEFT JOIN pSampleRequestBOMTrade srt ON sb.WorkflowItemId = srt.WorkFlowItemID AND srt.StyleSeasonYearID = ssy.StyleSeasonYearID
    LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON srt.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
    LEFT JOIN pSampleRequestWorkflowBOM srw ON srt.SampleRequestTradeID = srw.SampleRequestTradeID
    INNER JOIN @tmpStylePartner tsp ON ISNULL(srt.TradePartnerRelationshipLevelID, '00000000-0000-0000-0000-000000000000') = tsp.StylePartnerID
    GROUP BY 
          tm.MaterialID
        , tm.MaterialNo
        , tm.ComponentDescription
        , tm.MaterialName
        , tm.Content
        , tprl.AgentName 
        , tprl.VendorName
        , tprl.FactoryName    
        , sh.StyleNo
        , sh.Description
        , sc.StyleCategory
        , COALESCE(scc.Custom, sh.SizeClass)
        , sb.WorkflowItemId
        , wi.WorkFlowItemName
        , sh.StyleID
        , srt.SampleRequestTradeID
    
    ORDER BY RequestType, MaterialName, AgentName, VendorName, FactoryName, ColorName, StyleNo, WorkFlowItemName
    
    DROP TABLE #tmpMaterial

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09550', GetDate())
GO
