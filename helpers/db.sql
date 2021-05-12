CREATE TABLE Alert (AlertId Varchar(255) PRIMARY KEY, FileName VARCHAR(255), userId VARCHAR(255), FOREIGN KEY (userid) REFERENCES User(userid));

CREATE TABLE User (userId Varchar(255) PRIMARY KEY, userName VARCHAR(255), pwd VARCHAR(255));

CREATE TABLE Files (FilesId Varchar(255) PRIMARY KEY, FileLink VARCHAR(255), userId VARCHAR(255), FOREIGN KEY (userid) REFERENCES User(userid));