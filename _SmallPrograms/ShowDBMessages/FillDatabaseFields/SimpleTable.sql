CREATE TABLE p5_messages
(
  id int(11) NOT NULL auto_increment,
  creator varchar(32) default NULL,
  message varchar(160) default NULL,
  date_added datetime default NULL,
  PRIMARY KEY  (id)
) ENGINE=MyISAM CHARSET=latin1;
