IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMTemp_DELETEQE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMTemp_DELETEQE]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleBOMTemp_DELETEQE] (
	@StyleMaterialID UNIQUEIDENTIFIER 
	,@StyleID UNIQUEIDENTIFIER
	,@StyleSet int
	,@StyleBOMDimensionId uniqueidentifier = null
	,@QuickEntry nvarchar(2)
	,@MDate datetime
	,@MUser nvarchar(200)	
)

AS 

DELETE FROM pStyleBOMTemp WHERE StyleMaterialID = @StyleMaterialID and StyleBOMDimensionId=@StyleBOMDimensionId
and StyleID=@StyleID and StyleSet=@StyleSet and QuickAdd=@QuickEntry
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03622', GetDate())
GO