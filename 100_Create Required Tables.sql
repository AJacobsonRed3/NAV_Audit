/* First, note that all my work assumes that you will create a separate reporting database for each actual NAV database you use.
   I do this to ensure that my objects never get clobbered.  Further, this eliminates many audit issues as a reporting developer only 
   needs to be able to read the actual NAV Database and need have no other authority */
   
/* Step 1 - Create a list of all Tables you wish to check for security.
    While NAV has hundreds of tables, you do not care about the vast majority for security purposes.
  Note that the first line can be replaced by  DROP IF EXISTs in later versions of T-SQL*/
IF OBJECT_ID('dbo.ImportantTables') IS NOT NULL DROP TABLE dbo.ImportantTables
go
CREATE TABLE [dbo].[ImportantTables](
	[ID] [INT] NOT NULL,
	[Name] [VARCHAR](30) NOT NULL,
	[SecurityType] [VARCHAR](15) NULL,
CONSTRAINT PK_ImportantTables 
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
) ON [PRIMARY]
)
GO
/* Step 2 - Insert Values into ImportantTables.  Note - I did this list once a few years ago and haven't adjusted it.  If you are missing a table, you can simply add it. (and if you do, you can please send me the table you wish to update*/

INSERT INTO dbo.ImportantTables
(
    ID,
    Name,
    SecurityType
)
VALUES
('15','G/L Account','Master Data'),
('18','Customer','Master Data'),
('23','Vendor','Master Data'),
('25','Vendor Ledger Entry','Transaction'),
('27','Item','Master Data'),
('30','Item Translation','NA'),
('32','Item Ledger Entry','Transaction'),
('36','Sales Header','Transaction'),
('37','Sales Line','Transaction'),
('38','Purchase Header','Transaction'),
('39','Purchase Line','Transaction'),
('43','Purch. Comment Line','Transaction'),
('44','Sales Comment Line','Transaction'),
('50','Accounting Period','Setup'),
('51','User Time Register','NA'),
('78','Printer Selection','NA'),
('79','Company Information','Setup'),
('80','Gen. Journal Template','Setup'),
('81','Gen. Journal Line','Transaction'),
('82','Item Journal Template','Transaction'),
('83','Item Journal Line','Transaction'),
('86','Exch. Rate Adjmt. Reg.','NA'),
('87','Date Compr. Register','NA'),
('90','BOM Component','NA'),
('91','User Setup','User Admin'),
('95','G/L Budget Name','Transaction'),
('96','G/L Budget Entry','Transaction'),
('97','Comment Line','NA'),
('98','General Ledger Setup','Setup'),
('99','Item Vendor','Master Data'),
('110','Sales Shipment Header','Transaction'),
('111','Sales Shipment Line','Transaction'),
('130','Incoming Document','NA'),
('131','Incoming Documents Setup','NA'),
('132','Incoming Document Approver','NA'),
('133','Incoming Document Attachment','NA'),
('134','Posted Docs. With No Inc. Buf.','NA'),
('135','Acc. Sched. KPI Web Srv. Setup','NA'),
('136','Acc. Sched. KPI Web Srv. Line','NA'),
('137','Inc. Doc. Attachment Overview','NA'),
('160','Res. Capacity Entry','NA'),
('172','Standard Customer Sales Code','Setup'),
('179','Reversal Entry','NA'),
('212','Job Posting Buffer','NA'),
('220','Business Unit','NA'),
('221','Gen. Jnl. Allocation','NA'),
('222','Ship-to Address','Master Data'),
('224','Order Address','Transaction'),
('225','Post Code','Setup'),
('230','Source Code','Setup'),
('231','Reason Code','Setup'),
('232','Gen. Journal Batch','Transaction'),
('233','Item Journal Batch','Transaction'),
('242','Source Code Setup','Setup'),
('249','VAT Registration Log','NA'),
('250','Gen. Business Posting Group','Setup'),
('251','Gen. Product Posting Group','Setup'),
('252','General Posting Setup','Setup'),
('255','VAT Statement Template','NA'),
('256','VAT Statement Line','NA'),
('257','VAT Statement Name','NA'),
('270','Bank Account','Setup'),
('271','Bank Account Ledger Entry','Transaction'),
('272','Check Ledger Entry','Transaction'),
('273','Bank Acc. Reconciliation','Transaction'),
('274','Bank Acc. Reconciliation Line','Transaction'),
('275','Bank Account Statement','Transaction'),
('276','Bank Account Statement Line','Transaction'),
('277','Bank Account Posting Group','Transaction'),
('279','Extended Text Header','NA'),
('280','Extended Text Line','NA'),
('286','Territory','Setup'),
('287','Customer Bank Account','NA'),
('288','Vendor Bank Account','NA'),
('290','VAT Amount Line','NA'),
('295','Reminder Header','NA'),
('296','Reminder Line','NA'),
('299','Reminder Comment Line','NA'),
('302','Finance Charge Memo Header','NA'),
('303','Finance Charge Memo Line','NA'),
('306','Fin. Charge Comment Line','NA'),
('308','No. Series','Setup'),
('309','No. Series Line','Setup'),
('310','No. Series Relationship','Setup'),
('323','VAT Business Posting Group','NA'),
('324','VAT Product Posting Group','NA'),
('325','VAT Posting Setup','NA'),
('330','Currency Exchange Rate','NA'),
('338','Entry Summary','NA'),
('340','Customer Discount Group','NA'),
('341','Item Discount Group','NA'),
('348','Dimension','Master Data'),
('349','Dimension Value','Master Data'),
('350','Dimension Combination','Master Data'),
('351','Dimension Value Combination','Master Data'),
('352','Default Dimension','Master Data'),
('354','Default Dimension Priority','NA'),
('363','Analysis View','NA'),
('364','Analysis View Filter','NA'),
('365','Analysis View Entry','NA'),
('366','Analysis View Budget Entry','NA'),
('380','Detailed Vendor Ledg. Entry','Transaction'),
('388','Dimension Translation','NA'),
('394','XBRL Taxonomy','NA'),
('395','XBRL Taxonomy Line','NA'),
('396','XBRL Comment Line','NA'),
('397','XBRL G/L Map Line','NA'),
('398','XBRL Rollup Line','NA'),
('399','XBRL Schema','NA'),
('400','XBRL Linkbase','NA'),
('401','XBRL Taxonomy Label','NA'),
('402','Change Log Setup','Setup'),
('403','Change Log Setup (Table)','Setup'),
('404','Change Log Setup (Field)','Setup'),
('405','Change Log Entry','Setup'),
('410','IC G/L Account','NA'),
('411','IC Dimension','NA'),
('412','IC Dimension Value','NA'),
('413','IC Partner','NA'),
('414','IC Outbox Transaction','NA'),
('415','IC Outbox Jnl. Line','NA'),
('423','IC Inbox/Outbox Jnl. Line Dim.','NA'),
('424','IC Comment Line','NA'),
('426','IC Outbox Sales Header','NA'),
('427','IC Outbox Sales Line','NA'),
('428','IC Outbox Purchase Header','NA'),
('429','IC Outbox Purchase Line','NA'),
('442','IC Document Dimension','NA'),
('550','VAT Rate Change Setup','NA'),
('551','VAT Rate Change Conversion','NA'),
('710','Activity Log','NA'),
('743','VAT Report Setup','NA'),
('750','Standard General Journal','Transaction'),
('751','Standard General Journal Line','Transaction'),
('753','Standard Item Journal Line','Transaction'),
('827','DO Payment Credit Card','NA'),
('828','DO Payment Credit Card Number','NA'),
('871','Social Listening Search Topic','NA'),
('1200','Bank Export/Import Setup','NA'),
('1205','Credit Transfer Register','NA'),
('1206','Credit Transfer Entry','NA'),
('1209','Credit Trans Re-export History','NA'),
('1228','Payment Jnl. Export Error Text','NA'),
('1248','Ledger Entry Matching Buffer','NA'),
('1249','Bank Stmt Multiple Match Line','NA'),
('1250','Bank Statement Matching Buffer','NA'),
('1251','Text-to-Account Mapping','NA'),
('1252','Bank Pmt. Appl. Rule','NA'),
('1260','Bank Data Conv. Service Setup','NA'),
('1280','Bank Clearing Standard','NA'),
('1293','Payment Application Proposal','NA'),
('1294','Applied Payment Entry','NA'),
('1295','Posted Payment Recon. Hdr','NA'),
('1296','Posted Payment Recon. Line','NA'),
('1299','Payment Matching Details','NA'),
('1313','Mini Activities Cue','NA'),
('1500','Workflow Buffer','NA'),
('1501','Workflow','NA'),
('1502','Workflow Step','NA'),
('1505','Workflow - Table Relation','NA'),
('1507','Workflow Step Buffer','NA'),
('1508','Workflow Category','NA'),
('1509','WF Event/Response Combination','NA'),
('1510','Notification Template','NA'),
('1512','Notification Setup','NA'),
('1513','Notification Schedule','NA'),
('1515','Dynamic Request Page Entity','NA'),
('1516','Dynamic Request Page Field','NA'),
('1520','Workflow Event','NA'),
('1521','Workflow Response','NA'),
('1522','Workflow Event Queue','NA'),
('1523','Workflow Step Argument','NA'),
('1524','Workflow Rule','NA'),
('1525','Workflow - Record Change','NA'),
('1526','Workflow Record Change Archive','NA'),
('1530','Workflow Step Instance Archive','NA'),
('1540','Workflow User Group','NA'),
('1541','Workflow User Group Member','NA'),
('5050','Contact','NA'),
('5054','Contact Business Relation','NA'),
('5080','To-do','NA'),
('5086','Cont. Duplicate Search String','NA'),
('5093','Opportunity Entry','NA'),
('5107','Sales Header Archive','Transaction'),
('5108','Sales Line Archive','Transaction'),
('5109','Purchase Header Archive','Transaction'),
('5110','Purchase Line Archive','Transaction'),
('5401','Item Variant','NA'),
('5402','Unit of Measure Translation','NA'),
('5404','Item Unit of Measure','NA'),
('5700','Stockkeeping Unit','NA'),
('5701','Stockkeeping Unit Comment Line','NA'),
('5714','Responsibility Center','NA'),
('5715','Item Substitution','NA'),
('5716','Substitution Condition','NA'),
('5717','Item Cross Reference','NA'),
('5718','Nonstock Item','NA'),
('5765','Warehouse Request','NA'),
('5805','Item Charge Assignment (Purch)','NA'),
('5809','Item Charge Assignment (Sales)','NA'),
('5811','Post Value Entry to G/L','NA'),
('5823','G/L - Item Ledger Relation','NA'),
('5956','Resource Skill','NA'),
('6504','Serial No. Information','NA'),
('6505','Lot No. Information','NA'),
('6506','Item Tracking Comment','NA'),
('6660','Return Receipt Header','NA'),
('6661','Return Receipt Line','NA'),
('7002','Sales Price','Master Data'),
('7004','Sales Line Discount','NA'),
('7012','Purchase Price','Master Data'),
('7014','Purchase Line Discount','NA'),
('7023','Sales Price Worksheet','NA'),
('7152','Item Analysis View','NA'),
('7154','Item Analysis View Entry','NA'),
('7324','Whse. Put-away Request','NA'),
('7325','Whse. Pick Request','NA'),
('7380','Phys. Invt. Item Selection','NA'),
('7381','Phys. Invt. Counting Period','NA'),
('7600','Base Calendar','NA'),
('7601','Base Calendar Change','NA'),
('7602','Customized Calendar Change','NA'),
('7603','Customized Calendar Entry','NA'),
('7704','Item Identifier','NA'),
('9000','User Group','User Admin'),
('9001','User Group Member','User Admin'),
('9002','User Group Access Control','User Admin'),
('9003','User Group Permission Set','User Admin'),
('9150','My Customer','NA'),
('9151','My Vendor','NA'),
('9600','XML Schema','NA'),
('9610','XML Schema Element','NA'),
('9611','XML Schema Restriction','NA'),
('9612','Referenced XML Schema','NA'),
('10120','Bank Rec. Header','Transaction'),
('10121','Bank Rec. Line','Transaction'),
('10122','Bank Comment Line','NA'),
('10123','Posted Bank Rec. Header','Transaction'),
('10124','Posted Bank Rec. Line','Transaction'),
('10140','Deposit Header','Transaction'),
('50000','Customer Dimension Header','Master Data'),
('50001','Customer Dimension Details','Master Data'),
('50002','Customer Dimension Values','Master Data'),
('99000880','Order Promising Line','NA'),
('2000000004','Permission Set','User Admin'),
('2000000005','Permission','User Admin'),
('2000000006','Company','Setup'),
('2000000053','Access Control','User Admin'),
('2000000072','Profile','User Admin'),
('2000000073','User Personalization','User Admin'),
('2000000120','User','User Admin'),
('2000000121','User Property','NA')
GO
/* Step 3 - Create ImportTableTypes.
this Table is just used for the dropdown on my SSRS report.  I have not placed constraints on the initial table as I did all this as an initial upload from Excel*/
IF OBJECT_ID('dbo.ImportantTableTypes') IS NOT NULL DROP TABLE dbo.ImportantTableTypes
GO 
CREATE TABLE [dbo].[ImportantTableTypes](
	[SecurityType] [VARCHAR](15) NOT NULL,
CONSTRAINT PK_ImportantTableTypes PRIMARY KEY CLUSTERED 
(
	[SecurityType] ASC
)
)
GO
INSERT INTO dbo.ImportantTableTypes
(
    SecurityType
)
VALUES
('All'),-- Used for Reporting Dropdown
('Transaction'),
('NA'),
('Setup'),
('User Admin')
GO