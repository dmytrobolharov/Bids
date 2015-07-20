
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 23 Dec 2011                                                                               */
-- * WorkItem #5307                                                                             */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestAgentNew_SELECT]    Script Date: 12/23/2011 00:03:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestAgentNew_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestAgentNew_SELECT]
GO


/****** Object:  StoredProcedure [dbo].[spx_SampleRequestAgentNew_SELECT]    Script Date: 12/23/2011 00:03:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
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
	DECLARE @SQLString NVARCHAR(4000)
	DECLARE @ParmDefinition NVARCHAR(500) 

	SET @SQLString = '
		SELECT @pTotal = COUNT(*) FROM ( 
			SELECT 
				a.SampleRequestTradeID, a.CDate, b.StyleID, b.StyleNo,     
				b.Description, b.SizeClass, c.VendorName, a.TradePartnerID, 
				c.VendorCode , d.StyleSet, 0 AS BOM
			FROM dbo.pStyleHeader b WITH (NOLOCK) 
				INNER JOIN dbo.pSampleRequestTrade a  WITH (NOLOCK) ON b.StyleID = a.StyleID 
				INNER JOIN dbo.uTradePartnerVendor c  WITH (NOLOCK) ON a.TradePartnerVendorID = c.TradePartnerVendorID 
				INNER JOIN dbo.pSampleRequestWorkflow d  WITH (NOLOCK) ON d.SampleRequestTradeID = a.SampleRequestTradeID
			WHERE 
				a.TradePartnerID = @pTradePartnerId 
				 
				AND a.SampleRequestShare = 1
			GROUP BY 
				a.SampleRequestTradeID, a.CDate, b.StyleID, 
				b.StyleNo, b.Description, b.SizeClass, c.VendorName, 
				a.TradePartnerID, c.VendorCode, d.StyleSet
			UNION
			SELECT 
				a.SampleRequestTradeID, a.CDate, b.StyleID, b.StyleNo,     
				b.Description, b.SizeClass, c.VendorName, a.TradePartnerID, 
				c.VendorCode, d.StyleSet, 0 AS BOM
			FROM dbo.pStyleHeader b WITH (NOLOCK) 
				INNER JOIN dbo.pSampleRequestBOMTrade a  WITH (NOLOCK) ON b.StyleID = a.StyleID 
				INNER JOIN dbo.uTradePartnerVendor c  WITH (NOLOCK) ON a.TradePartnerVendorID = c.TradePartnerVendorID 
				INNER JOIN dbo.pSampleRequestWorkflowBOM d  WITH (NOLOCK) ON d.SampleRequestTradeID = a.SampleRequestTradeID
			WHERE 
				a.TradePartnerID = @pTradePartnerId 
				
				AND a.SampleRequestShare = 1
			GROUP BY 
				a.SampleRequestTradeID, a.CDate, b.StyleID, 
				b.StyleNo, b.Description, b.SizeClass, c.VendorName, 
				a.TradePartnerID, c.VendorCode, d.StyleSet
	)  AS FOO
	'

	SET @ParmDefinition = '@pTradePartnerId UNIQUEIDENTIFIER, @pTotal INT OUTPUT'
	
	PRINT @SQLString  
	
	EXECUTE sp_executesql @SQLString, @ParmDefinition, 
			@pTradePartnerId = @TradePartnerId, 
			@pTotal = @Total OUTPUT
	
	DECLARE @SQLTopString NVARCHAR(300)
	DECLARE @SQLColumnString NVARCHAR(300)

	IF (@Top IS NULL) OR ( @Top<=0 )
		SET @SQLTopString = 'SELECT ' 
	ELSE 
		SET @SQLTopString = 'SELECT TOP ' +  CAST ( @Top AS NVARCHAR(5) )  
		
	SET @SQLString = @SQLTopString + ' NT.* FROM ( '
	
	--PRINT @SQLString
	
	SET @SQLColumnString = ' SELECT a.SampleRequestTradeID, a.CDate, b.StyleID, 
							b.StyleNo, b.Description, b.SizeClass, 
							c.VendorName, a.TradePartnerID, c.VendorCode, d.StyleSet'
	
	SET @SQLString = @SQLString + @SQLColumnString + ', 0 AS BOM FROM 
			dbo.pStyleHeader b  WITH (NOLOCK) 
				INNER JOIN dbo.pSampleRequestTrade  a  WITH (NOLOCK) ON b.StyleID = a.StyleID 
				INNER JOIN dbo.uTradePartnerVendor  c  WITH (NOLOCK) ON a.TradePartnerVendorID = c.TradePartnerVendorID 
				INNER JOIN dbo.pSampleRequestWorkflow d  WITH (NOLOCK) ON d.SampleRequestTradeID = a.SampleRequestTradeID
		WHERE 
			a.TradePartnerID = @pTradePartnerId 
			
			AND a.SampleRequestShare = 1
		GROUP BY 
			a.SampleRequestTradeID, a.CDate, b.StyleID, 
			b.StyleNo, b.Description, b.SizeClass, 
			c.VendorName, a.TradePartnerID, c.VendorCode, d.StyleSet'
			
	SET @SQLString = @SQLString + ' UNION ' + @SQLColumnString + ', 1 AS BOM FROM 
			dbo.pStyleHeader b  WITH (NOLOCK) 
				INNER JOIN dbo.pSampleRequestBOMTrade  a  WITH (NOLOCK) ON b.StyleID = a.StyleID 
				INNER JOIN dbo.uTradePartnerVendor  c  WITH (NOLOCK) ON a.TradePartnerVendorID = c.TradePartnerVendorID 
				INNER JOIN dbo.pSampleRequestWorkflowBOM d  WITH (NOLOCK) ON d.SampleRequestTradeID = a.SampleRequestTradeID
		WHERE 
			a.TradePartnerID = @pTradePartnerId 
			
			AND a.SampleRequestShare = 1
		GROUP BY 
			a.SampleRequestTradeID, a.CDate, b.StyleID, 
			b.StyleNo, b.Description, b.SizeClass, 
			c.VendorName, a.TradePartnerID, c.VendorCode, d.StyleSet'
			
	SET @SQLString = @SQLString + ') AS NT	ORDER BY 
			NT.VendorCode, NT.CDate DESC, NT.SizeClass, NT.StyleSet'
	

	SET @ParmDefinition = '@pTradePartnerId UNIQUEIDENTIFIER'

	PRINT @SQLString  

	EXECUTE sp_executesql @SQLString, @ParmDefinition, 
			@pTradePartnerId = @TradePartnerId

END



GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02503'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02503', GetDate())
END

GO

