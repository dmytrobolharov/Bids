/****** Object:  StoredProcedure [dbo].[spx_ColorFolderDescDuplicate_SELECT]    Script Date: 06/9/2011 19:14:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorFolderDescDuplicate_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorFolderDescDuplicate_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_ColorFolderDescDuplicate_SELECT]    Script Date: 06/9/2011 19:14:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_ColorFolderDescDuplicate_SELECT] (
	@ColorFolderDescription nvarchar(200),
	@ColorFolderID  UNIQUEIDENTIFIER = NULL
)
AS 

BEGIN

	IF @ColorFolderId IS NOT NULL
	BEGIN
		SELECT * FROM pColorFolder WHERE ColorFolderDescription = @ColorFolderDescription AND ColorFolderID <> @ColorFolderID
	END
	ELSE
	BEGIN
		SELECT * FROM pColorFolder WHERE ColorFolderDescription = @ColorFolderDescription
	END

END

GO

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03574', GetDate())
GO