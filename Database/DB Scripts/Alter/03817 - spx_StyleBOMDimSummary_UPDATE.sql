IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMDimSummary_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMDimSummary_UPDATE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleBOMDimSummary_UPDATE]
(
	@StyleMaterialID uniqueidentifier
	,@StyleID uniqueidentifier
	,@StyleSet int	
	,@SQLString nvarchar(4000)	
	,@StyleBOMDimensionId uniqueidentifier
	,@MDate datetime
	,@MUser nvarchar(200)
)

AS

BEGIN

	EXEC(@SqlString)

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03817', GetDate())
GO
