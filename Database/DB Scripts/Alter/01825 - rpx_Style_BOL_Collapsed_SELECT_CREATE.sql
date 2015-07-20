
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[rpx_Style_BOL_Collapsed_SELECT]
(
	@StyleId NVARCHAR(50)
	,@StyleSet NVARCHAR(5)
)
AS

SELECT * FROM [dbo].[vw_StyleBOL_SELECT] LEFT OUTER JOIN pBOLBaseRateType ON vw_StyleBOL_SELECT.BaseRateId = pBOLBaseRateType.BaseRateTypeId
WHERE StyleID=@StyleId AND StyleSet=@StyleSet AND MacroParentId IS NULL
ORDER BY Sort,Sort2


GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01825'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01825', GetDate())
END

GO
