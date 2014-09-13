-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 16 July 2010                                                                               */
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

ALTER PROCEDURE [dbo].[spx_User_Team_UPDATE]
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
AS UPDATE Users
SET FirstName = @FirstName, 
    MiddleName = @MiddleName, 
    LastName = @LastName, 
    Title = @Title, 
    Company = @Company,
    Street1 = @Street1, 
    Street2 = @Street2, 
    City = @City, 
    State = @State, 
    Zip = @Zip, 
    Country = @Country,
    Phone = @Phone, 
    Fax = @Fax,
    Mobile = @Mobile, 
    UserName = @UserName, 
    PassWord = @PassWord, 
    Email = @Email, 
    Admin = @Admin, 
    Active = @Active, 
    PublicAccess = @PublicAccess, 
    TradePartner = @TradePartner, 
    FULLNAME = @FULLNAME, 
    MUser = @MUser,
    MDate = @MDate
WHERE TeamID = @TeamID
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '243', GetDate())
GO
