/****** Object:  StoredProcedure [dbo].[spx_TradePartnerMgmtInfo_SELECT]    Script Date: 12/18/2012 11:06:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TechPackSharedTradePartner_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TechPackSharedTradePartner_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_TradePartnerMgmtInfo_SELECT]    Script Date: 12/18/2012 11:06:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_TechPackSharedTradePartner_SELECT] 
	@TechPackID UNIQUEIDENTIFIER,
	@StyleID UNIQUEIDENTIFIER,
	@SearchCond NVARCHAR(MAX) = ''
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT *, (SELECT COUNT(*) FROM pTechPackTeam WHERE TechPackID = @TechPackID AND StyleId = @StyleID AND TeamID = tp.TradePartnerID) as IsShared
	INTO #tmpTechPackTP
    FROM vwx_Sourcing_TradePartner_REL_SEL tp
    WHERE Direct = 1 AND Active = 1
    
    EXEC('SELECT * FROM #tmpTechPackTP ' + @SearchCond)
    
    DROP TABLE #tmpTechPackTP
    
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04665', GetDate())
GO