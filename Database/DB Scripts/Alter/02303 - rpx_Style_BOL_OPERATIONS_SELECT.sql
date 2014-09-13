/****** Object:  StoredProcedure [dbo].[rpx_Style_BOL_OPERATIONS_SELECT]    Script Date: 12/06/2011 17:02:29 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_BOL_OPERATIONS_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_BOL_OPERATIONS_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_Style_BOL_OPERATIONS_SELECT]
(
	@StyleId NVARCHAR(50),
	@StyleSet NVARCHAR(5)
)
AS
BEGIN
	SELECT 
		* 
	FROM [dbo].[vw_Style_BOL_OPERATIONS_SELECT] VW	
	WHERE 
		StyleID=@StyleId 
		AND StyleSet=@StyleSet 
END

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02303'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02303', GetDate())
	END
GO	


