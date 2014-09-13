/****** Object:  StoredProcedure [dbo].[spx_TradePartner_StyleTechPack_ChangeLog_SELECT]    Script Date: 02/01/2013 14:57:46 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TradePartner_StyleTechPack_ChangeLog_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TradePartner_StyleTechPack_ChangeLog_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_TradePartner_StyleTechPack_ChangeLog_SELECT]    Script Date: 02/01/2013 14:57:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_TradePartner_StyleTechPack_ChangeLog_SELECT]	
	@TechPackID UNIQUEIDENTIFIER,
	@TradePartnerID UNIQUEIDENTIFIER	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    declare @StyleID UNIQUEIDENTIFIER = NULL,
			@StartDate DATETIME = NULL,
			@EndDate DATETIME = NULL

	SELECT @EndDate = CDate, @StyleID = StyleID FROM pTechPack WHERE TechPackID = @TechPackID
	-- get previous techpack cdate
	SELECT TOP 1 @StartDate = CDate FROM pTechPack WHERE CDate < @EndDate AND StyleID = @StyleID ORDER BY CDate DESC
	
	declare @WhereCond as NVARCHAR(MAX) = 
		N' WHERE WorkflowID IN (
				SELECT WorkflowID FROM pStyleWorkflowTeam 
					WHERE StyleID = ''' + CAST(@StyleID as NVARCHAR(40)) + ''' AND TeamID = ''' + CAST(@TradePartnerID as NVARCHAR(40)) + ''') 
			ORDER BY Workflow ASC, ChangeDate Desc'

	exec spx_ChangeLog_SELECT 
		@ChangeTableID = 'D612FAAE-7ACD-DF11-AF06-005056C00008', -- full style change log
		@ChangeTransTablePKID = @StyleID,
		@StartDate = @StartDate,
		@EndDate = @EndDate,
		@WhereCond = @WhereCond
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04956', GetDate())
GO