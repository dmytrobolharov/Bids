-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 14 July 2010                                                                               */
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

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[spx_User_Team_INSERT]
(@TeamID [uniqueidentifier],
@FirstName [nvarchar](50),
@MiddleName [nvarchar](50),
@LastName [nvarchar](50),
@Title [nvarchar](50),
@Company [nvarchar](200),
@Street1 [nvarchar](100),
@Street2 [nvarchar](100),
@City [nvarchar](100),
@State [nvarchar](50),
@Zip [nvarchar](50),
@Country [nvarchar](100),
@Phone [nvarchar](50),
@Fax [nvarchar](50),
@Mobile [nvarchar](50),
@UserName [nvarchar](25),
@PassWord [nvarchar](25),
@Email [nvarchar](50),
@Admin [bit],
@Active [bit],
@PublicAccess [bit],
@TradePartner [int],
@FULLNAME [nvarchar](255),
@MUser [nvarchar](200),
@MDate [datetime])
AS INSERT INTO dbo.Users
    (FirstName, MiddleName, LastName, Title, Company, Street1, Street2, City, State, Zip, Country, Phone, Fax, Mobile, UserName, PassWord, 
     Email, Admin, Active, PublicAccess, TradePartner, FULLNAME, CUser, CDate, MUser, MDate, TeamID)
VALUES (@FirstName, @MiddleName, @LastName, @Title, @Company, @Street1, @Street2, @City, @State, @Zip, @Country, @Phone, @Fax, @Mobile, @UserName, @PassWord, 
        @Email, @Admin, @Active, @PublicAccess, @TradePartner, @FULLNAME, @MUser, @MDate, @MUser, @MDate, @TeamID)
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '239', GetDate())
GO
