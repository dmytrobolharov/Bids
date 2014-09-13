IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleDesignDetail_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleDesignDetail_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleDesignDetail_SELECT]    Script Date: 06/9/2011 19:14:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE  [dbo].[spx_StyleDesignDetail_SELECT](
	@StyleID UNIQUEIDENTIFIER,
	@StyleSet INT 
)
AS

BEGIN
	SELECT * FROM pStyleDetail WITH(NOLOCK)
	WHERE StyleID = @StyleID 
	AND StyleSet =  @StyleSet 
	ORDER BY Sort ASC
END

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03101'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03101', GetDate())
END	
GO