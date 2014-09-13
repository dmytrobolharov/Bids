IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleHeaderLogic_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleHeaderLogic_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_StyleHeaderLogic_SELECT](
	@StyleID UNIQUEIDENTIFIER
)
AS



	SELECT * FROM vwx_StyleHeader_SELECT 
	WHERE StyleID = @StyleID 

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01033', GetDate())
GO