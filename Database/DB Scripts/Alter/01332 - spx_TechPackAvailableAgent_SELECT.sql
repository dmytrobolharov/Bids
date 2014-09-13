IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TechPackAvailableAgent_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_TechPackAvailableAgent_SELECT]
GO

  
CREATE PROCEDURE [dbo].[spx_TechPackAvailableAgent_SELECT]
(
@TradePartnerId uniqueidentifier,
@StyleId uniqueidentifier
)  
AS   
  
	SELECT * FROM pTechPack  WITH(NOLOCK)
	WHERE (TechpackId NOT IN ( SELECT TechPackId FROM pTechPackTeam WITH(NOLOCK) WHERE TeamId = @tradePartnerId)) 
        AND (StyleID = @StyleID) 
    ORDER BY TechPackNo DESC , TechPackName 



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01332', GetDate())
GO
