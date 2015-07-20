ALTER PROCEDURE [dbo].[spx_StyleQuoteVariationLogic_UPDATE]
(
@StyleQuoteVariationID uniqueidentifier
)
AS 


DECLARE @Dummy INT
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01064', GetDate())
GO