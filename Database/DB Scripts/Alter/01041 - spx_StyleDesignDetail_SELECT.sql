IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleDesignDetail_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleDesignDetail_SELECT]
GO


CREATE PROCEDURE  [dbo].[spx_StyleDesignDetail_SELECT](
	@StyleID UNIQUEIDENTIFIER,
	@StyleSet INT 
)
AS

	SELECT * FROM pStyleDetail WITH(NOLOCK)
	WHERE StyleID = @StyleID 
	AND StyleSet =  @StyleSet 

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01041', GetDate())
GO