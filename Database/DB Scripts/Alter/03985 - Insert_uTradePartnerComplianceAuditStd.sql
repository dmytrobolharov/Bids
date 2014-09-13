if not exists (select * from [uTradePartnerComplianceAuditStandard] WHERE [AuditStandardId] = '00000000-0000-0000-0000-000000000001')
	begin
		INSERT INTO [dbo].[uTradePartnerComplianceAuditStandard]
           ([AuditStandardId]
           ,[AuditStandardCode]
           ,[AuditStandardDesc]           
           ,[Active]
           )
		VALUES
           ('00000000-0000-0000-0000-000000000001'
           ,'SA8000'
           ,'SA8000'
           ,1
           )
	end
GO

if not exists (select * from [uTradePartnerComplianceAuditStandard] WHERE [AuditStandardId] = '00000000-0000-0000-0000-000000000002')
	begin
		INSERT INTO [dbo].[uTradePartnerComplianceAuditStandard]
           ([AuditStandardId]
           ,[AuditStandardCode]
           ,[AuditStandardDesc]           
           ,[Active]
           )
		VALUES
           ('00000000-0000-0000-0000-000000000002'
           ,'WRAP'
           ,'WRAP'
           ,1
           )
	end
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03985', GetDate())
GO