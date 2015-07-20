
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 8 June 2011                                                                                */
-- * WorkItem#3279                                                                              */
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

/****** Object:  StoredProcedure [dbo].[spx_LinePlanNonApparelCheck_SELECT]    Script Date: 05/25/2011 19:14:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanNonApparelCheck_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlanNonApparelCheck_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlanNonApparelCheck_SELECT]    Script Date: 05/25/2011 19:14:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_LinePlanNonApparelCheck_SELECT] (
	@StyleTypeID INT 
)
AS

SELECT ISNULL(StyleNonApparel,0) FROM pStyleType WHERE StyleTypeID = @StyleTypeID

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01511', GetDate())

GO
