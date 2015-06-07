IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_Style_AgentVendor_Change_ActivityTracking_SUB_1_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_Style_AgentVendor_Change_ActivityTracking_SUB_1_SELECT]
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[dpx_Style_AgentVendor_Change_ActivityTracking_SUB_1_SELECT]
(	
	 @DateFrom			datetime = NULL
	,@DateTo			datetime = NULL
	,@ShowStyleDevelWorkflow	int
	,@Season			nvarchar(200) = NULL
	,@Year				nvarchar(200) = NULL   --- can not be int since pStyleHeader.CustomField4 has '*n/a' 
	--,@StyleSubCategory		nvarchar(200) = NULL   -- pStyleHeader.CustomField5 (Item Category on plmOn)
	,@StyleCategoryID		nvarchar(40) = NULL  -- pStyleCategory.StyleCategoryID (Item Category on plmOn)
	,@TradePartnerID		nvarchar(40) = NULL    -- uniqueidentifier in the table
	--,@TradePartnerVendorID		nvarchar(40) = NULL    -- uniqueidentifier in the table
	,@SortBy			int = NULL
) WITH RECOMPILE
AS


--/************/
--/*Testing.	*/
--/************/
--BEGIN
--	DECLARE @DateFrom datetime
--	DECLARE @DateTo datetime
--	DECLARE @ShowStyleDevelWorkflow int
--	DECLARE @Season nvarchar(200)
--	DECLARE @Year nvarchar(200)
--	DECLARE @StyleCategoryID nvarchar(40)
--	DECLARE @TradePartnerID nvarchar(40)
--	DECLARE @SortBy int
--
--	SET @DateFrom = NULL
--	SET @DateTo = NULL
--	SET @ShowStyleDevelWorkflow = NULL
--	SET @Season = NULL
--	SET @Year = NULL
--	SET @StyleCategoryID = NULL
--	SET @TradePartnerID = NULL
--	SET @SortBy = NULL
--END



BEGIN
	SET NOCOUNT ON;
IF @DateFrom IS NULL  or @DateFrom = ''
BEGIN
   SET @DateFrom = '01/01/1900'
END 
IF @DateTo IS NULL  or @DateTo = ''
BEGIN 
   SET @DateTo= '12/31/2900'
END 
IF  @TradePartnerID IS NULL
	BEGIN
	 SET @TradePartnerID = 'ALL'
	END
IF @Season IS NULL
BEGIN
 SET @Season = 'ALL'
END
IF @Year IS NULL
BEGIN
 SET @Year = 'ALL'
END

--IF @StyleSubCategory	 IS NULL
--BEGIN
--- SET @StyleSubCategory	 = 'ALL'
--END

DECLARE @TotalRecordCount bigint



IF @StyleCategoryID	 IS NULL or @StyleCategoryID	= ''
BEGIN
 SET @StyleCategoryID	 = 'ALL'
END


CREATE TABLE #TempStyleDevelChange
(
	rowNum				bigint IDENTITY
	,TradePartnerID			uniqueidentifier 
	,TradePartnerName		nvarchar(200)
	,StyleID			uniqueidentifier
	,StyleNo			nvarchar(20) 
	,FilePath			nvarchar(300) 
     	,Descrip			nvarchar(100)
	,SizeClass			nvarchar(400)
	,StyleSet			int
	--,WorkflowID			uniqueidentifier
	,Workflow			nvarchar(100)
	,StyleChangeBy			nvarchar(100)
	,StyleChangeDescription		nvarchar(4000)
	,StyleCostingCustomField18	int
	,StartShipDate			datetime
	,StyleChangeDate		datetime
	,StyleChangeType		nvarchar(100)
	,StyleYear			nvarchar(200)
	,Season				nvarchar(200)
	--,StyleSubCategory		nvarchar(200)
	,StyleSubCategory		nvarchar(255)
	,subReportNum			int
	,imageShowFlag			int
)


CREATE TABLE #TempRowNum
(
	TradePartnerName		nvarchar(200)
	,TradePartnerID			uniqueidentifier 
	,StyleNo			nvarchar(20) 
	,StyleID			uniqueidentifier
	,minRowNum			bigint
)


