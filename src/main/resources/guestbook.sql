-- guestbook(방명록)

create table guestbook(
	seqno number primary key,
	guestname varchar2(30) not null,
	guestpwd varchar2(10) not null,
	regdate date default sysdate,
	text varchar2(2000) not null
);

create sequence seqno;