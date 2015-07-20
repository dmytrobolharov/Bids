IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_BOL_Collapsed_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_BOL_Collapsed_SELECT]
GO

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

SELECT PageOperationId, Code, Name, Comments, RateCode, SAM, Coef, Adj, MacroId, MacroParentId 
FROM vw_StyleBOL_SELECT LEFT OUTER JOIN 
	pBOLBaseRateType ON vw_StyleBOL_SELECT.BaseRateId = pBOLBaseRateType.BaseRateTypeId
WHERE StyleID = @StyleId AND StyleSet = @StyleSet 
	AND IsException = 0
	AND MacroParentId IS NULL
ORDER BY Sort

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03215'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03215', GetDate())

END
GO