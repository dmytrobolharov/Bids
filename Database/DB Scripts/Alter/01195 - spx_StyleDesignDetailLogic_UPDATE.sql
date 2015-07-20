



IF  EXISTS (SELECT * from INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_StyleDesignDetailLogic_UPDATE') 
DROP PROCEDURE spx_StyleDesignDetailLogic_UPDATE
GO


CREATE PROCEDURE [dbo].[spx_StyleDesignDetailLogic_UPDATE] (
	@StyleDesignDetailID UNIQUEIDENTIFIER,
	@MUser NVARCHAR(200),
	@MDate DATETIME,
	@TeamID UNIQUEIDENTIFIER
)
AS


SELECT 1


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01195', GetDate())
