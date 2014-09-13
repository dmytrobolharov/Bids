/****** Object:  StoredProcedure [dbo].[rpx_Style_Print_Comments_SELECT]    Script Date: 06/9/2011 19:14:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_Print_Comments_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_Print_Comments_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[rpx_Style_Print_Comments_SELECT]    Script Date: 06/9/2011 19:14:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[rpx_Style_Print_Comments_SELECT]   
	@StyleId VARCHAR(255),
	@StyleSet INT,
	@WorkflowID  VARCHAR(255)
AS  

BEGIN

	SELECT MUser,StyleComment FROM pStyleComment  WHERE StyleSet = @StyleSet 
	AND  StyleID =@StyleId
	AND  WorkflowID = @WorkflowID ORDER BY MDate DESC
	
END

Go

		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES     ('DB_Version', '5.0.0000', '03615', GetDate())
GO