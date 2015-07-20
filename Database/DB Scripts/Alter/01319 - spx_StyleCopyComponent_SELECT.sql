IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCopyComponent_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleCopyComponent_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_StyleCopyComponent_SELECT](
	@StyleID UNIQUEIDENTIFIER, 
	@StyleSet INT, 
	@TeamID UNIQUEIDENTIFIER
)
AS	


SELECT * FROM dbo.pStyleMaterials WITH(NOLOCK)
WHERE StyleID  = @StyleID 
	AND StyleSet = @StyleSet


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01319', GetDate())

GO