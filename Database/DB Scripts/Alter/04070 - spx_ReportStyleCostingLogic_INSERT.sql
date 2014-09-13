IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ReportStyleCostingLogic_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ReportStyleCostingLogic_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE  PROCEDURE [dbo].[spx_ReportStyleCostingLogic_INSERT]
(
	@StyleId VARCHAR(255),   
	@StyleSet INT,
	@StyleRequestBodyXml XML		
)
AS

BEGIN

	IF(NOT EXISTS(SELECT * FROM pStyleCostingXML WHERE StyleID=@StyleId AND StyleSet=@StyleSet))
	BEGIN
		INSERT INTO [pStyleCostingXML]
		   ([StyleID]
		   ,[StyleSet]
		   ,[SchemaXML])
		VALUES
		   (
		   @StyleId
		   ,@StyleSet
		   ,@StyleRequestBodyXml
		   )
	END	
	ELSE
	BEGIN
		DELETE FROM pStyleCostingXML WHERE StyleID=@StyleId AND StyleSet=@StyleSet 

		INSERT INTO [pStyleCostingXML]
		   ([StyleID]
		   ,[StyleSet]
		   ,[SchemaXML])
		VALUES
		   (
		   @StyleId
		   ,@StyleSet
		   ,@StyleRequestBodyXml
		   )
	END	
END

GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04070', GetDate())
GO