IF @SortBy = 1
	BEGIN
		INSERT INTO #TempStyleDevelChange (	
				TradePartnerID, 
				TradePartnerName, 
				StyleID, 
				StyleNo, FilePath,
				Descrip, SizeClass, StyleSet,
				--WorkflowID,
				Workflow, 
				StyleChangeBy,StyleChangeDescription, StyleCostingCustomField18,StartShipDate, StyleChangeDate,StyleChangeType,
				StyleYear, Season, StyleSubCategory,
				subReportNum, imageShowFlag)
		SELECT
			ut.TradePartnerID
			,ut.TradePartnerName
			,c.StyleID
			,h.StyleNo
			,(SELECT TOP 1 dbo.fnx_GetStreamingImagePath(hImage.ImageID, hImage.[Version], 2000)	--Comment #02 
					FROM	pStyleHeader LEFT OUTER JOIN hImage ON
						pStyleHeader.DesignSketchID = hImage.ImageID AND
						pStyleHeader.DesignSketchVersion = hImage.Version
					WHERE pStyleHeader.StyleID = h.StyleID
				) AS FilePath
			,h.[Description]
			,COALESCE(scc.Custom, h.SizeClass)
			,c.StyleSet
			--,c.WorkflowID
			,ISNULL(p.Workflow, 'Style Header') AS Workflow
			,c.StyleChangeBy
			,c.StyleChangeDescription
			--,c.StyleChangeNo
			,sc.StyleCostingCustomField18 -- number of units to sort from the biggest order to smallest order
			,(CASE WHEN h.CustomField10 IS NULL THEN NULL
		              WHEN h.CustomField10 = '' THEN NULL
		              ELSE CAST(h.CustomField10 AS datetime) 
		              END)
					  /*NULL as StartShipDate		--Comment #01*/
			,c.StyleChangeDate
			,c.StyleChangeType
			,LTRIM(RTRIM(h.CustomField4)) as StyleYear
			,LTRIM(RTRIM(h.CustomField2)) as Season
			--,LTRIM(RTRIM(h.CustomField5)) as StyleSubCategory
			,LTRIM(RTRIM(ct.StyleCategory)) as StyleSubCategory
			,1 as subReportNum
			,0 as imageShowFlag
		
		        
		from pStyleChange c WITH (NOLOCK)
		INNER JOIN pStyleTeam  	 t     ON t.StyleID = c.StyleID and t.TradePartner = 1 --(external user, 0 = internal)
		INNER JOIN uTradePartner ut     ON ut.TradePartnerID = t.TeamID 
		INNER JOIN pStyleHeader h ON h.StyleID = c.StyleID 
		LEFT OUTER JOIN pStyleCostingHeader sc ON  sc.StyleID = h.StyleID
		LEFT OUTER JOIN pWorkflow p ON p.WorkflowID = c.WorkflowID
		LEFT OUTER JOIN  pStyleCategory ct ON  ct.StyleCategoryID = h.StyleCategory 
		LEFT JOIN pSizeClass scc ON scc.CustomID = h.SizeClassId
		WHERE	
		        --((c.StyleChangeDate >= @DateFrom) and ( c.StyleChangeDate <= @DateTo) ) -- NOT WORKING FOR THE SAME @DateFrom & @DateTo
		       (   
		              ((c.StyleChangeDate > @DateFrom) OR   (DATEDIFF(day,  c.StyleChangeDate,  @DateFrom) = 0 ) )  
		               AND
		              ((c.StyleChangeDate < @DateTo) OR   (DATEDIFF(day,  c.StyleChangeDate,  @DateTo) = 0 ) )            
		        )
		   AND (
			((LTRIM(RTRIM(h.CustomField2)) = LTRIM(RTRIM(@Season))) OR ( @Season = 'ALL')  )
		       )
		   AND (
			 (LTRIM(RTRIM(h.CustomField4)) =  LTRIM(RTRIM(@Year))) or ( @Year ='ALL')
		        )
		   AND ( 
		         --(LTRIM(RTRIM(h.CustomField5)) = LTRIM(RTRIM(@StyleSubCategory ))) OR (@StyleSubCategory = 'ALL') 
			 (LTRIM(RTRIM( CAST(ct.StyleCategoryID AS nvarchar(40)) )) = LTRIM(RTRIM(@StyleCategoryID ))) OR (@StyleCategoryID = 'ALL')
		       )
		  AND (
			  (CAST(ut.TradePartnerID AS nvarchar(40)) = @TradePartnerID)
		           OR  
		          (@TradePartnerID = 'ALL')   
		       )
		--AND (CAST(h.StyleID AS nvarchar(40)) = '083A9A5B-E2BD-4E9C-9F8D-A39C656D81E9')
		ORDER BY  ut.TradePartnerName, h.StyleNo, h.SizeClass,  c.StyleSet,   c.StyleChangeDate, c.WorkflowID

	END

