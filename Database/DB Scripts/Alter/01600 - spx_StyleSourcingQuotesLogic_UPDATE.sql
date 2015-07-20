IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSourcingQuotesLogic_UPDATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleSourcingQuotesLogic_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_StyleSourcingQuotesLogic_UPDATE] (
@StyleSourcingID uniqueidentifier,
@StyleQuoteItemID uniqueidentifier,
@MUser nvarchar(200),
@MDate datetime
)
AS 

SELECT 1

GO 

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01600'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01600', GetDate())
END	

GO
