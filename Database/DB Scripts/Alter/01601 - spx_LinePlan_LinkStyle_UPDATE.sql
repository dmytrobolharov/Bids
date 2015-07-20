IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlan_LinkStyle_UPDATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_LinePlan_LinkStyle_UPDATE]
GO

CREATE PROCEDURE dbo.spx_LinePlan_LinkStyle_UPDATE (
@LinePlanRangeID UNIQUEIDENTIFIER,
@MaterialCoreID UNIQUEIDENTIFIER,
@StyleID UNIQUEIDENTIFIER,
@NewStyleLinkID UNIQUEIDENTIFIER,
@MUser NVARCHAR(200),
@MDate DATETIME
)
AS 


	UPDATE pStyleHeader 
	SET MaterialCoreID = @MaterialCoreID, StyleLinkID = @NewStyleLinkID,
	MUser = @MUser, MDate = @MDate
	WHERE StyleID = @StyleID 




GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01601'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01601', GetDate())
END	

GO
