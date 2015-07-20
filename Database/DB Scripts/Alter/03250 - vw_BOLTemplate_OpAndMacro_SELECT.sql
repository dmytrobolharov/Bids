IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_BOLTemplate_OpAndMacro_SELECT]'))
DROP VIEW [dbo].[vw_BOLTemplate_OpAndMacro_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vw_BOLTemplate_OpAndMacro_SELECT]
AS
SELECT	t.TemplateEntryId, t.MacroId, t.TemplateID, o.OperationID, o.OperationCode AS Code, o.OperationName AS Name, 
		o.CUser AS OpM_CUser, o.MUser AS OpM_MUser, o.CDate AS OpM_CDate, o.MDate AS OpM_MDate, o.Active AS OpM_Active, 
		NULL AS MacroParentId, t.Sort, NULL AS Sort1, NULL AS Sort2, 
		o.SAM, o.MachineId, o.BaseRateId, 
		o.Image AS ImageID, '<img src=''../System/Control/ImageStream.ashx?IT=BOLOP&S=50&ID=' + CAST(ISNULL(o.Image, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + ''' />' AS Image, 
		t.CUser, t.CDate, t.MUser, t.MDate, t.Active
FROM	dbo.pBOLTemplateEntries t INNER JOIN pBOLOperations o
		ON t.OperationId = o.OperationId
UNION
SELECT	t.TemplateEntryId, t.MacroId, t.TemplateID, NULL AS OperationID, m.MacroCode AS Code, m.MacroName AS Name, 
		m.CUser AS OpM_CUser, m.MUser AS OpM_MUser, m.CDate AS OpM_CDate, m.MDate AS OpM_MDate, m.Active AS OpM_Active,
		NULL AS MacroParentId, t.Sort, t.TemplateEntryId AS Sort1, NULL AS Sort2, 
		NULL AS SAM, NULL AS MachineID, NULL AS BaseRateId, 
		m.Image AS ImageID, '<img src=''../System/Control/ImageStream.ashx?IT=BOLMOP&S=50&ID=' + CAST(ISNULL(Image, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + ''' />' AS Image, 
		t.CUser, t.CDate, t.MUser, t.MDate, t.Active
FROM	dbo.pBOLTemplateEntries t INNER JOIN pBOLMacro m 
		ON t.MacroId = m.MacroId
UNION ALL
SELECT	t.TemplateEntryId, t.MacroId, t.TemplateID, o.OperationID, o.OperationCode AS Code, o.OperationName AS Name,
		o.CUser AS OpM_CUser, o.MUser AS OpM_MUser, o.CDate AS OpM_CDate, o.MDate as OpM_MDate, o.Active AS OpM_Active,
		t.TemplateEntryId AS MacroParentId, t.Sort, t.TemplateEntryId AS Sort1, otm.Sort AS Sort2, 
		o.SAM, o.MachineId, o.BaseRateId AS BaseRateId, 
		o.Image AS ImageID, '<img src=''../System/Control/ImageStream.ashx?IT=BOLOP&S=50&ID=' + CAST(ISNULL(o.Image, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + ''' />' AS Image, 
		t.CUser, t.CDate, t.MUser, t.MDate, t.Active
FROM	dbo.pBOLTemplateEntries t INNER JOIN 
		pBOLOpToMacro otm ON t.MacroId = otm.MacroId INNER JOIN 
		pBOLOperations o ON otm.OperationId = o.OperationId INNER JOIN 
		pBOLMacro mp on t.MacroId = mp.MacroId 

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03250'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03250', GetDate())

END
GO