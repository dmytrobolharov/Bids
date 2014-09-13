/****** Object:  StoredProcedure [dbo].[spx_LinePlan_ListGrid_SELECT]    Script Date: 06/9/2011 19:14:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_ImageFolder_ImageComments_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_ImageFolder_ImageComments_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[rpx_ImageFolder_ImageComments_SELECT]    Script Date: 06/9/2011 19:14:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[rpx_ImageFolder_ImageComments_SELECT] 	 
	@ImageID varchar(255)
AS

BEGIN
	SELECT * FROM pImageComment WHERE ImageID=@ImageID
END

GO

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03582', GetDate())
GO