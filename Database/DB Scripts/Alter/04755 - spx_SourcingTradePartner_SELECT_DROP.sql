/****** Object:  StoredProcedure [dbo].[spx_SourcingTradePartner_SELECT]    Script Date: 01/11/2013 17:07:05 ******/

-- No need in this procedure anymore after converting to new tree structure. 
-- Use spx_SourcingTradePartners_SELECT instead. It is the correct one.
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingTradePartner_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingTradePartner_SELECT]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04755', GetDate())
GO