ELSE

	BEGIN
		INSERT INTO #TempStyleDevelChange (	
				TradePartnerID, 
				TradePartnerName, 
				StyleID, 
				StyleNo, FilePath,
				Descrip, SizeClass, StyleSet,
				--WorkflowID,
				Workflow, 
				StyleChangeBy,StyleChangeDescription, StyleCostingCustomField18,StartShipDate, StyleChangeDate,StyleChangeType,
				StyleYear, Season, StyleSubCategory,
				subReportNum, imageShowFlag)
		SELECT
			ut.TradePartnerID
			,ut.TradePartnerName
			,c.StyleID
			,h.StyleNo
			,(SELECT TOP 1 dbo.fnx_GetStreamingImagePath(hImage.ImageID, hImage.[Version], 2000)	--Comment #02 
					FROM	pStyleHeader LEFT OUTER JOIN hImage ON
						pStyleHeader.DesignSketchID = hImage.ImageID AND
						pStyleHeader.DesignSketchVersion = hImage.Version
					WHERE pStyleHeader.StyleID = h.StyleID
				) AS FilePath
			,h.[Description]
			,COALESCE(scc.Custom, h.SizeClass)
			,c.StyleSet
			--,c.WorkflowID
			,ISNULL(p.Workflow, 'Style Header') AS Workflow
			,c.StyleChangeBy
			,c.StyleChangeDescription
			--,c.StyleChangeNo
			,sc.StyleCostingCustomField18 -- number of units to sort from the biggest order to smallest order
			,(CASE WHEN h.CustomField10 IS NULL THEN NULL
		              WHEN h.CustomField10 = '' THEN NULL
		              ELSE CAST(h.CustomField10 AS datetime) 
		              END  )
					  /*NULL as StartShipDate*/		--Comment #01
			,c.StyleChangeDate
			,c.StyleChangeType
			,LTRIM(RTRIM(h.CustomField4)) as StyleYear
			,LTRIM(RTRIM(h.CustomField2)) as Season
			--,LTRIM(RTRIM(h.CustomField5)) as StyleSubCategory
			,LTRIM(RTRIM(ct.StyleCategory)) as StyleSubCategory
			,1 as subReportNum
			,0 as imageShowFlag
		
		        
		from pStyleChange c WITH (NOLOCK)
		INNER JOIN pStyleTeam  	 t     ON t.StyleID = c.StyleID and t.TradePartner = 1 --(external user, 0 = internal)
		INNER JOIN uTradePartner ut     ON ut.TradePartnerID = t.TeamID 
		INNER JOIN pStyleHeader h ON h.StyleID = c.StyleID 
		LEFT OUTER JOIN pStyleCostingHeader sc ON  sc.StyleID = h.StyleID
		LEFT OUTER JOIN pWorkflow p ON p.WorkflowID = c.WorkflowID
		LEFT OUTER JOIN pStyleCategory ct ON  ct.StyleCategoryID = h.StyleCategory 
		LEFT JOIN pSizeClass scc ON scc.CustomID = h.SizeClassId
		WHERE	
		        --((c.StyleChangeDate >= @DateFrom) and ( c.StyleChangeDate <= @DateTo) ) -- NOT WORKING FOR THE SAME @DateFrom & @DateTo
		       (   
		              ((c.StyleChangeDate > @DateFrom) OR   (DATEDIFF(day,  c.StyleChangeDate,  @DateFrom) = 0 ) )  
		               AND
		              ((c.StyleChangeDate < @DateTo) OR   (DATEDIFF(day,  c.StyleChangeDate,  @DateTo) = 0 ) )            
		        )
		   AND (
			 ((LTRIM(RTRIM(h.CustomField2)) = LTRIM(RTRIM(@Season))) OR ( @Season = 'ALL')  )
		       )
		   AND (
			 (LTRIM(RTRIM(h.CustomField4)) =  LTRIM(RTRIM(@Year))) or ( @Year ='ALL')
		        )
		   AND ( 
		          --(LTRIM(RTRIM(h.CustomField5)) = LTRIM(RTRIM(@StyleSubCategory ))) OR (@StyleSubCategory = 'ALL') 
			  (LTRIM(RTRIM( CAST(ct.StyleCategoryID AS nvarchar(40)) )) = LTRIM(RTRIM(@StyleCategoryID ))) OR (@StyleCategoryID = 'ALL')
		       )
		  AND (
			  (CAST(ut.TradePartnerID AS nvarchar(40)) = @TradePartnerID)
		           OR  
		          (@TradePartnerID = 'ALL')   
		       )
		--AND (CAST(h.StyleID AS nvarchar(40)) = '083A9A5B-E2BD-4E9C-9F8D-A39C656D81E9')
		ORDER BY  h.StyleNo, h.SizeClass,  c.StyleSet,  ut.TradePartnerName,  c.StyleChangeDate, c.WorkflowID
	END




