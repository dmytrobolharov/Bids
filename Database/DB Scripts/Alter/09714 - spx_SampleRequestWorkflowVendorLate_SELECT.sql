IF OBJECT_ID(N'[dbo].[spx_SampleRequestWorkflowVendorLate_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_SampleRequestWorkflowVendorLate_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestWorkflowVendorLate_SELECT]
(@SampleWorkflowId nvarchar(5),
@TradePartnerID uniqueidentifier = NULL,
@TradePartnerVendorID uniqueidentifier)
AS 

IF @TradepartnerID IS NOT NULL
	BEGIN
		SELECT dbo.pSampleRequestWorkflow.SampleRequestWorkflowID, dbo.pSampleRequestWorkflow.SampleWorkflowID, 
			dbo.pSampleRequestWorkflow.SampleRequestTradeID, dbo.pSampleRequestWorkflow.TradePartnerVendorID, dbo.pSampleRequestWorkflow.StyleID, 
			dbo.pSampleRequestWorkflow.StyleColorID, dbo.pSampleRequestWorkflow.StyleSet, dbo.pSampleRequestWorkflow.Status, 
			dbo.pSampleRequestWorkflow.Submit, dbo.pSampleRequestWorkflow.TechPackID, dbo.pSampleRequestWorkflow.StartDate, 
			dbo.pSampleRequestWorkflow.DueDate, dbo.pSampleRequestWorkflow.EndDate, dbo.pSampleWorkflow.SampleWorkflow, 
			dbo.pSampleWorkflow.SampleWorkflowSort, dbo.pSampleWorkflow.GroupName, dbo.pSampleRequestWorkflow.AssignedTo, dbo.Users.FirstName, 
			dbo.Users.LastName, sh.StyleNo, 
			dbo.pSampleWorkflow.SampleWorkflow + N' (' + CAST(dbo.pSampleRequestWorkflow.Submit AS nvarchar(4)) + ') ' AS LateHeader, 
			'<b>A: </b>' + dbo.uTradePartner.TradePartnerCode + ' / <b>V: </b>' + dbo.uTradePartnerVendor.VendorCode + '<BR>' + sh.StyleNo + ' (' +
			COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS LateDescription
		FROM dbo.pSampleRequestWorkflow WITH (NOLOCK) INNER JOIN
			dbo.pSampleWorkflow WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.SampleWorkflowID = dbo.pSampleWorkflow.SampleWorkflowID INNER JOIN
			dbo.pStyleHeader sh WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.StyleID = sh.StyleID INNER JOIN
			dbo.uTradePartner WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.TradePartnerID = dbo.uTradePartner.TradePartnerID INNER JOIN
			dbo.uTradePartnerVendor WITH (NOLOCK) ON 
			dbo.pSampleRequestWorkflow.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID LEFT OUTER JOIN
			dbo.Users WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.AssignedTo = dbo.Users.UserId
			LEFT JOIN pSizeClass sc ON sc.CustomId = sh.SizeClassId
		WHERE (dbo.pSampleRequestWorkflow.DueDate <= GETDATE()) 
			AND (dbo.pSampleRequestWorkflow.Status NOT IN (2, 3, 4)) 
			AND (dbo.pSampleRequestWorkflow.TradePartnerID = @TradePartnerID) 
			AND (dbo.pSampleRequestWorkflow.TradePartnerVendorID = @TradePartnerVendorID) 
			AND (dbo.pSampleWorkflow.SampleWorkflowID = @SampleWorkflowId)
		ORDER BY dbo.pSampleRequestWorkflow.DueDate, sh.StyleNo
	END
ELSE
	BEGIN
		SELECT dbo.pSampleRequestWorkflow.SampleRequestWorkflowID, dbo.pSampleRequestWorkflow.SampleWorkflowID, 
			dbo.pSampleRequestWorkflow.SampleRequestTradeID, dbo.pSampleRequestWorkflow.TradePartnerVendorID, dbo.pSampleRequestWorkflow.StyleID, 
			dbo.pSampleRequestWorkflow.StyleColorID, dbo.pSampleRequestWorkflow.StyleSet, dbo.pSampleRequestWorkflow.Status, 
			dbo.pSampleRequestWorkflow.Submit, dbo.pSampleRequestWorkflow.TechPackID, dbo.pSampleRequestWorkflow.StartDate, 
			dbo.pSampleRequestWorkflow.DueDate, dbo.pSampleRequestWorkflow.EndDate, dbo.pSampleWorkflow.SampleWorkflow, 
			dbo.pSampleWorkflow.SampleWorkflowSort, dbo.pSampleWorkflow.GroupName, dbo.pSampleRequestWorkflow.AssignedTo, dbo.Users.FirstName, 
			dbo.Users.LastName, sh.StyleNo, 
			dbo.pSampleWorkflow.SampleWorkflow + N' (' + CAST(dbo.pSampleRequestWorkflow.Submit AS nvarchar(4)) + ') ' AS LateHeader, 
			'<b>A: </b>' + dbo.uTradePartner.TradePartnerCode + ' / <b>V: </b>' + dbo.uTradePartnerVendor.VendorCode + '<BR>' + sh.StyleNo + ' (' +
			COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS LateDescription
		FROM dbo.pSampleRequestWorkflow WITH (NOLOCK) INNER JOIN
			dbo.pSampleWorkflow WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.SampleWorkflowID = dbo.pSampleWorkflow.SampleWorkflowID INNER JOIN
			dbo.pStyleHeader sh WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.StyleID = sh.StyleID INNER JOIN
			dbo.uTradePartner WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.TradePartnerID = dbo.uTradePartner.TradePartnerID INNER JOIN
			dbo.uTradePartnerVendor WITH (NOLOCK) ON 
			dbo.pSampleRequestWorkflow.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID LEFT OUTER JOIN
			dbo.Users WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.AssignedTo = dbo.Users.UserId
			LEFT JOIN pSizeClass sc ON sc.CustomId = sh.SizeClassId
		WHERE (dbo.pSampleRequestWorkflow.DueDate <= GETDATE()) 
			AND (dbo.pSampleRequestWorkflow.Status NOT IN (2, 3, 4)) 
			AND (dbo.pSampleRequestWorkflow.TradePartnerVendorID = @TradePartnerVendorID) 
			AND (dbo.pSampleWorkflow.SampleWorkflowID = @SampleWorkflowId)
		ORDER BY dbo.pSampleRequestWorkflow.DueDate, sh.StyleNo
	END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09714', GetDate())
GO
