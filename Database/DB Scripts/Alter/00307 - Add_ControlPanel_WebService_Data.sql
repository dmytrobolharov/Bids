-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 16 August 2010                                                                             */
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

-- Control Panel
INSERT INTO sWebService(WebServiceID, WebServiceName, WebServiceDefaultSchema, Active)
VALUES ('2F18EDED-2A50-4842-AE8A-3A17CEF73663', 'Control Panel', 'WebService_ControlPanel_Default.xml', 1)
GO

    -- Division
    INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
    VALUES ('2F18EDED-2A50-4842-AE8A-3A17CEF73663', '931B1182-4982-46ea-A49B-064F7466808B', 'Division', 'WebService_ControlPanel_Division_Default.xml', 1)
    GO

    -- Size Range
    INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
    VALUES ('2F18EDED-2A50-4842-AE8A-3A17CEF73663', 'D26C1701-913C-4a94-859B-D8FF74F2D625', 'Size Range', 'WebService_ControlPanel_SizeRange_Default.xml', 1)
    GO

    -- Design Template
    INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
    VALUES ('2F18EDED-2A50-4842-AE8A-3A17CEF73663', '5CA9BE7A-BB31-4972-9CD0-73DCEF15C3DF', 'Design Template', 'WebService_ControlPanel_DesignTemplate_Default.xml', 1)
    GO

    -- Season
    INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
    VALUES ('2F18EDED-2A50-4842-AE8A-3A17CEF73663', '7AF125C2-61F1-4d89-9781-2A211E7501D0', 'Season', 'WebService_ControlPanel_Season_Default.xml', 1)
    GO

    -- POM Library
    INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
    VALUES ('2F18EDED-2A50-4842-AE8A-3A17CEF73663', '3D8DB945-BA7A-4b39-9FC0-F452B523CF56', 'POM Library', 'WebService_ControlPanel_POMLibrary_Default.xml', 1)
    GO

    -- POM Template
    INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
    VALUES ('2F18EDED-2A50-4842-AE8A-3A17CEF73663', '69D6DD57-FC4F-41ec-8989-885D59EF9FF0', 'POM Template', 'WebService_ControlPanel_POMTemplate_Default.xml', 1)
    GO

    -- Dev. Workflow
    INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
    VALUES ('2F18EDED-2A50-4842-AE8A-3A17CEF73663', '4AB37EC4-21D0-422e-BF99-CF30408191C9', 'Dev. Workflow', 'WebService_ControlPanel_DevWorkflow_Default.xml', 1)
    GO

    -- Sample Workflow
    INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
    VALUES ('2F18EDED-2A50-4842-AE8A-3A17CEF73663', '3576A8C7-F60A-4897-A663-DD432B8F497F', 'Sample Workflow', 'WebService_ControlPanel_SampleWorkflow_Default.xml', 1)
    GO

    -- Material Request Template
    INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
    VALUES ('2F18EDED-2A50-4842-AE8A-3A17CEF73663', 'CEA454B7-AA05-4ca7-809C-EA5675EEE54C', 'Material Request Template', 'WebService_ControlPanel_MaterialRequestTemplate_Default.xml', 1)
    GO

    -- Material Request Workflow
    INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
    VALUES ('2F18EDED-2A50-4842-AE8A-3A17CEF73663', '6F01884D-03B8-4f64-AD3C-68DAA18C69D1', 'Material Request Workflow', 'WebService_ControlPanel_MaterialRequestWorkflow_Default.xml', 1)
    GO

    -- Washing
    INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
    VALUES ('2F18EDED-2A50-4842-AE8A-3A17CEF73663', 'AD9DEAE3-3859-4590-B965-EDA3F8826539', 'Washing', 'WebService_ControlPanel_Washing_Default.xml', 1)
    GO

    -- Ironing
    INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
    VALUES ('2F18EDED-2A50-4842-AE8A-3A17CEF73663', '452EC4BD-BB2F-4a3b-8168-DFA378897040', 'Ironing', 'WebService_ControlPanel_Ironing_Default.xml', 1)
    GO

    -- Cycle
    INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
    VALUES ('2F18EDED-2A50-4842-AE8A-3A17CEF73663', '4602C203-AEC2-498d-8217-8425003618BF', 'Cycle', 'WebService_ControlPanel_Cycle_Default.xml', 1)
    GO

    -- Bleach
    INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
    VALUES ('2F18EDED-2A50-4842-AE8A-3A17CEF73663', 'F2100ACD-AF98-4ccb-815C-273E8EB42BB2', 'Bleach', 'WebService_ControlPanel_Bleach_Default.xml', 1)
    GO

    -- Drying
    INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
    VALUES ('2F18EDED-2A50-4842-AE8A-3A17CEF73663', '36F353D7-D0C8-4c89-BA2A-AAFB0C07C19F', 'Drying', 'WebService_ControlPanel_Drying_Default.xml', 1)
    GO

    -- Dry Cleaning
    INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
    VALUES ('2F18EDED-2A50-4842-AE8A-3A17CEF73663', '6C5582F9-FEFC-4479-8C43-CB7FA17EEBFE', 'Dry Cleaning', 'WebService_ControlPanel_DryCleaning_Default.xml', 1)
    GO

    -- Fabric Tradename
    INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
    VALUES ('2F18EDED-2A50-4842-AE8A-3A17CEF73663', '861959D1-72EE-4c08-97DF-F4346C576188', 'Fabric Tradename', 'WebService_ControlPanel_FabricTradename_Default.xml', 1)
    GO

    -- Size Construction
    INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
    VALUES ('2F18EDED-2A50-4842-AE8A-3A17CEF73663', 'A6DC5C85-8CAD-448a-9201-64E383913633', 'Size Construction', 'WebService_ControlPanel_SizeConstruction_Default.xml', 1)
    GO

    -- Color Group
    INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
    VALUES ('2F18EDED-2A50-4842-AE8A-3A17CEF73663', '6D834013-1C1C-4d24-A91C-D3987CC0825E', 'Color Group', 'WebService_ControlPanel_ColorGroup_Default.xml', 1)
    GO

    -- Stitch Type
    INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
    VALUES ('2F18EDED-2A50-4842-AE8A-3A17CEF73663', 'BD3E6AE6-F87E-44e9-BE98-DE712004D2BE', 'Stitch Type', 'WebService_ControlPanel_StitchType_Default.xml', 1)
    GO

    -- Care Template
    INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
    VALUES ('2F18EDED-2A50-4842-AE8A-3A17CEF73663', '4369BBC1-3B13-48ff-86E8-D728523F2604', 'Care Template', 'WebService_ControlPanel_CareTemplate_Default.xml', 1)
    GO

    -- Showroom
    INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
    VALUES ('2F18EDED-2A50-4842-AE8A-3A17CEF73663', '1BD89B49-961E-4423-9282-2FA41C46E7D3', 'Showroom', 'WebService_ControlPanel_Showroom_Default.xml', 1)
    GO

    -- Vendor/Price
    INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
    VALUES ('2F18EDED-2A50-4842-AE8A-3A17CEF73663', '0E585385-6C35-466e-A3C0-8189926E8604', 'Vendor/Price', 'WebService_ControlPanel_VendorPrice_Default.xml', 1)
    GO

    -- Exchange Rate
    INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
    VALUES ('2F18EDED-2A50-4842-AE8A-3A17CEF73663', 'EAB8F85B-7ACD-4347-B0C0-33AFF12ED1B5', 'Exchange Rate', 'WebService_ControlPanel_ExchangeRate_Default.xml', 1)
    GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '307', GetDate())
GO
