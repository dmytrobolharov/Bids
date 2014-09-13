IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_pBOLMacro_Select]'))
DROP VIEW [dbo].[vw_pBOLMacro_Select]
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[vw_pBOLMacro_Select]
AS
SELECT     MacroId, MacroName, MacroCode, Comments, Approved, CDate, CUser, MUser, MDate, Active, CategoryId, 
                      '<img src=''../System/Control/ImageStream.ashx?IT=BOLMOP&S=50&ID=' + CAST(ISNULL(Image, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) 
                      + ''' />' AS Image
FROM         dbo.pBOLMacro

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01736'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01736', GetDate())
END	
GO