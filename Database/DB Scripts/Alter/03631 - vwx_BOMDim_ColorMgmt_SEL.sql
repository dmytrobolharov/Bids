-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 06 june 2012                                                                               */
-- * WorkItem #8772                                                                      */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].vwx_BOMDim_ColorMgmt_SEL]'))
DROP VIEW [dbo].[vwx_BOMDim_ColorMgmt_SEL]
GO



SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vwx_BOMDim_ColorMgmt_SEL]
AS

select stylematerialId as styleMaterialPKId, stylematerialId, materialId, materialno, materialname, 
'00000000-0000-0000-0000-000000000000' as StyleMaterialMiscID, 
 0 as SubMaterial, Placement, Colorway, AUTOCOLOR, StyleBOMDimensionId, WorkflowId, 
WorkflowItemId, ComponentOrder, MaterialSort, MainMaterial from pStyleBOM 					
INNER JOIN  pComponentType ON pStyleBOM.MaterialType = pComponentType.ComponentTypeID 
union
select p.StyleMaterialMiscID as styleMaterialPKId, b.stylematerialId,  b.materialId, p.materialno, p.materialname, p.StyleMaterialMiscID ,
1 as SubMaterial, b.Placement, b.Colorway, b.AutoColor, 
b.StyleBOMDimensionId, b.WorkflowId, b.WorkflowItemId, ComponentOrder, MaterialSort, MainMaterial from pStyleBOM b					
INNER JOIN  pStyleBOMMiscItem p ON  b.stylematerialId = p.stylematerialId
and b.StyleBOMDimensionId = p.StyleBOMDimensionId 
INNER JOIN  pComponentType ON b.MaterialType = pComponentType.ComponentTypeID 


go

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03631', GetDate())

GO


