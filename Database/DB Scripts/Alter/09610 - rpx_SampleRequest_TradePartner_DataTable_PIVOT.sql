IF OBJECT_ID(N'[dbo].[rpx_SampleRequest_TradePartner_DataTable_PIVOT]') IS NOT NULL
 DROP PROCEDURE [dbo].[rpx_SampleRequest_TradePartner_DataTable_PIVOT]
GO

CREATE PROCEDURE [dbo].[rpx_SampleRequest_TradePartner_DataTable_PIVOT]
(
	@TradePartnerID NVARCHAR(50) = NULL,
	@TeamID NVARCHAR(50),
	@Filter NVARCHAR (4000)  
)
AS

	IF  @TradePartnerID IS NULL OR @TradePartnerID=''
	BEGIN
		SET @TradePartnerID =NULL
	END

  
	CREATE TABLE #tmpSample1 
	(  
		SampleRequestTradeID UNIQUEIDENTIFIER,  
		SampleWorkflow NVARCHAR(200),  
		StyleID UNIQUEIDENTIFIER,
		DivisionID UNIQUEIDENTIFIER,  
		SampleRequestSubmitID UNIQUEIDENTIFIER,   
		TradePartnerID UNIQUEIDENTIFIER,   
		TradePartnerVendorID UNIQUEIDENTIFIER, 
		TradePartnerRelationshipLevelID UNIQUEIDENTIFIER, 
		Link  NVARCHAR(4000),   
		AssignedTo INT,   
		StyleColorID UNIQUEIDENTIFIER ,
		ItemDim1ID UNIQUEIDENTIFIER,
		ItemDim2ID UNIQUEIDENTIFIER,
		ItemDim3ID UNIQUEIDENTIFIER,
		isBOM INT,
		TechPack NVARCHAR(4000),  
		StyleSet NVARCHAR(200),  
		SetNo INT,  
		Season NVARCHAR(200),  
		Year NVARCHAR(200),
		SeasonYearID UNIQUEIDENTIFIER,
		alertColor	NVARCHAR(50),
		SampleWorkflowID NVARCHAR(10),
		Comment NVARCHAR(MAX)
		 
	)  
	  
	CREATE TABLE #tmpSample2 
	(  
		SampleRequestTradeID UNIQUEIDENTIFIER,  
		SampleWorkflow NVARCHAR(200),  
		StyleID UNIQUEIDENTIFIER,  
		DivisionID UNIQUEIDENTIFIER,
		SampleRequestSubmitID UNIQUEIDENTIFIER,   
		TradePartnerName NVARCHAR(200),  
		VendorName NVARCHAR(200), 
		PartnerName NVARCHAR(1000),
		TradePartnerID UNIQUEIDENTIFIER,   
		TradePartnerVendorID UNIQUEIDENTIFIER,  
		TradePartnerRelationshipLevelID UNIQUEIDENTIFIER, 
		Link  NVARCHAR(4000),  
		StyleNo NVARCHAR(50) ,   
		CustomField1 NVARCHAR(400),
		DevelopmentNo NVARCHAR(40),
		CustomField5 NVARCHAR(400),
		CustomField6 NVARCHAR(400),
		CustomField7 NVARCHAR(400),
		CustomField9 NVARCHAR(400),
		StyleType INT,
		StyleCategory NVARCHAR(400),
		SizeRange NVARCHAR(200),
		Description NVARCHAR(100),  
		SizeClass NVARCHAR(400),  
		CustomField13 NVARCHAR(400),
		WashType NVARCHAR(100),
		CustomField10 NVARCHAR(400),
		CustomField11 NVARCHAR(400),
		CustomField12 NVARCHAR(400),
		Designer NVARCHAR(200), 
		Colorway NVARCHAR (200),  
		TechPack NVARCHAR(4000) ,  
		StyleSet NVARCHAR(200),  
		SetNo INT,  
		Season NVARCHAR(200),  
		Year NVARCHAR(200),  
		SeasonYearID UNIQUEIDENTIFIER,
		alertColor	NVARCHAR(50),
		SampleWorkflowID NVARCHAR(10),
		Comment NVARCHAR(MAX),
		ItemDim1ID UNIQUEIDENTIFIER,
		ItemDim2ID UNIQUEIDENTIFIER,
		ItemDim3ID UNIQUEIDENTIFIER,
		isBOM INT
	)   

  
	CREATE TABLE #tmpSample3 
	(  
		SampleRequestTradeID UNIQUEIDENTIFIER,  
		SampleWorkflow NVARCHAR(200),  
		StyleID UNIQUEIDENTIFIER,
		DivisionID UNIQUEIDENTIFIER,  
		SampleRequestSubmitID UNIQUEIDENTIFIER,   
		TradePartnerName NVARCHAR(200),  
		VendorName NVARCHAR(200),  
		PartnerName NVARCHAR(1000),  
		TradePartnerID UNIQUEIDENTIFIER,   
		TradePartnerVendorID UNIQUEIDENTIFIER,  
		TradePartnerRelationshipLevelID UNIQUEIDENTIFIER, 
		Link  NVARCHAR(4000),  
		StyleNo NVARCHAR(50), 
		CustomField1 NVARCHAR(400),  
		DevelopmentNo NVARCHAR(40),
		CustomField5 NVARCHAR(400),
		CustomField6 NVARCHAR(400),
		CustomField7 NVARCHAR(400),
		CustomField9 NVARCHAR(400),
		StyleType INT,
		StyleCategory NVARCHAR(400),
		SizeRange NVARCHAR(200),
		Description NVARCHAR(100),  
		SizeClass NVARCHAR(400), 
		CustomField13 NVARCHAR(400),
		WashType NVARCHAR(100),
		CustomField10 NVARCHAR(400),
		CustomField11 NVARCHAR(400),
		CustomField12 NVARCHAR(400),
		Designer NVARCHAR(200),  
		Colorway NVARCHAR (200),  
		TechPack NVARCHAR(4000) ,  
		StyleSet NVARCHAR(200),  
		SetNo INT,  
		Season NVARCHAR(200),  
		Year NVARCHAR(200),  
		SeasonYearID UNIQUEIDENTIFIER,
		alertColor	NVARCHAR(50),
		SampleWorkflowID NVARCHAR(10),
		Comment NVARCHAR(MAX),
		ItemDim1ID UNIQUEIDENTIFIER,
		ItemDim2ID UNIQUEIDENTIFIER,
		ItemDim3ID UNIQUEIDENTIFIER,
		isBOM INT
	)
	
	IF @TradepartnerID IS NOT NULL  
	BEGIN
		INSERT INTO #tmpSample1 
		(   
		SampleRequestTradeID, 
		SampleWorkflow, 
		StyleID, 
		DivisionID,
		SampleRequestSubmitID,  
		TradePartnerID,
		TradePartnerVendorID,
		TradePartnerRelationshipLevelID,
		Link,   
		AssignedTo,
		StyleColorID,
		ItemDim1ID,
		ItemDim2ID,
		ItemDim3ID,
		isBOM,
		TechPack, 
		StyleSet, 
		SetNo, 
		Season, 
		Year,
		SeasonYearID,
		alertColor,
		SampleWorkflowID,
		Comment
		
		)  
		SELECT   
		a.SampleRequestTradeID, 
		f.SampleWorkflow AS SampleWorkflow, 
		a.StyleID, 
		g.DivisionID,
		a.SampleRequestSubmitID,   
		b.TradePartnerID , 
		b.TradePartnerVendorID,
		tprl.TradePartnerRelationshipLevelID,
		CASE   
		WHEN d.ApprovedType = 1  THEN 'Approved'  
		WHEN a.Status = 4  THEN 'Dropped'  
		WHEN a.Submit = 1 THEN 'Open'  
		ELSE 'Re-Submit'  
		END AS Link,   
		a.AssignedTo,
		b.StyleColorID,
		NULL AS ItemDim1ID,
		NULL AS ItemDim2ID,
		NULL AS ItemDim3ID,
		0 AS isBOM,   
		CASE   
		WHEN  b.TechPackID IS NULL  OR b.TechPackID  = '00000000-0000-0000-0000-000000000000' THEN '<div align=center>-------</div>'  
		ELSE
		CAST(g.DueDate  AS nvarchar(500))
		END AS TechPack,
		CASE   
		WHEN a.StyleSet = 1 THEN   
		CASE WHEN g.PC1 Is Not Null THEN g.PC1 ELSE '1st Set' END  
		WHEN a.StyleSet = 2 THEN   
		CASE WHEN g.PC2 Is Not Null THEN g.PC2 ELSE '2nd Set' END  
		WHEN a.StyleSet = 3 THEN   
		CASE WHEN g.PC3 Is Not Null THEN g.PC3 ELSE '3rd Set' END  
		WHEN a.StyleSet = 4 THEN   
		CASE WHEN g.PC4 Is Not Null THEN g.PC4 ELSE '4th Set' END   
		END AS StyleSet, 
		a.StyleSet as SetNo,
		i.Season, 
		i.Year,
		i.SeasonYearID,
		CASE   
		WHEN d.ApprovedType = 1  THEN 'Green'  
		WHEN a.Status = 4  THEN 'Red'  
		WHEN a.Submit = 1 THEN 'Blue'  
		ELSE 'Yellow'  
		END AS 'Alert Color',
		c.SampleWorkflowID,
		REPLACE(CONVERT(NVARCHAR(MAX),a.Comment), 'span', 'u')
		FROM dbo.pSampleRequestSubmit a  
		INNER JOIN pSampleRequestTrade b ON a.SampleRequestTradeID  = b.SampleRequestTradeID    
		INNER JOIN pSampleWorkflow c ON a.SampleWorkflowId = c.SampleWorkflowID AND c.Active='Yes'  
		INNER JOIN pSampleRequestSubmitStatus d ON a.Status   = d.StatusID   
		INNER JOIN pSampleRequestWorkflow e ON e.SampleRequestWorkflowID = a.SampleRequestWorkflowID  
		AND e.Submit = a.Submit
		INNER JOIN pSampleWorkflow f ON f.SampleWorkflowID  =  e.SampleWorkflowID   
		INNER JOIN pStyleHeader g ON b.StyleID = g.StyleID  
		LEFT OUTER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON b.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
		LEFT OUTER JOIN pStyleSeasonYear h ON h.StyleSeasonYearID =  b.StyleSeasonyearID   
		LEFT OUTER JOIN pSeasonYear i ON i.SeasonYearID =  h.SeasonYearID  
		INNER JOIN pSampleWorkflowViewSubmit j ON c.SampleWorkflowID=j.SampleWorkflowId    
		WHERE (CONVERT (NVARCHAR(50),b.TradePartnerID) = @TradePartnerID OR @TradePartnerID IN (tprl.AgentID, tprl.VendorID, tprl.FactoryID))
		AND
		(
			C.SampleWorkflowID IN
			(
				SELECT SampleWorkflowId
				FROM pSampleWorkflowViewSubmit WITH (NOLOCK)
				WHERE TeamId = @TeamID
			)
		)
		UNION SELECT   
		a.SampleRequestTradeID, 
		f.SampleWorkflow AS SampleWorkflow, 
		a.StyleID, 
		g.DivisionID,
		a.SampleRequestSubmitID,   
		b.TradePartnerID , 
		b.TradePartnerVendorID,
		tprl.TradePartnerRelationshipLevelID,
		CASE   
		WHEN d.ApprovedType = 1  THEN 'Approved'  
		WHEN a.Status = 4  THEN 'Dropped'  
		WHEN a.Submit = 1 THEN 'Open'  
		ELSE 'Re-Submit'  
		END AS Link,   
		a.AssignedTo,
		NULL as StyleColorID,
		b.ItemDim1ID,
		b.ItemDim2ID,
		b.ItemDim3ID,
		1 AS isBOM,
		CASE   
		WHEN  b.TechPackID IS NULL  OR b.TechPackID  = '00000000-0000-0000-0000-000000000000' THEN '<div align=center>-------</div>'  
		ELSE
		CAST(g.DueDate  AS nvarchar(500))
		END AS TechPack,
		CASE   
		WHEN a.StyleSet = 1 THEN   
		CASE WHEN g.PC1 Is Not Null THEN g.PC1 ELSE '1st Set' END  
		WHEN a.StyleSet = 2 THEN   
		CASE WHEN g.PC2 Is Not Null THEN g.PC2 ELSE '2nd Set' END  
		WHEN a.StyleSet = 3 THEN   
		CASE WHEN g.PC3 Is Not Null THEN g.PC3 ELSE '3rd Set' END  
		WHEN a.StyleSet = 4 THEN   
		CASE WHEN g.PC4 Is Not Null THEN g.PC4 ELSE '4th Set' END   
		END AS StyleSet, 
		a.StyleSet as SetNo,
		i.Season, 
		i.Year,
		i.SeasonYearID,
		CASE   
		WHEN d.ApprovedType = 1  THEN 'Green'  
		WHEN a.Status = 4  THEN 'Red'  
		WHEN a.Submit = 1 THEN 'Blue'  
		ELSE 'Yellow'  
		END AS 'Alert Color',
		c.SampleWorkflowID,
		REPLACE(CONVERT(NVARCHAR(MAX),a.Comment), 'span', 'u')
		FROM dbo.pSampleRequestSubmitBOM a  
		INNER JOIN pSampleRequestBOMTrade b ON a.SampleRequestTradeID  = b.SampleRequestTradeID    
		INNER JOIN pSampleWorkflow c ON a.SampleWorkflowId = c.SampleWorkflowID AND c.Active='Yes'  
		INNER JOIN pSampleRequestSubmitStatus d ON a.Status   = d.StatusID   
		INNER JOIN pSampleRequestWorkflowBOM e ON e.SampleRequestWorkflowID = a.SampleRequestWorkflowID  
		AND e.Submit = a.Submit
		INNER JOIN pSampleWorkflow f ON f.SampleWorkflowID  =  e.SampleWorkflowID   
		INNER JOIN pStyleHeader g ON g.StyleID = b.StyleID  
		LEFT OUTER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON b.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
		LEFT OUTER JOIN pStyleSeasonYear h ON h.StyleSeasonYearID =  b.StyleSeasonyearID   
		LEFT OUTER JOIN pSeasonYear i ON i.SeasonYearID =  h.SeasonYearID  
		INNER JOIN pSampleWorkflowViewSubmit j ON c.SampleWorkflowID=j.SampleWorkflowId    
		WHERE (CONVERT (NVARCHAR(50),b.TradePartnerID) = @TradePartnerID OR @TradePartnerID IN (tprl.AgentID, tprl.VendorID, tprl.FactoryID))
		AND
		(
			C.SampleWorkflowID IN
			(
				SELECT SampleWorkflowId
				FROM pSampleWorkflowViewSubmit WITH (NOLOCK)
				WHERE TeamId = @TeamID
			)
		)
	END  
	ELSE   
	BEGIN
		INSERT INTO #tmpSample1 
		(   
		SampleRequestTradeID,
		SampleWorkflow,
		StyleID,
		DivisionID,
		SampleRequestSubmitID,  
		TradePartnerID,
		TradePartnerVendorID,
		TradePartnerRelationshipLevelID,
		Link,   
		AssignedTo,
		StyleColorID,
		ItemDim1ID,
		ItemDim2ID,
		ItemDim3ID,
		isBOM,
		TechPack,
		StyleSet,
		SetNo,
		Season,
		Year,
		SeasonYearID,
		alertColor,
		SampleWorkflowID,
		Comment
		)  
		SELECT   
		a.SampleRequestTradeID,
		f.SampleWorkflow AS SampleWorkflow,
		a.StyleID,
		g.DivisionID,
		a.SampleRequestSubmitID,   
		b.TradePartnerID,
		b.TradePartnerVendorID,
		tprl.TradePartnerRelationshipLevelID,
		CASE   
		WHEN d.ApprovedType = 1  THEN 'Approved'  
		WHEN a.Status = 4  THEN 'Dropped'  
		WHEN a.Submit = 1 THEN 'Open'  
		ELSE 'Re-Submit'  
		END AS Link,   
		a.AssignedTo,
		b.StyleColorID,
		NULL AS ItemDim1ID,
		NULL AS ItemDim2ID,
		NULL AS ItemDim3ID,
		0 AS isBOM,
		CASE   
		WHEN  b.TechPackID IS NULL  OR b.TechPackID  = '00000000-0000-0000-0000-000000000000' THEN '<div align=center>-------</div>'  
		ELSE   
		CAST(g.DueDate  AS nvarchar(500))
		END 
		AS TechPack ,  
		CASE   
		WHEN a.StyleSet = 1 THEN   
		CASE WHEN g.PC1 Is Not Null THEN g.PC1 ELSE '1st Set' END  
		WHEN a.StyleSet = 2 THEN   
		CASE WHEN g.PC2 Is Not Null THEN g.PC2 ELSE '2nd Set' END  
		WHEN a.StyleSet = 3 THEN   
		CASE WHEN g.PC3 Is Not Null THEN g.PC3 ELSE '3rd Set' END  
		WHEN a.StyleSet = 4 THEN   
		CASE WHEN g.PC4 Is Not Null THEN g.PC4 ELSE '4th Set' END   
		END AS StyleSet, a.StyleSet as SetNo, i.Season, i.Year,i.SeasonYearID,
		CASE   
		WHEN d.ApprovedType = 1  THEN 'Green'  
		WHEN a.Status = 4  THEN 'Red'  
		WHEN a.Submit = 1 THEN 'Blue'  
		ELSE 'Yellow'  
		END AS 'Alert Color',
		c.SampleWorkflowID,
		REPLACE(CONVERT(NVARCHAR(MAX),a.Comment), 'span', 'u')
		FROM dbo.pSampleRequestSubmit a  
		INNER JOIN pSampleRequestTrade b ON a.SampleRequestTradeID  = b.SampleRequestTradeID    
		INNER JOIN pSampleWorkflow c ON a.SampleWorkflowId = c.SampleWorkflowID AND c.Active='Yes'  
		INNER JOIN pSampleRequestSubmitStatus d ON a.Status   = d.StatusID   
		INNER JOIN pSampleRequestWorkflow e ON e.SampleRequestWorkflowID = a.SampleRequestWorkflowID AND e.Submit = a.Submit  --Comment #01  
		INNER JOIN pSampleWorkflow f ON f.SampleWorkflowID  =  e.SampleWorkflowID   
		INNER JOIN pStyleHeader g ON g.StyleID = b.StyleID  
		LEFT OUTER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON b.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
		LEFT OUTER JOIN pStyleSeasonYear h ON h.StyleSeasonYearID =  b.StyleSeasonyearID   
		LEFT OUTER JOIN pSeasonYear i ON i.SeasonYearID =  h.SeasonYearID  
		INNER JOIN pSampleWorkflowViewSubmit j ON c.SampleWorkflowID=j.SampleWorkflowId
		WHERE
		(
			C.SampleWorkflowID IN
			(
				SELECT SampleWorkflowId
				FROM pSampleWorkflowViewSubmit WITH (NOLOCK)
				WHERE TeamId = @TeamID
			)
		)
		UNION SELECT   
		a.SampleRequestTradeID,
		f.SampleWorkflow AS SampleWorkflow,
		a.StyleID,
		g.DivisionID,
		a.SampleRequestSubmitID,   
		b.TradePartnerID,
		b.TradePartnerVendorID,
		tprl.TradePartnerRelationshipLevelID,
		CASE   
		WHEN d.ApprovedType = 1  THEN 'Approved'  
		WHEN a.Status = 4  THEN 'Dropped'  
		WHEN a.Submit = 1 THEN 'Open'  
		ELSE 'Re-Submit'  
		END AS Link,   
		a.AssignedTo,
		NULL AS StyleColorID,
		b.ItemDim1ID,
		b.ItemDim2ID,
		b.ItemDim3ID,
		1 AS isBOM,
		CASE   
		WHEN  b.TechPackID IS NULL  OR b.TechPackID  = '00000000-0000-0000-0000-000000000000' THEN '<div align=center>-------</div>'  
		ELSE   
		CAST(g.DueDate  AS nvarchar(500))
		END 
		AS TechPack ,  
		CASE   
		WHEN a.StyleSet = 1 THEN   
		CASE WHEN g.PC1 Is Not Null THEN g.PC1 ELSE '1st Set' END  
		WHEN a.StyleSet = 2 THEN   
		CASE WHEN g.PC2 Is Not Null THEN g.PC2 ELSE '2nd Set' END  
		WHEN a.StyleSet = 3 THEN   
		CASE WHEN g.PC3 Is Not Null THEN g.PC3 ELSE '3rd Set' END  
		WHEN a.StyleSet = 4 THEN   
		CASE WHEN g.PC4 Is Not Null THEN g.PC4 ELSE '4th Set' END   
		END AS StyleSet, a.StyleSet as SetNo, i.Season, i.Year,i.SeasonYearID,
		CASE   
		WHEN d.ApprovedType = 1  THEN 'Green'  
		WHEN a.Status = 4  THEN 'Red'  
		WHEN a.Submit = 1 THEN 'Blue'  
		ELSE 'Yellow'  
		END AS 'Alert Color',
		c.SampleWorkflowID,
		REPLACE(CONVERT(NVARCHAR(MAX),a.Comment), 'span', 'u')
		FROM dbo.pSampleRequestSubmitBOM a  
		INNER JOIN pSampleRequestBOMTrade b ON a.SampleRequestTradeID  = b.SampleRequestTradeID    
		INNER JOIN pSampleWorkflow c ON a.SampleWorkflowId = c.SampleWorkflowID AND c.Active='Yes'  
		INNER JOIN pSampleRequestSubmitStatus d ON a.Status   = d.StatusID   
		INNER JOIN pSampleRequestWorkflowBOM e ON e.SampleRequestWorkflowID = a.SampleRequestWorkflowID AND e.Submit = a.Submit  --Comment #01  
		INNER JOIN pSampleWorkflow f ON f.SampleWorkflowID  =  e.SampleWorkflowID   
		INNER JOIN pStyleHeader g ON g.StyleID = b.StyleID  
		LEFT OUTER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON b.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
		LEFT OUTER JOIN pStyleSeasonYear h ON h.StyleSeasonYearID =  b.StyleSeasonyearID   
		LEFT OUTER JOIN pSeasonYear i ON i.SeasonYearID =  h.SeasonYearID  
		INNER JOIN pSampleWorkflowViewSubmit j ON c.SampleWorkflowID=j.SampleWorkflowId
		WHERE
		(
			C.SampleWorkflowID IN
			(
				SELECT SampleWorkflowId
				FROM pSampleWorkflowViewSubmit WITH (NOLOCK)
				WHERE TeamId = @TeamID
			)
		)
	END

	DECLARE @SQL_01 NVARCHAR(4000)
  
	DECLARE @flag INT    
	SET @flag = 0  
  
	SET @SQL_01 = 'INSERT INTO #tmpSample2 
	(
		SampleRequestTradeID,
		SampleWorkflow,
		StyleID,
		DivisionID,
		SampleRequestSubmitID,  
		TradePartnerID,
		TradePartnerVendorID,
		TradePartnerRelationshipLevelID, 
		TradePartnerName,
		VendorName,  
		PartnerName, 
		Link,
		StyleNo,
		CustomField1,
		DevelopmentNo,
		CustomField5,
		CustomField6,
		CustomField7,
		CustomField9,
		StyleType,
		StyleCategory,
		SizeRange,
		CustomField13,
		WashType,
		CustomField10,
		CustomField11,
		CustomField12,
		Designer,
		Description,
		SizeClass,
		Colorway,
		TechPack,
		StyleSet,
		SetNo,
		Season,
		Year,
		SeasonYearID,
		alertcolor,
		SampleWorkflowID,
		Comment,
		ItemDim1ID,
		ItemDim2ID,
		ItemDim3ID,
		isBOM
	)  
		SELECT 
		a.SampleRequestTradeID, 		
		a.SampleWorkflow AS SampleWorkflow,
		a.StyleID,
		d.DivisionID,
		a.SampleRequestSubmitID,   
		a.TradePartnerID,
		ISNULL(a.TradePartnerVendorID,''00000000-0000-0000-0000-000000000000'') as TradePartnerVendorID,
		a.TradePartnerRelationshipLevelID,
		b.TradePartnerName,
		c.VendorName, 
		SUBSTRING(ISNULL(''/'' + tprl.AgentName, '''') + ISNULL(''/'' + tprl.VendorName,'''') + ISNULL (''/'' + tprl.FactoryName, ''''), 2,1000) AS PartnerName, 
		a.Link,
		d.StyleNo,
		d.CustomField1,
		d.DevelopmentNo,
		d.CustomField5,
		CustomField6,
		CustomField7,
		CustomField9,
		d.StyleType,
		d.StyleCategory,
		COALESCE(sr.SizeRangeCode, d.SizeRange),
		d.CustomField13,
		d.WashType,
		d.CustomField10,
		d.CustomField11,
		d.CustomField12,
		d.Designer,
		d.Description,
		COALESCE(sc.Custom, d.SizeClass),
		g.StyleColorName,
		a.TechPack,
		a.StyleSet,
		a.SetNo,
		a.Season,
		a.Year,
		a.SeasonYearID,
		a.alertcolor,
		a.SampleWorkflowID,
		REPLACE(a.Comment, ''span'', ''u'') AS Comment,
		a.ItemDim1ID,
		a.ItemDim2ID,
		a.ItemDim3ID,
		a.isBOM
		FROM #tmpSample1 a  
		INNER JOIN uTradePartner b ON b.TradePartnerID = a.TradePartnerID  
		LEFT JOIN uTradePartnerVendor c ON c.TradePartnerVendorID = a.TradePartnerVendorID    
		INNER JOIN pStyleHeader d ON d.StyleID = a.StyleID   
		LEFT OUTER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON a.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
		LEFT OUTER JOIN pStyleColorway g ON g.StyleColorID = a.StyleColorID
		LEFT JOIN pSizeClass sc ON sc.CustomID = d.SizeClassId
		LEFT JOIN pSizeRange sr ON sr.CustomId = d.SizeRangeId'  
  
		EXEC (@SQL_01)    
		


		IF @Filter IS NOT NULL AND LEN(@Filter) > 0   
		SET @SQL_01 = 'INSERT INTO #tmpSample3 SELECT * FROM #tmpSample2 WHERE ' + @Filter   
		ELSE   
		SET @SQL_01 = 'INSERT INTO #tmpSample3 SELECT * FROM #tmpSample2 '
		
		EXEC (@SQL_01)
		
		SELECT * FROM #tmpSample3  
			LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON #tmpSample3.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
		WHERE 
		(
			(CAST(#tmpSample3.TradePartnerID  AS NVARCHAR(50)) = @TradePartnerID)
			OR
			@TradePartnerID IN (tprl.AgentID, tprl.VendorID, tprl.FactoryID)
			OR  
			(@TradePartnerID IS NULL)  
		)
		 
		DROP TABLE #tmpSample1  
		DROP TABLE #tmpSample2  
		DROP TABLE #tmpSample3



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09610', GetDate())
GO
