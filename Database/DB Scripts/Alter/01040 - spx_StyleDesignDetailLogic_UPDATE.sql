IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleDesignDetailLogic_UPDATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleDesignDetailLogic_UPDATE]
GO


CREATE PROCEDURE dbo.spx_StyleDesignDetailLogic_UPDATE (
	@StyleDesignDetailID UNIQUEIDENTIFIER,
	@MUser NVARCHAR(200),
	@MDate DATETIME,
	@TeamID UNIQUEIDENTIFIER
)
AS

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01040', GetDate())
GO


