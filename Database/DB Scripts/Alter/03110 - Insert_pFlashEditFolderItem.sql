
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 10 Feb 2011																				*/
-- * WorkItem #6975																				*/
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

IF NOT EXISTS(SELECT FlashEditFolderItemId FROM  pFlashEditFolderItem WHERE FlashEditFolderItemId='66270e9d-1786-e011-9810-005056b93888')
BEGIN

INSERT [dbo].[pFlashEditFolderItem] ([FlashEditFolderItemId], [FlashEditFolderId], [FlashEditFormName], [FlashEditItemName], [FlashEditItemDescription], [FlashEditTableName], [FlashEditTablePKI], [FlashEditItemSort], [FlashEditItemURL], [FlashEditItemXML], [FlashEditItemSearchXML], [FlashEditItemBatchXML], [FlashEditItemBatchGridXML], [Active], [CUser], [CDate], [MUser], [MDate], [SPXFlashEditItemLogicUpdate], [SPXFlashEditItemLogicSelect]) 
VALUES (N'66270e9d-1786-e011-9810-005056b93888', N'985b2f44-ef92-4d27-a606-91b90c579495', N'Style Workflow', N'Style Workflow', N'Style Workflow Edit', N'pStyleWorkflow', N'StyleWorkflowID', N'00002', N'FlashEdit_Search.aspx', N'Flashedit_Style_Workflow_Default.xml', N'FlashEdit_Style_Workflow_Search.xml', N'FlashEdit_Style_Workflow_Batch.xml', N'FlashEdit_Style_Workflow_BatchGrid.xml', 1, NULL, NULL, NULL, NULL, NULL, NULL)

END
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03110'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03110', GetDate())

END
GO