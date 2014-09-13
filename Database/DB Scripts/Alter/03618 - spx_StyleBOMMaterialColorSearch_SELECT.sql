/****** Object:  StoredProcedure [dbo].[spx_StyleBOMMaterialColorSearch_SELECT]    Script Date: 06/12/2012 13:35:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMMaterialColorSearch_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMMaterialColorSearch_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleBOMMaterialColorSearch_SELECT]    Script Date: 06/12/2012 13:35:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleBOMMaterialColorSearch_SELECT]
	-- Add the parameters for the stored procedure here
	@MaterialID UNIQUEIDENTIFIER,
	@SearchTerm NVARCHAR(MAX)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SET @SearchTerm = '%' + @SearchTerm + '%'

    
	SELECT * FROM vwx_MaterialColor_SEL 
	WHERE MaterialID = @MaterialID AND (ColorCode LIKE @SearchTerm OR ColorName LIKE @SearchTerm)
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03618', GetDate())
GO