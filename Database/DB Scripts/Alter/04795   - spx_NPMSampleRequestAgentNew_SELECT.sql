/****** Object:  StoredProcedure [dbo].[spx_NPMSampleRequestAgentNew_SELECT]    Script Date: 01/16/2013 17:41:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NPMSampleRequestAgentNew_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NPMSampleRequestAgentNew_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_NPMSampleRequestAgentNew_SELECT]    Script Date: 01/16/2013 17:41:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



/*
DECLARE @Total int

-- TODO: Set parameter values here.
EXECUTE [dbo].[spx_SampleRequestAgentNew_SELECT] 'B8BFFFED-0291-4252-B9B2-6BDA308D302F', 5, @Total OUTPUT
PRINT @Total
*/
CREATE PROCEDURE [dbo].[spx_NPMSampleRequestAgentNew_SELECT](
    @TradePartnerId uniqueidentifier,
    @Top INT ,
    @Total INT OUTPUT
)
AS
BEGIN
    DECLARE @SQLString NVARCHAR(4000)
    DECLARE @ParmDefinition NVARCHAR(500)
    
    -- Selecting all children of given trade partner
	;WITH partners AS (
		SELECT *, 0 as Level FROM vwx_Sourcing_TradePartner_REL_SEL
		WHERE TradePartnerMasterID IS NULL	
		AND TradePartnerID = @TradePartnerID

		UNION ALL 

		SELECT tp.*, Level + 1 FROM vwx_Sourcing_TradePartner_REL_SEL tp
		INNER JOIN partners p ON p.TradePartnerID = tp.TradePartnerMasterID
		WHERE Level < 3
	) 
	SELECT p.TradePartnerID, tp.TradePartnerName, tp.TradePartnerCode, TradePartnerRelationshipID 
	INTO #tmpChildVendors
	FROM partners p
	LEFT JOIN uTradePartner tp ON tp.TradePartnerID = p.TradePartnerID
	
	SET @SQLString = '
        SELECT @pTotal = COUNT(*) FROM (
            SELECT
                a.SampleRequestTradeID, a.CDate, b.StyleID, b.StyleNo,    
                b.Description, b.SizeClass, c.TradePartnerName as VendorName, a.TradePartnerID,
                c.TradePartnerCode as VendorCode , d.StyleSet,MAX(d.EndDate) AS ''EndDate'', 0 AS BOM
            FROM dbo.pStyleHeader b WITH (NOLOCK)
                INNER JOIN dbo.pSampleRequestTrade a  WITH (NOLOCK) ON b.StyleID = a.StyleID
                INNER JOIN #tmpChildVendors c  WITH (NOLOCK) ON a.TradePartnerID = c.TradePartnerID
                INNER JOIN dbo.pSampleRequestWorkflow d  WITH (NOLOCK) ON d.SampleRequestTradeID = a.SampleRequestTradeID
            WHERE a.SampleRequestShare = 1
            GROUP BY
                a.SampleRequestTradeID, a.CDate, b.StyleID,
                b.StyleNo, b.Description, b.SizeClass, c.TradePartnerName,
                a.TradePartnerID, c.TradePartnerCode, d.StyleSet
            UNION
            SELECT
                a.SampleRequestTradeID, a.CDate, b.StyleID, b.StyleNo,    
                b.Description, b.SizeClass, c.TradePartnerName as VendorName, a.TradePartnerID,
                c.TradePartnerCode as VendorCode, d.StyleSet,MAX(d.EndDate) AS ''EndDate'', 1 AS BOM
            FROM dbo.pStyleHeader b WITH (NOLOCK)
                INNER JOIN dbo.pSampleRequestBOMTrade a  WITH (NOLOCK) ON b.StyleID = a.StyleID
                INNER JOIN #tmpChildVendors c  WITH (NOLOCK) ON a.TradePartnerID = c.TradePartnerID
                INNER JOIN dbo.pSampleRequestWorkflowBOM d  WITH (NOLOCK) ON d.SampleRequestTradeID = a.SampleRequestTradeID
            WHERE a.SampleRequestShare = 1
            GROUP BY
                a.SampleRequestTradeID, a.CDate, b.StyleID,
                b.StyleNo, b.Description, b.SizeClass, c.TradePartnerName,
                a.TradePartnerID, c.TradePartnerCode, d.StyleSet
    )  AS FOO'

    SET @ParmDefinition = '@pTradePartnerId UNIQUEIDENTIFIER, @pTotal INT OUTPUT'
   
    --PRINT @SQLString 
   
    EXECUTE sp_executesql @SQLString, @ParmDefinition,
            @pTradePartnerId = @TradePartnerId,
            @pTotal = @Total OUTPUT
   
    DECLARE @SQLTopString NVARCHAR(300)
    DECLARE @SQLColumnString NVARCHAR(2000)
    DECLARE @SQLColumnMultiBOMString AS VARCHAR(2000) 

    IF (@Top IS NULL) OR ( @Top<=0 )
        SET @SQLTopString = 'SELECT TOP 100 PERCENT '
    ELSE
        SET @SQLTopString = 'SELECT TOP ' +  CAST ( @Top AS NVARCHAR(5) ) 
       
    SET @SQLString = @SQLTopString + ' NT.* FROM ( '
   
    --PRINT @SQLString
   
    SET @SQLColumnString = ' SELECT a.SampleRequestTradeID, a.CDate, b.StyleID,
                            b.StyleNo, b.Description, b.SizeClass,
                            c.TradePartnerName as VendorName, a.TradePartnerID, c.TradePartnerCode as VendorCode, d.StyleSet,MAX(d.EndDate) AS ''EndDate'',''00000000-0000-0000-0000-000000000000'' As WorkflowItemID,''00000000-0000-0000-0000-000000000000'' As StyleBOMDimensionID,''00000000-0000-0000-0000-000000000000'' As StyleBOMDimensionItemID '
                              
	SET @SQLColumnMultiBOMString = ' SELECT a.SampleRequestTradeID, a.CDate, b.StyleID,
                            b.StyleNo, b.Description, b.SizeClass,
                            c.TradePartnerName as VendorName, a.TradePartnerID, c.TradePartnerCode as VendorCode, d.StyleSet,MAX(d.EndDate) AS ''EndDate'',ISNULL(a.WorkflowItemID,''00000000-0000-0000-0000-000000000000''),ISNULL(a.StyleBOMDimensionID,''00000000-0000-0000-0000-000000000000''),ISNULL(a.StyleBOMDimensionItemID,''00000000-0000-0000-0000-000000000000'') '                            
   
    SET @SQLString = @SQLString + @SQLColumnString + ', 0 AS BOM FROM
            dbo.pStyleHeader b  WITH (NOLOCK)
                INNER JOIN dbo.pSampleRequestTrade  a  WITH (NOLOCK) ON b.StyleID = a.StyleID
                INNER JOIN #tmpChildVendors  c  WITH (NOLOCK) ON a.TradePartnerID = c.TradePartnerID
                INNER JOIN dbo.pSampleRequestWorkflow d  WITH (NOLOCK) ON d.SampleRequestTradeID = a.SampleRequestTradeID
        WHERE a.SampleRequestShare = 1
        GROUP BY
            a.SampleRequestTradeID, a.CDate, b.StyleID,
            b.StyleNo, b.Description, b.SizeClass,
            c.TradePartnerName, a.TradePartnerID, c.TradePartnerCode, d.StyleSet'
           
    SET @SQLString = @SQLString + ' UNION ' + @SQLColumnMultiBOMString + ', 1 AS BOM FROM
            dbo.pStyleHeader b  WITH (NOLOCK)
                INNER JOIN dbo.pSampleRequestBOMTrade  a  WITH (NOLOCK) ON b.StyleID = a.StyleID
                INNER JOIN #tmpChildVendors  c  WITH (NOLOCK) ON a.TradePartnerID = c.TradePartnerID
                INNER JOIN dbo.pSampleRequestWorkflowBOM d  WITH (NOLOCK) ON d.SampleRequestTradeID = a.SampleRequestTradeID
        WHERE a.SampleRequestShare = 1
        GROUP BY
            a.SampleRequestTradeID, a.CDate, b.StyleID,
            b.StyleNo, b.Description, b.SizeClass,
            c.TradePartnerName, a.TradePartnerID, c.TradePartnerCode, d.StyleSet,a.WorkFlowItemID,a.StyleBOMDimensionID,a.StyleBOMDimensionItemID '   
            
           
    SET @SQLString = @SQLString + ') AS NT ORDER BY NT.CDate DESC'
            
    SET @SQLString = 'SELECT * FROM (' + @SQLString + ') t ORDER BY VendorCode, CDate DESC, SizeClass, StyleSet'
   

    SET @ParmDefinition = '@pTradePartnerId UNIQUEIDENTIFIER'

    PRINT @SQLString 

    EXECUTE sp_executesql @SQLString, @ParmDefinition,
            @pTradePartnerId = @TradePartnerId
            
    DROP TABLE #tmpChildVendors

END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04795', GetDate())
GO