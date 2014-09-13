SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleBOL_Operations_SELECT] (
@StyleID UNIQUEIDENTIFIER, 
@StyleSet INT ,
@TeamID UNIQUEIDENTIFIER, 
@ComponentPackLabel INT 
)
AS 

	BEGIN 
		SELECT * FROM pBOLOperations 
		ORDER BY OperationName
	END 

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01817'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01817', GetDate())
END

GO
