/****** Object:  StoredProcedure [dbo].[spx_StyleQuoteWorkflow_Info_SELECT]    Script Date: 08/06/2014 19:02:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleQuoteWorkflow_Info_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleQuoteWorkflow_Info_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleQuoteWorkflow_Info_SELECT]    Script Date: 08/06/2014 19:02:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleQuoteWorkflow_Info_SELECT]
	@StyleQuoteItemID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
   SELECT sqi.StyleQuoteItemID, sh.SourcingHeaderID, sh.SourcingType, 
   sqi.WorkStart, sqi.WorkDue, sqi.ActualStart, sqi.ActualEnd, sqi.WorkAssignedTo,
   sqi.StyleQuoteItemStatusId AS WorkStatus, stat.Custom AS WorkStatusName,
   '~/System/Icons/' + ISNULL(stat.CustomIcon, 'icon_ball_gray.gif') AS StatusIconURL,
   'Sourcing_StylePage_QuotationEdit.aspx' AS WorkflowPageURL,
   ug.UserID, ug.FullName
   FROM pStyleQuoteItem sqi
   INNER JOIN pStyleQuoteItemStatus stat ON stat.CustomKey = sqi.StyleQuoteItemStatusId
   INNER JOIN pSourcingHeader sh ON sh.SourcingHeaderID = sqi.SourcingHeaderID 
   LEFT JOIN vwx_UserGroupDropDown_SEL ug ON sqi.WorkAssignedTo = ug.UserID
   WHERE StyleQuoteItemID = @StyleQuoteItemID
   
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08599', GetDate())
GO
