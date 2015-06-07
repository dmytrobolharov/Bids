IF OBJECT_ID(N'[dbo].[spx_SampleRequestAgentNew_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_SampleRequestAgentNew_SELECT]
GO

/*
DECLARE @Total int

-- TODO: Set parameter values here.
EXECUTE [dbo].[spx_SampleRequestAgentNew_SELECT] 'B8BFFFED-0291-4252-B9B2-6BDA308D302F', 5, @Total OUTPUT
PRINT @Total
*/
CREATE PROCEDURE [dbo].[spx_SampleRequestAgentNew_SELECT](
    @TradePartnerId uniqueidentifier,
    @Top INT ,
    @Total INT OUTPUT
)
AS
BEGIN
    DECLARE @SQLString NVARCHAR(MAX)
    DECLARE @ParmDefinition NVARCHAR(500)

    SET @SQLString = '
        SELECT @pTotal = COUNT(*) FROM (
            SELECT
                a.SampleRequestTradeID, a.CDate, b.StyleID, b.StyleNo,    
                b.Description, COALESCE(sc.Custom, b.SizeClass) AS SizeClass, c.VendorName, a.TradePartnerID,
                c.VendorCode , d.StyleSet,MAX(d.EndDate) AS ''EndDate'', 0 AS BOM
            FROM dbo.pStyleHeader b WITH (NOLOCK)
                INNER JOIN dbo.pSampleRequestTrade a  WITH (NOLOCK) ON b.StyleID = a.StyleID
                INNER JOIN dbo.uTradePartnerVendor c  WITH (NOLOCK) ON a.TradePartnerVendorID = c.TradePartnerVendorID
                INNER JOIN dbo.pSampleRequestWorkflow d  WITH (NOLOCK) ON d.SampleRequestTradeID = a.SampleRequestTradeID
				LEFT JOIN pSizeClass sc ON sc.CustomId = b.SizeClassId
            WHERE
                a.TradePartnerID = @pTradePartnerId
                 
                AND a.SampleRequestShare = 1
            GROUP BY
                a.SampleRequestTradeID, a.CDate, b.StyleID,
                b.StyleNo, b.Description, COALESCE(sc.Custom, b.SizeClass), c.VendorName,
                a.TradePartnerID, c.VendorCode, d.StyleSet
            UNION
            SELECT
                a.SampleRequestTradeID, a.CDate, b.StyleID, b.StyleNo,    
                b.Description, COALESCE(sc.Custom, b.SizeClass) AS SizeClass, c.VendorName, a.TradePartnerID,
                c.VendorCode, d.StyleSet,MAX(d.EndDate) AS ''EndDate'', 1 AS BOM
            FROM dbo.pStyleHeader b WITH (NOLOCK)
                INNER JOIN dbo.pSampleRequestBOMTrade a  WITH (NOLOCK) ON b.StyleID = a.StyleID
                INNER JOIN dbo.uTradePartnerVendor c  WITH (NOLOCK) ON a.TradePartnerVendorID = c.TradePartnerVendorID
                INNER JOIN dbo.pSampleRequestWorkflowBOM d  WITH (NOLOCK) ON d.SampleRequestTradeID = a.SampleRequestTradeID
				LEFT JOIN pSizeClass sc ON sc.CustomId = b.SizeClassId
            WHERE
                a.TradePartnerID = @pTradePartnerId
               
                AND a.SampleRequestShare = 1
            GROUP BY
                a.SampleRequestTradeID, a.CDate, b.StyleID,
                b.StyleNo, b.Description, COALESCE(sc.Custom, b.SizeClass), c.VendorName,
                a.TradePartnerID, c.VendorCode, d.StyleSet
    )  AS FOO'

    SET @ParmDefinition = '@pTradePartnerId UNIQUEIDENTIFIER, @pTotal INT OUTPUT'
   
    --PRINT @SQLString 
   
    EXECUTE sp_executesql @SQLString, @ParmDefinition,
            @pTradePartnerId = @TradePartnerId,
            @pTotal = @Total OUTPUT
   
    DECLARE @SQLTopString NVARCHAR(300)
    DECLARE @SQLColumnString NVARCHAR(2000)
    DECLARE @SQLColumnMultiBOMString AS nVARCHAR(2000) 

    IF (@Top IS NULL) OR ( @Top<=0 )
        SET @SQLTopString = 'SELECT '
    ELSE
        SET @SQLTopString = 'SELECT TOP ' +  CAST ( @Top AS NVARCHAR(5) ) 
       
    SET @SQLString = @SQLTopString + ' NT.* FROM ( '
   
    --PRINT @SQLString
   
    SET @SQLColumnString = ' SELECT a.SampleRequestTradeID, a.CDate, b.StyleID,
                            b.StyleNo, b.Description, COALESCE(sc.Custom, b.SizeClass) AS SizeClass,
                            c.VendorName, a.TradePartnerID, c.VendorCode, d.StyleSet,MAX(d.EndDate) AS ''EndDate'',''00000000-0000-0000-0000-000000000000'' As WorkflowItemID,''00000000-0000-0000-0000-000000000000'' As StyleBOMDimensionID,''00000000-0000-0000-0000-000000000000'' As StyleBOMDimensionItemID '
                              
	SET @SQLColumnMultiBOMString = ' SELECT a.SampleRequestTradeID, a.CDate, b.StyleID,
                            b.StyleNo, b.Description, COALESCE(sc.Custom, b.SizeClass) AS SizeClass,
                            c.VendorName, a.TradePartnerID, c.VendorCode, d.StyleSet,MAX(d.EndDate) AS ''EndDate'',ISNULL(a.WorkflowItemID,''00000000-0000-0000-0000-000000000000''),ISNULL(a.StyleBOMDimensionID,''00000000-0000-0000-0000-000000000000''),ISNULL(a.StyleBOMDimensionItemID,''00000000-0000-0000-0000-000000000000'') '                            
   
    SET @SQLString = @SQLString + @SQLColumnString + ', 0 AS BOM FROM
            dbo.pStyleHeader b  WITH (NOLOCK)
                INNER JOIN dbo.pSampleRequestTrade  a  WITH (NOLOCK) ON b.StyleID = a.StyleID
                INNER JOIN dbo.uTradePartnerVendor  c  WITH (NOLOCK) ON a.TradePartnerVendorID = c.TradePartnerVendorID
                INNER JOIN dbo.pSampleRequestWorkflow d  WITH (NOLOCK) ON d.SampleRequestTradeID = a.SampleRequestTradeID
				LEFT JOIN pSizeClass sc ON sc.CustomId = b.SizeClassId
        WHERE
            a.TradePartnerID = @pTradePartnerId
           
            AND a.SampleRequestShare = 1
        GROUP BY
            a.SampleRequestTradeID, a.CDate, b.StyleID,
            b.StyleNo, b.Description, COALESCE(sc.Custom, b.SizeClass),
            c.VendorName, a.TradePartnerID, c.VendorCode, d.StyleSet'
           
    SET @SQLString = @SQLString + ' UNION ' + @SQLColumnMultiBOMString + ', 1 AS BOM FROM
            dbo.pStyleHeader b  WITH (NOLOCK)
                INNER JOIN dbo.pSampleRequestBOMTrade  a  WITH (NOLOCK) ON b.StyleID = a.StyleID
                INNER JOIN dbo.uTradePartnerVendor  c  WITH (NOLOCK) ON a.TradePartnerVendorID = c.TradePartnerVendorID
                INNER JOIN dbo.pSampleRequestWorkflowBOM d  WITH (NOLOCK) ON d.SampleRequestTradeID = a.SampleRequestTradeID
				LEFT JOIN pSizeClass sc ON sc.CustomId = b.SizeClassId
        WHERE
            a.TradePartnerID = @pTradePartnerId
           
            AND a.SampleRequestShare = 1
        GROUP BY
            a.SampleRequestTradeID, a.CDate, b.StyleID,
            b.StyleNo, b.Description, COALESCE(sc.Custom, b.SizeClass),
            c.VendorName, a.TradePartnerID, c.VendorCode, d.StyleSet,a.WorkFlowItemID,a.StyleBOMDimensionID,a.StyleBOMDimensionItemID '   
            
           
    SET @SQLString = @SQLString + ') AS NT    ORDER BY
            NT.VendorCode, NT.CDate DESC, NT.SizeClass, NT.StyleSet'
   

    SET @ParmDefinition = '@pTradePartnerId UNIQUEIDENTIFIER'

    --PRINT @SQLString 

    EXECUTE sp_executesql @SQLString, @ParmDefinition,
            @pTradePartnerId = @TradePartnerId

END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09686', GetDate())
GO
