-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 29 May 2012                                                                              */
-- *                                                                                            */
-- * Copyright (c) 2002-2012 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--
/****** Object:  StoredProcedure [dbo].[spx_LinePlanMaterial_DELETE]    Script Date: 05/29/2012 15:27:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanMaterial_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlanMaterial_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlanMaterial_DELETE]    Script Date: 05/29/2012 15:27:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Yogesh Lad>
-- Create date: <Create Date,,25/05/2012>
-- Description:	<Description,,Procedure to delete selected line plan materials>
-- =============================================
CREATE PROCEDURE [dbo].[spx_LinePlanMaterial_DELETE]
	-- Add the parameters for the stored procedure here
	@linePlanID UNIQUEIDENTIFIER, 
	@MaterialID UNIQUEIDENTIFIER,
	@TID NVARCHAR(2)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    IF(@TID='1')
    BEGIN
		DELETE FROM 
			pLinePlanMaterial 
		WHERE 
			LinePlanID=@LinePlanID
			AND MaterialID=@MaterialID 
	END
	ELSE
	BEGIN
		IF(@TID='2')
		BEGIN
			DELETE FROM 
				pLinePlanMaterialItem 
			WHERE 
				LinePlanID=@LinePlanID
				AND MaterialID=@MaterialID 
		END
	END
	
END

GO



	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03558', GetDate())
	
GO
