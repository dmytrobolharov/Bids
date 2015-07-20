/****** Object:  View [dbo].[vw_StyleBOL_SELECT]    Script Date: 11/04/2011 14:23:19 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_StyleBOL_SELECT]'))
DROP VIEW [dbo].[vw_StyleBOL_SELECT]
GO

/****** Object:  View [dbo].[vw_StyleBOL_SELECT]    Script Date: 11/04/2011 14:23:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_StyleBOL_SELECT]
AS
/* SELECT Linked Macro*/
SELECT     PageOperationId, MacroCode AS Code, MacroName AS Name, NULL AS OpToMacroId, Sort, PageOperationId AS Sort1, '0' AS Sort2, 
                      pStyleBOLPageOperations.Comments, Image AS ImageID, 'BOLMOP' AS ImageType,
                          (SELECT     SUM(SAM)
                            FROM          pBOLOperations INNER JOIN
                                                   pBOLOpToMacro ON pBOLOperations.OperationId = pBOLOpToMacro.OperationId
                            WHERE      pBOLOpToMacro.MacroId = pBOLMacro.MacroId) AS SAM, pStyleBOLPageOperations.Coef, pStyleBOLPageOperations.Adj, NULL AS BaseRateId, NULL 
                      AS MachineId, pStyleBOLPageOperations.IsLinked, pStyleBOLPageOperations.MacroId, NULL AS OperationId, NULL AS MacroParentId, StyleID, StyleSet, 
                      pStyleBOLPageOperations.IsException
FROM         pStyleBOLPageOperations INNER JOIN
                      pBOLMacro ON pStyleBOLPageOperations.MacroId = pBOLMacro.MacroId
WHERE     IsLinked = 1 AND pStyleBOLPageOperations.MacroId IS NOT NULL
UNION
/* SELECT Operations of Linked Macro*/ SELECT PageOperationId, pBOLOperations.OperationCode AS Code, pBOLOperations.OperationName AS Name, OpToMacroId, 
                      pStyleBOLPageOperations.Sort, pStyleBOLPageOperations.PageOperationId AS Sort1, pBOLOpToMacro.Sort AS Sort2, pStyleBOLPageOperations.Comments, 
                      pBOLOperations.Image AS ImageID, 'BOLOP' AS ImageType, pBOLOperations.SAM, NULL AS Coef, NULL AS Adj, pBOLOperations.BaseRateId, 
                      pBOLOperations.MachineId, pStyleBOLPageOperations.IsLinked, NULL AS MacroId, pBOLOperations.OperationId, PageOperationId AS MacroParentId, StyleID, 
                      StyleSet, pStyleBOLPageOperations.IsException
FROM         pStyleBOLPageOperations INNER JOIN
                      pBOLOpToMacro ON pStyleBOLPageOperations.MacroId = pBOLOpToMacro.MacroId INNER JOIN
                      pBOLOperations ON pBOLOpToMacro.OperationId = pBOLOperations.OperationId
WHERE     IsLinked = 1 AND pStyleBOLPageOperations.MacroId IS NOT NULL
UNION
/* SELECT Linked Operations*/ SELECT PageOperationId, OperationCode AS Code, OperationName AS Name, NULL AS OpToMacroId, pStyleBOLPageOperations.Sort, NULL 
                      AS Sort1, '0' AS Sort2, pStyleBOLPageOperations.Comments, Image AS ImageID, 'BOLOP' AS ImageType, pBOLOperations.SAM, pStyleBOLPageOperations.Coef, 
                      pStyleBOLPageOperations.Adj, pBOLOperations.BaseRateId, pBOLOperations.MachineId, pStyleBOLPageOperations.IsLinked, NULL AS MacroId, 
                      pStyleBOLPageOperations.OperationId, NULL AS MacroParentId, StyleID, StyleSet, pStyleBOLPageOperations.IsException
FROM         pStyleBOLPageOperations INNER JOIN
                      pBOLOperations ON pStyleBOLPageOperations.OperationId = pBOLOperations.OperationId
WHERE     IsLinked = 1 AND pStyleBOLPageOperations.OperationId IS NOT NULL
UNION
/* SELECT Operations of Unlinked Macro*/ SELECT T1.PageOperationId, T1.Code, T1.Name, NULL AS OpToMacroId, T2.Sort, T1.MacroParentId AS Sort1, T1.Sort AS Sort2, 
                      T1.Comments, T1.ImageID, T1.ImageType, T1.SAM, T1.Coef, T1.Adj, T1.BaseRateId, T1.MachineId, T1.IsLinked, T1.MacroId, T1.OperationId, T1.MacroParentId, 
                      T1.StyleID, T1.StyleSet, T1.IsException
FROM         pStyleBOLPageOperations AS T1 INNER JOIN
                      pStyleBOLPageOperations AS T2 ON T1.MacroParentId = T2.PageOperationId
WHERE     T1.IsLinked = 0 AND T1.MacroParentId IS NOT NULL
UNION
/* SELECT Unlinked Operations or Unlinked Macro*/ SELECT T4.PageOperationId, T4.Code, T4.Name, NULL AS OpToMacroId, T4.Sort, T4.PageOperationId AS Sort1, '0' AS Sort2, 
                      T4.Comments, T4.ImageID, T4.ImageType, SAM = CASE WHEN MacroId IS NOT NULL THEN
                          (SELECT     SUM((T3.SAM * ISNULL(T3.Coef, 1)) + (T3.SAM * ISNULL(T3.Coef, 1) * ISNULL(cast(T3.Adj AS numeric(10, 2)), 0) / 100))
                            FROM          pStyleBOLPageOperations AS T3
                            WHERE      T3.MacroParentId = T4.PageOperationId) ELSE SAM END, T4.Coef, T4.Adj, T4.BaseRateId, T4.MachineId, T4.IsLinked, T4.MacroId, T4.OperationId, 
                      T4.MacroParentId, T4.StyleID, T4.StyleSet, T4.IsException
FROM         pStyleBOLPageOperations AS T4
WHERE     T4.IsLinked = 0 AND T4.MacroParentId IS NULL

GO



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02123'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02123', GetDate())
	END
GO