IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSourcingColor_CHECK_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleSourcingColor_CHECK_SELECT]
GO


CREATE PROCEDURE dbo.spx_StyleSourcingColor_CHECK_SELECT(
@StyleSourcingID UNIQUEIDENTIFIER,
@StyleColorID UNIQUEIDENTIFIER
)
AS

DECLARE  @StyleSourcingColorID UNIQUEIDENTIFIER 

SELECT @StyleSourcingColorID = StyleSourcingColorID 
FROM pStyleSourcingColor
WHERE StyleSourcingID = @StyleSourcingID 
AND StyleColorID = @StyleColorID 


IF @StyleSourcingColorID IS NULL 
BEGIN 
	SET @StyleSourcingColorID = NEWID()

	INSERT INTO pStyleSourcingColor  ( StyleSourcingColorID , StyleSourcingID, StyleColorID ) 
	VALUES ( @StyleSourcingColorID, @StyleSourcingID, @StyleColorID )
END 

SELECT @StyleSourcingColorID AS StyleSourcingColorID 


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '096', GetDate())

GO

