INSERT pMilestoneTemplateItemSystemTrigger (SystemTriggerID, TriggerName, Active) VALUES (N'f3a889a9-d1f9-40b3-817a-0078c690c39e', N'Design Sample Final Date', 1)
INSERT pMilestoneTemplateItemSystemTrigger (SystemTriggerID, TriggerName, Active) VALUES (N'a2c9df1b-ac6d-4274-85c5-1b263e8e4c55', N'Proto Sample Final Date', 1)
INSERT pMilestoneTemplateItemSystemTrigger (SystemTriggerID, TriggerName, Active) VALUES (N'7cfadda9-1291-4647-acc4-4685fd4d9188', N'Tech Pack Due Date', 1)
INSERT pMilestoneTemplateItemSystemTrigger (SystemTriggerID, TriggerName, Active) VALUES (N'8c5a6171-4910-4260-8ce2-62a342825e47', N'Certificate of Conformity Final Date', 1)
INSERT pMilestoneTemplateItemSystemTrigger (SystemTriggerID, TriggerName, Active) VALUES (N'581d0e1e-ba95-4243-9051-67ccbf52e544', N'TOP of Production Final Date', 1)
INSERT pMilestoneTemplateItemSystemTrigger (SystemTriggerID, TriggerName, Active) VALUES (N'12b69a7a-70c9-4262-90e1-6b2e6397c02e', N'Packaging Approval Final Date', 1)
INSERT pMilestoneTemplateItemSystemTrigger (SystemTriggerID, TriggerName, Active) VALUES (N'7d6d05bd-9a6d-4d26-a41d-75eb7aac713a', N'Sales Sample Final Date', 1)
INSERT pMilestoneTemplateItemSystemTrigger (SystemTriggerID, TriggerName, Active) VALUES (N'0b181bb2-8b30-46d0-bfed-7d68f23c2d25', N'Fit Sample Final Date', 1)
INSERT pMilestoneTemplateItemSystemTrigger (SystemTriggerID, TriggerName, Active) VALUES (N'a4668af4-d97d-4b27-8480-93a179b060ac', N'Pre Production Final Date', 1)
INSERT pMilestoneTemplateItemSystemTrigger (SystemTriggerID, TriggerName, Active) VALUES (N'bee0b8a1-3ccb-433f-aed3-a6905ff45fdb', N'ProtoType Final Date', 1)
INSERT pMilestoneTemplateItemSystemTrigger (SystemTriggerID, TriggerName, Active) VALUES (N'0853f119-344a-4b55-8c1a-ae4dadd173ee', N'QA Worksheet Final Date', 1)
INSERT pMilestoneTemplateItemSystemTrigger (SystemTriggerID, TriggerName, Active) VALUES (N'87fc8505-34d2-4b42-8976-cab3f14133bb', N'Licensee Approval Final Date', 1)
INSERT pMilestoneTemplateItemSystemTrigger (SystemTriggerID, TriggerName, Active) VALUES (N'0abba22b-a7ee-49ba-8193-f7730f7fb5c7', N'Fabrication Final Date', 1)
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07175', GetDate())
GO
