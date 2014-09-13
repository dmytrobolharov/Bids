-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 20 September 2010                                                                             */
-- *                                                                                            */
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
SET ANSI_NULLS ON
GO


IF EXISTS(select * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRSizerange_SELECT')
DROP PROCEDURE spx_pGRSizerange_SELECT
GO


IF EXISTS(select * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRAlternates_DELETE')
DROP PROCEDURE spx_pGRAlternates_DELETE
GO

CREATE PROCEDURE [dbo].[spx_pGRAlternates_DELETE]
@AlternatesGuidID UNIQUEIDENTIFIER
AS
   DELETE 
   FROM pGRAlternates
   WHERE AlternatesGuidID=@AlternatesGuidID
GO


IF EXISTS(select * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRAlternates_INSERT')
DROP PROCEDURE spx_pGRAlternates_INSERT
GO


CREATE PROCEDURE [dbo].[spx_pGRAlternates_INSERT]
@AlternatesGuidID UNIQUEIDENTIFIER, @CompanyGuidID UNIQUEIDENTIFIER, @AlternatesCode NVARCHAR (4), @AlternatesDesc NVARCHAR (100), @MUser NVARCHAR (200), @MDate DATETIME, @CUser NVARCHAR (200), @CDate DATETIME
AS
INSERT INTO pGRAlternates (CompanyGuidID, AlternatesGuidID, AlternatesCode, AlternatesDesc, MUser,MDate,CUser,CDate)
                   VALUES (@CompanyGuidID, @AlternatesGuidID, @AlternatesCode, @AlternatesDesc, @MUser,@MDate,@CUser,@CDate)
GO


IF EXISTS(select * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRAlternates_UPDATE')
DROP PROCEDURE spx_pGRAlternates_UPDATE
GO

CREATE PROCEDURE [dbo].[spx_pGRAlternates_UPDATE]
@AlternatesGuidID UNIQUEIDENTIFIER, @CompanyGuidID UNIQUEIDENTIFIER, @AlternatesCode NVARCHAR (4), @AlternatesDesc NVARCHAR (100), @Muser NVARCHAR (200), @MDate DATETIME
AS
    UPDATE pGRAlternates
      SET  AlternatesGuidID  = @AlternatesGuidID, 
              CompanyGuidID  = @CompanyGuidID, 
              AlternatesCode = @AlternatesCode, 
              AlternatesDesc = @AlternatesDesc,
                       MUser = @MUser,
                       MDate = @MDate
WHERE AlternatesGuidID = @AlternatesGuidID

GO


IF EXISTS(select * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRPOM_DELETE')
DROP PROCEDURE spx_pGRPOM_DELETE
GO

CREATE PROCEDURE [dbo].[spx_pGRPOM_DELETE]
@POMGuidID UNIQUEIDENTIFIER
AS
    DELETE 
      FROM dbo.pGRPOM 
     WHERE POMGuidID = @POMGuidID

    DELETE 
      FROM dbo.pGRPOMAlternates 
    WHERE  POMGuidID = @POMGuidID

    DELETE
      FROM dbo.pGRPOMCompany
     WHERE POMAlternatesId NOT IN (SELECT POMAlternatesId FROM pGRPOMAlternates)
GO


IF EXISTS(select * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRPOM_UPDATE')
DROP PROCEDURE spx_pGRPOM_UPDATE
GO

CREATE PROCEDURE [dbo].[spx_pGRPOM_UPDATE]
@POMGuidid UNIQUEIDENTIFIER, 
@RefCode NVARCHAR (12), 
@POMDesc NVARCHAR (200), 
@How2MeasText NVARCHAR (4000), 
@SortField REAL, 
@Muser NVARCHAR (200), 
@MDate DATETIME
AS
   UPDATE pGRPOM
      SET  POMGuidid = @POMGuidid,
             RefCode = @RefCode, 
             POMDesc = @POMDesc,
        How2MeasText = @How2MeasText,
           SortField = @SortField,
               MUser = @MUser,
               MDate = @MDate
    WHERE POMGuidid = @POMGuidid
GO

IF EXISTS(select * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRPOMAlternates_SELECT')
   DROP PROCEDURE spx_pGRPOMAlternates_SELECT
GO

CREATE PROCEDURE [dbo].[spx_pGRPOMAlternates_SELECT]
AS
BEGIN
	SELECT     a.POMGuidId, a.RefCode, a.POMDesc, a.How2MeasText, a.VideoSerialNumber, a.SortField, a.CnvtPOMDesc, a.ImageSerialNumber, 
                      a.CUser, a.CDate, a.Muser, a.MDate, b.AlternatesGuidId, b.POMAlternatesId, c.AlternatesCode AS Alternates, d.POMCompanyId
	FROM         pGRPOM AS a INNER JOIN
                     pGRPOMAlternates AS b ON a.POMGuidId = b.POMGuidId INNER JOIN
                     pGRAlternates AS c ON b.AlternatesGuidId = c.AlternatesGuidId INNER JOIN
                     pGRPOMCompany AS d ON b.POMAlternatesId = d.POMAlternatesId
	
END
GO


IF EXISTS(select * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRPOMCompany_DELETE')
   DROP PROCEDURE spx_pGRPOMCompany_DELETE
GO

CREATE PROCEDURE [dbo].[spx_pGRPOMCompany_DELETE]
@POMAlternatesId UNIQUEIDENTIFIER, 
@CompanyGuidId UNIQUEIDENTIFIER
AS
    DELETE 
      FROM  dbo.pGRPOMCompany 
     WHERE POMAlternatesId = @POMAlternatesId 
       AND CompanyGuidId=@CompanyGuidId
GO


IF EXISTS(select * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRPOMCompany_INSERT')
   DROP PROCEDURE spx_pGRPOMCompany_INSERT
GO

CREATE PROCEDURE [dbo].[spx_pGRPOMCompany_INSERT]
@POMCompanyId UNIQUEIDENTIFIER,
@CompanyGuidID UNIQUEIDENTIFIER,
@POMAlternatesId UNIQUEIDENTIFIER, 
@CUser NVARCHAR (200), 
@CDate DATETIME
AS
   INSERT INTO pGRPOMCompany(POMCompanyId, CompanyGuidID, POMAlternatesId, CUser,CDate)
                     VALUES (@POMCompanyId, @CompanyGuidID, @POMAlternatesId,@CUser,@CDate)
GO


IF EXISTS(select * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRSizeClass_INSERT')
     DROP PROCEDURE spx_pGRSizeClass_INSERT
GO

CREATE PROCEDURE [dbo].[spx_pGRSizeClass_INSERT]
@SizeClassCompanyID UNIQUEIDENTIFIER, 
@SizeClassGuidID UNIQUEIDENTIFIER,
@CompanyGuidID UNIQUEIDENTIFIER
AS
    INSERT INTO pGRSizeClassCompany(SizeClassCompanyID, CompanyGuidID, SizeClassGuidID)
                            VALUES (@SizeClassCompanyID, @CompanyGuidID, @SizeClassGuidID)
GO

IF EXISTS(select * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRSizeRange_DELETE')
     DROP PROCEDURE spx_pGRSizeRange_DELETE
GO


CREATE PROCEDURE [dbo].[spx_pGRSizeRange_DELETE]
@SizeRangeGuidId UNIQUEIDENTIFIER
AS
    DELETE
      FROM dbo.pGRSizeRange 
     WHERE SizeRangeGuidId=@SizeRangeGuidId

    DELETE
      FROM dbo.pGRSizeRangeDetail 
     WHERE SizeRangeId=@SizeRangeGuidId
GO


IF EXISTS(select * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRSizeRange_UPDATE')
     DROP PROCEDURE spx_pGRSizeRange_UPDATE
GO

CREATE PROCEDURE [dbo].[spx_pGRSizeRange_UPDATE]
@SizeRangeGuidId UNIQUEIDENTIFIER, 
@SizeRange NVARCHAR (60), 
@Active INT, 
@Muser NVARCHAR (200), 
@MDate DATETIME
AS
       UPDATE pGRSizeRange
          SET SizeRange= @SizeRange,
                Active = @Active, 
                 MUser = @MUser,  
                 MDate = @MDate
        WHERE SizeRangeGuidId = @SizeRangeGuidId
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '555', GetDate())
GO