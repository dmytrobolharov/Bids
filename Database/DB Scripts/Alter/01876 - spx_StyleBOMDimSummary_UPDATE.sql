IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMDimSummary_UPDATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleBOMDimSummary_UPDATE]
GO
/****** Object:  StoredProcedure [dbo].[spx_StyleBOMDimSummary_UPDATE]    Script Date: 09/06/2011 12:20:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[spx_StyleBOMDimSummary_UPDATE]
(
	@StyleMaterialID uniqueidentifier
	,@StyleID uniqueidentifier
	,@StyleSet int	
	,@SQLString varchar(8000)	
	,@StyleBOMDimensionId uniqueidentifier
	,@MDate datetime
	,@MUser nvarchar(200)
)

AS

BEGIN

	EXEC(@SqlString)

END

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01876'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01876', GetDate())
END

GO		