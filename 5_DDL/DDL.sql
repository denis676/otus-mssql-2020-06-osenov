-- �������� ��
create database [Angler]
containment = none
on primary
( name = angler, filename = N'D:\������\����������\����� ms sql server 2016\otus-mssql-2020-06-osenov\Angler\angler.mdf',
size = 20MB,
maxsize = unlimited,
filegrowth = 51200KB )
log on
( name = angler_log, filename = N'D:\������\����������\����� ms sql server 2016\otus-mssql-2020-06-osenov\Angler\angler_log.ldf',
size = 20MB,
maxsize = unlimited,
filegrowth = 10240KB )
go

-- �������� ��
drop database test2;

use Angler;
go

--�������� ������
use Angler;
create table Fishman(
	userid int not null identity(0, 1) primary key,
	login nvarchar(30),
	email varchar(30),
	phone int,
	birthday date
);

-- �������� �������
create index idx_email on Fishman (email);
create index idx_phone on Fishman (phone);

-- �������� �������
create table Note(
	noteid int not null identity(0, 1) primary key,
	nameNote nvarchar(30),
	pictureNote varbinary(max),
	dateNote datetime,
	descriptionNote nvarchar(max)
);

-- �������� �������
create index idx_nameNote on Note (nameNote);

-- �������� �������
create table Trophy(
	trophyid int not null identity(0, 1) primary key,
	nameTrophy nvarchar(50),
	weightTrophy decimal(5,2),
	sizeTrophy decimal(5,2),
	pictureTrophy varbinary(max),
	dateTrophy datetime,
	location nvarchar(max),
	descriptionTrophy nvarchar(max)
);

-- �������� �������
create index idx_nameTrophy on Trophy (nameTrophy);

-- �������� �������
create table Fish(
	fishid int not null identity(0, 1) primary key,
	nameFish nvarchar(30),
	pictureFish varbinary(max),
	morphology nvarchar(max),
	lifestyle nvarchar(max)
);

-- �������� �������
create index idx_nameFish on Fish (nameFish);

-- �������� �������
create table FishingMethod(
	fishingMethodid int not null identity(0, 1) primary key,
	nameFishingMethod nvarchar(50),
	descriptionFishingMethod nvarchar(max),
	pictureFishingMethod varbinary(max)
);

-- �������� �������
create index idx_nameFishingMethod on FishingMethod (nameFishingMethod);

-- �������� �������������� �������
use Angler;
create table Fish_FishingMetod(
	fish_fishingMetodid int not null identity(0, 1) primary key,
	fishid int,
	fishingMethodid int
);

--�����������
ALTER TABLE Fishman
	ADD CONSTRAINT constr_login1 
		CHECK (login <> 'admin');

--����������� �� �����
ALTER TABLE Fish_FishingMethod  ADD  CONSTRAINT FK_f_fm FOREIGN KEY(fishid)
REFERENCES Fish (fishid)

ALTER TABLE Fish_FishingMethod  ADD  CONSTRAINT FK_f_fm2 FOREIGN KEY(fishingMethodid)
REFERENCES FishingMethod (fishingMethodid)





