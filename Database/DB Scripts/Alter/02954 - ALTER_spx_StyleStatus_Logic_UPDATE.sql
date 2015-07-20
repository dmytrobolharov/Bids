-- **********************************************************************************************/
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 19 January 2012                                                                            */
-- *                                                                                            */
-- * Copyright (c) 2002-2012 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- **********************************************************************************************/
-- **********************************************************************************************/
-- COMMENTS
--
--
--
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET NOCOUNT ON
GO


IF EXISTS (select * from sysobjects where id = object_id('spx_StyleStatus_Logic_UPDATE') and sysstat & 0xf = 4)
    drop procedure spx_StyleStatus_Logic_UPDATE
GO

CREATE PROCEDURE spx_StyleStatus_Logic_UPDATE
(
	@StyleID UNIQUEIDENTIFIER, 
	@StatusID INT, 
	@MUser NVARCHAR(200), 
	@MDate DATETIME, 
	@OUT INT = 1, 
	@MSG NVARCHAR(4000) = '' OUTPUT
)
AS

SET NOCOUNT ON

DECLARE @StyleName NVARCHAR(200) --Description 
DECLARE @Description NVARCHAR(200) --CustomField14
DECLARE @Company NVARCHAR(200)  -- CustomField1   
DECLARE @Division NVARCHAR(200)  -- CustomField2 
DECLARE @Brand NVARCHAR(200) --CustomField3 
DECLARE @ProdCategory NVARCHAR(200) --StyleCategory 
DECLARE @MerchCategory NVARCHAR(200) --CustomField4 
--DECLARE @Group NVARCHAR(200) --CustomField10

--DECLARE @MSG NVARCHAR(4000)
SET @MSG = ''

IF @StatusID = 1
BEGIN

                -- CHECK FIELDS !! 
                SELECT @StyleName = Description, @Description = CustomField14, @Company = CustomField1, 
                                @Division = CustomField2 , @Brand = CustomField3, @ProdCategory = StyleCategory, 
                                @MerchCategory = CustomField4 --@Group = CustomField10
                FROM pStyleHeader
                WHERE StyleID = @StyleID  
                
                IF LEN(ISNULL(@StyleName,'')) = 0 
                                SET @MSG = @MSG + 'Style Header - Style Name Field is not defined<br>' 
--             IF LEN(ISNULL(@Description,'')) = 0 
--                             SET @MSG = @MSG + 'Style Header - Description Field is not defined<br>'  
--             IF LEN(ISNULL(@Company,'')) = 0 
--                             SET @MSG = @MSG + 'Style Header - Company Field is not defined<br>'  
--             IF LEN(ISNULL(@Division,'')) = 0 
--                             SET @MSG = @MSG + 'Style Header - Division Field is not defined<br>'
--             IF LEN(ISNULL(@Brand,'')) = 0 
--                             SET @MSG = @MSG + 'Style Header - Brand Field is not defined<br>'
--             IF LEN(ISNULL(@ProdCategory,'')) = 0 
--                             SET @MSG = @MSG + 'Style Header - Product Category Field not defined<br>'
--             IF LEN(ISNULL(@MerchCategory,'')) = 0 
--                             SET @MSG = @MSG + 'Style Header - Merch Category Field not defined<br>'
                --IF LEN(ISNULL(@Group,'')) = 0 
                                --SET @MSG = @MSG + 'Style Header - Group Field is not defined<br>' 
                
                /*
                IF LEN(@MSG)=0 
                                UPDATE pStyleHeader
                                SET HeaderLocked = @StatusID  
                                WHERE StyleID = @StyleID 
                */

END 

/*
ELSE
BEGIN
                UPDATE pStyleHeader   SET ApprovalStatus = @StatusId
                WHERE StyleID = @StyleID
END
*/

SET NOCOUNT OFF

IF @OUT = 1 
                SELECT @MSG as [Message]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.2.0000', '02954', GetDate())
GO

SET NOCOUNT Off
GO
