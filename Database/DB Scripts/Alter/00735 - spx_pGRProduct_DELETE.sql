-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 19 July 2010                                                                                */
-- *                                                                                            */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */                                                                     */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS                                                                                    
--
--
--set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

IF  EXISTS (SELECT * from INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRGarment_DELETE') 
DROP PROCEDURE spx_pGRGarment_DELETE

IF  EXISTS (SELECT * from INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRProduct_DELETE') 
DROP PROCEDURE spx_pGRProduct_DELETE


GO


CREATE PROCEDURE [dbo].[spx_pGRProduct_DELETE]
(@ProductId  uniqueidentifier)
AS 

DELETE FROM dbo.pGRProduct WHERE ProductID= @ProductId 
DELETE FROM dbo.pGRProductCompany WHERE ProductId= @ProductId
DELETE FROM dbo.pGRProductClassImage WHERE ProductCompanyId NOT IN (SELECT ProductCompanyId
FROM pGRProductCompany)

GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '735', GetDate())
GO

