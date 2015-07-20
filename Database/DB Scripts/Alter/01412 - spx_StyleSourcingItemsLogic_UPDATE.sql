IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSourcingItemsLogic_UPDATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleSourcingItemsLogic_UPDATE]
GO 


CREATE PROCEDURE dbo.spx_StyleSourcingItemsLogic_UPDATE(
	@StyleSourcingID UNIQUEIDENTIFIER,
	@StyleColorID UNIQUEIDENTIFIER,
	@MUser NVARCHAR(200),
	@MDate DATETIME
)
AS

DECLARE @dummy INT

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01412', GETDATE())
GO	
