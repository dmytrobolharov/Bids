-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 15 May 2012                                                                                */
-- * WorkItem #8252																										*/
-- * Copyright (c) 2002-2011 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--

/****** Object:  View [dbo].[vwx_LinePlanMaterial_SEL]    Script Date: 05/15/2012 18:22:25 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_LinePlanMaterial_SEL]'))
DROP VIEW [dbo].[vwx_LinePlanMaterial_SEL]
GO



/****** Object:  View [dbo].[vwx_LinePlanMaterial_SEL]    Script Date: 05/15/2012 18:22:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vwx_LinePlanMaterial_SEL]
AS
SELECT     dbo.pMaterial.MaterialID, dbo.pMaterial.MaterialImageID, dbo.pMaterial.MaterialImageVersion, dbo.pMaterial.MaterialImageDetailID, 
                      dbo.pMaterial.MaterialImageDetailVersion, dbo.pMaterial.MaterialType, dbo.pMaterial.MaterialNo, dbo.pMaterial.MaterialName, dbo.pMaterial.A, 
                      dbo.pMaterial.B, dbo.pMaterial.C, dbo.pMaterial.D, dbo.pMaterial.E, dbo.pMaterial.F, dbo.pMaterial.G, dbo.pMaterial.H, dbo.pMaterial.I, 
                      dbo.pMaterial.J, dbo.pMaterial.K, dbo.pMaterial.L, dbo.pMaterial.M, dbo.pMaterial.N, dbo.pMaterial.O, dbo.pMaterial.P, dbo.pMaterial.Q, 
                      dbo.pMaterial.R, dbo.pMaterial.S, dbo.pMaterial.T, dbo.pMaterial.U, dbo.pMaterial.V, dbo.pMaterial.W, dbo.pMaterial.X, dbo.pMaterial.Y, 
                      dbo.pMaterial.Z, dbo.pMaterial.MaterialPlacement, dbo.pLinePlanMaterial.LinePlanMaterialID, dbo.pLinePlanMaterial.LinePlanID, 
                      dbo.pLinePlanMaterial.CUser, dbo.pLinePlanMaterial.CDate, dbo.pLinePlanMaterial.MUser, dbo.pLinePlanMaterial.MDate, 
                      dbo.pMaterial.MaterialCode,dbo.pmaterial.Active
                      
FROM         dbo.pMaterial INNER JOIN
                      dbo.pLinePlanMaterial ON dbo.pMaterial.MaterialID = dbo.pLinePlanMaterial.MaterialID



GO



	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.1.1000', '03451', GetDate())



GO