SET @TotalRecordCount = (SELECT COUNT(subReportNum) FROM #TempStyleDevelChange)

IF @SortBy = 1 
	BEGIN
	INSERT INTO #TempRowNum (TradePartnerName, StyleNo, minRowNum) 
	SELECT TradePartnerName, StyleNo, MIN(rowNum) FROM #TempStyleDevelChange
	GROUP BY TradePartnerName, StyleNo,SizeClass, StyleSet ORDER BY  TradePartnerName, StyleNo,SizeClass, StyleSet ASC
	
	
	UPDATE s  set imageShowFlag = 1 FROM #TempRowNum r, #TempStyleDevelChange s
	WHERE r.StyleNo = s.StyleNo and r.minRowNum = s.rowNum


	SELECT rowNum, TradePartnerName, StyleNo,FilePath, Descrip, SizeClass, StyleSet,Workflow, 
		StyleChangeBy,StyleChangeDescription, StyleCostingCustomField18, 
		StartShipDate,StyleChangeDate, StyleChangeType,
		StyleYear, Season, StyleSubCategory,
		subReportNum, imageShowFlag, @TotalRecordCount as TotalRecordCount
	FROM #TempStyleDevelChange ORDER BY TradePartnerName, StyleNo, SizeClass, StyleSet,  StyleChangeDate
	END 

ELSE 
	BEGIN

	INSERT INTO #TempRowNum (TradePartnerName, StyleNo, minRowNum) 
	SELECT NULL, StyleNo, MIN(rowNum) FROM #TempStyleDevelChange
	GROUP BY StyleNo Order By StyleNo
	
	UPDATE s  set imageShowFlag = 1 FROM #TempRowNum r, #TempStyleDevelChange s
	WHERE r.StyleNo = s.StyleNo and r.minRowNum = s.rowNum

	SELECT rowNum, TradePartnerName, StyleNo,FilePath, Descrip, SizeClass, StyleSet,Workflow, 
		StyleChangeBy,StyleChangeDescription,StyleCostingCustomField18	
	       ,StartShipDate, StyleChangeDate,StyleChangeType,
		StyleYear, Season, StyleSubCategory,
		subReportNum, imageShowFlag, @TotalRecordCount as TotalRecordCount
	FROM #TempStyleDevelChange ORDER BY  StyleNo, SizeClass, StyleSet, TradePartnerName, StyleChangeDate
	END



DROP TABLE #TempStyleDevelChange
DROP TABLE #TempRowNum
END


GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10090', GetUTCDate())
GO