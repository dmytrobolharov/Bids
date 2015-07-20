-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * UPDATE Script                                                                               */
-- * Database:                                                                                  */
-- * 27 May 2011                                                                                */
-- * WorkItem#2515 : in body "Silhouette Thumbnail View" tab through error due to null value    */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--

UPDATE pBodyType
SET BodyGridItem = 'Body_GridItem_Apparel.xml'
WHERE BodyTypeId = 10
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01477', GetDate())
GO