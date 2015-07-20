/****** Object:  StoredProcedure [dbo].[spx_StyleSharedTradePartner_SELECT]    Script Date: 12/19/2012 18:33:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSharedTradePartner_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleSharedTradePartner_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleSharedTradePartner_SELECT]    Script Date: 12/19/2012 18:33:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleSharedTradePartner_SELECT]
	-- Add the parameters for the stored procedure here
	@StyleDevelopmentID UNIQUEIDENTIFIER,
	@SearchCond NVARCHAR(MAX)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT *, (SELECT COUNT(*) FROM pStyleTeam WHERE StyleDevelopmentId = @StyleDevelopmentID AND TeamID = tp.TradePartnerID) as IsShared
	INTO #tmpTechPackTP
    FROM vwx_Sourcing_TradePartner_REL_SEL tp
    WHERE Direct = 1 AND Active = 1
    
    EXEC('SELECT * FROM #tmpTechPackTP ' + @SearchCond)
    
    DROP TABLE #tmpTechPackTP
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04670', GetDate())
GO