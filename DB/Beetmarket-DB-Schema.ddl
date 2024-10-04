
DROP SEQUENCE basket_seq;



CREATE SEQUENCE basket_seq;



DROP SEQUENCE BasketOpt_seq;



CREATE SEQUENCE BasketOpt_seq;



DROP SEQUENCE BeetPay_seq;



CREATE SEQUENCE BeetPay_seq;



DROP SEQUENCE chatbot_seq;



CREATE SEQUENCE chatbot_seq;



DROP SEQUENCE chatroom_seq;



CREATE SEQUENCE chatroom_seq;



DROP SEQUENCE dlvyAddr_seq;



CREATE SEQUENCE dlvyAddr_seq;



DROP SEQUENCE event_seq;



CREATE SEQUENCE event_seq;



DROP SEQUENCE event_showdown_seq;



CREATE SEQUENCE event_showdown_seq;



DROP SEQUENCE faq_cate_seq;



CREATE SEQUENCE faq_cate_seq;



DROP SEQUENCE faq_image_seq;



CREATE SEQUENCE faq_image_seq;



DROP SEQUENCE faq_seq;



CREATE SEQUENCE faq_seq;



DROP SEQUENCE goods_qna_seq;



CREATE SEQUENCE goods_qna_seq;



DROP SEQUENCE goods_seq;



CREATE SEQUENCE goods_seq;



DROP SEQUENCE goodsImage_seq;



CREATE SEQUENCE goodsImage_seq;



DROP SEQUENCE goodsInfo_seq;



CREATE SEQUENCE goodsInfo_seq;



DROP SEQUENCE goodsLike_seq;



CREATE SEQUENCE goodsLike_seq;



DROP SEQUENCE goodsOption_seq;



CREATE SEQUENCE goodsOption_seq;



DROP SEQUENCE goodsStatus_seq;



CREATE SEQUENCE goodsStatus_seq;



DROP SEQUENCE notice_seq;



CREATE SEQUENCE notice_seq;



DROP SEQUENCE orders_seq;



CREATE SEQUENCE orders_seq;



DROP SEQUENCE point_seq;



CREATE SEQUENCE point_seq;



DROP SEQUENCE PointShopBasket_seq;



CREATE SEQUENCE PointShopBasket_seq;



DROP SEQUENCE PointShopGoodsInfo_seq;



CREATE SEQUENCE PointShopGoodsInfo_seq;



DROP SEQUENCE PointShopOrder_seq;



CREATE SEQUENCE PointShopOrder_seq;



DROP SEQUENCE review_Like_seq;



CREATE SEQUENCE review_Like_seq;



DROP SEQUENCE review_seq;



CREATE SEQUENCE review_seq;



DROP SEQUENCE sell_no_seq;



CREATE SEQUENCE sell_no_seq;



DROP TABLE showdown CASCADE CONSTRAINTS PURGE;



DROP TABLE chatbot CASCADE CONSTRAINTS PURGE;



DROP TABLE cash CASCADE CONSTRAINTS PURGE;



DROP TABLE stock_order CASCADE CONSTRAINTS PURGE;



DROP TABLE Subcirber CASCADE CONSTRAINTS PURGE;



DROP TABLE event CASCADE CONSTRAINTS PURGE;



DROP TABLE stock_inf CASCADE CONSTRAINTS PURGE;



DROP TABLE goods_qna CASCADE CONSTRAINTS PURGE;



DROP TABLE review_reply CASCADE CONSTRAINTS PURGE;



DROP TABLE stock_as_bi CASCADE CONSTRAINTS PURGE;



DROP TABLE chatroom_user CASCADE CONSTRAINTS PURGE;



DROP TABLE chatroom CASCADE CONSTRAINTS PURGE;



DROP TABLE token CASCADE CONSTRAINTS PURGE;



DROP TABLE stock_hold CASCADE CONSTRAINTS PURGE;



DROP TABLE company CASCADE CONSTRAINTS PURGE;



DROP TABLE notice CASCADE CONSTRAINTS PURGE;



DROP TABLE pointShopBasket CASCADE CONSTRAINTS PURGE;



DROP TABLE goodsImage CASCADE CONSTRAINTS PURGE;



DROP TABLE pointShopOrder CASCADE CONSTRAINTS PURGE;



DROP TABLE pointList CASCADE CONSTRAINTS PURGE;



DROP TABLE goodsInfo CASCADE CONSTRAINTS PURGE;



DROP TABLE review_Like CASCADE CONSTRAINTS PURGE;



DROP TABLE review CASCADE CONSTRAINTS PURGE;



DROP TABLE orders CASCADE CONSTRAINTS PURGE;



DROP TABLE pointShopStock CASCADE CONSTRAINTS PURGE;



DROP TABLE pointShopGoodsInfo CASCADE CONSTRAINTS PURGE;



DROP TABLE basketOpt CASCADE CONSTRAINTS PURGE;



DROP TABLE goodsOption CASCADE CONSTRAINTS PURGE;



DROP TABLE basket CASCADE CONSTRAINTS PURGE;



DROP TABLE dlvyAddr CASCADE CONSTRAINTS PURGE;



DROP TABLE beetPay CASCADE CONSTRAINTS PURGE;



DROP TABLE goodsLike CASCADE CONSTRAINTS PURGE;



DROP TABLE goods CASCADE CONSTRAINTS PURGE;



DROP TABLE seller_hub CASCADE CONSTRAINTS PURGE;



DROP TABLE member CASCADE CONSTRAINTS PURGE;



DROP TABLE membership CASCADE CONSTRAINTS PURGE;



DROP TABLE grade CASCADE CONSTRAINTS PURGE;



DROP TABLE goodsStatus CASCADE CONSTRAINTS PURGE;



DROP TABLE category CASCADE CONSTRAINTS PURGE;



DROP TABLE FAQ_image CASCADE CONSTRAINTS PURGE;



DROP TABLE FAQ CASCADE CONSTRAINTS PURGE;



DROP TABLE FAQ_cate CASCADE CONSTRAINTS PURGE;



CREATE TABLE FAQ_cate
(
	cateno                NUMBER  NOT NULL ,
	catename              VARCHAR2(60)  NOT NULL ,
 PRIMARY KEY (cateno)
);



CREATE TABLE FAQ
(
	hit                   NUMBER(8)   DEFAULT  0 NULL ,
	cateno                NUMBER  NOT NULL ,
	faqno                 NUMBER  NOT NULL ,
	question              VARCHAR2(600)  NOT NULL ,
	answer                VARCHAR2(3000)  NOT NULL ,
	answerline            VARCHAR2(600)  NOT NULL ,
	writeDate             VARCHAR2(10)   DEFAULT  sysdate NULL ,
 PRIMARY KEY (faqno),
 FOREIGN KEY (cateno) REFERENCES FAQ_cate(cateno) ON DELETE CASCADE
);



CREATE TABLE FAQ_image
(
	imageno               NUMBER  NOT NULL ,
	imagename             VARCHAR2(200)  NOT NULL ,
	faqno                 NUMBER  NOT NULL ,
 PRIMARY KEY (imageno),
 FOREIGN KEY (faqno) REFERENCES FAQ(faqno) ON DELETE CASCADE
);



CREATE TABLE category
(
	cateHighNo            NUMBER   DEFAULT  0 NOT NULL ,
	cateMidNo             NUMBER   DEFAULT  0 NOT NULL ,
	cateLowNo             NUMBER   DEFAULT  0 NOT NULL ,
	categoryName          VARCHAR2(300)  NOT NULL ,
 PRIMARY KEY (cateHighNo,cateMidNo,cateLowNo)
);



CREATE TABLE goodsStatus
(
	goodsStatusNo         NUMBER  NOT NULL ,
	goodsStatusName       VARCHAR2(300)  NOT NULL ,
 PRIMARY KEY (goodsStatusNo)
);



CREATE TABLE grade
(
	gradeNo               NUMBER(2)  NOT NULL ,
	gradeName             VARCHAR2(30)  NULL ,
 PRIMARY KEY (gradeNo)
);



CREATE TABLE membership
(
	shipNo                NUMBER(2)  NOT NULL ,
	shipName              VARCHAR2(30)  NULL ,
    sale_rate             number(6) DEFAULT 0,
 PRIMARY KEY (shipNo)
);



CREATE TABLE member
(
	id                    VARCHAR2(30)  NOT NULL ,
	name                  VARCHAR2(30)  NOT NULL ,
	email                 VARCHAR2(100)  NOT NULL ,
	pw                    VARCHAR2(60)  NOT NULL ,
	birth                 VARCHAR2(20)  NOT NULL ,
	gender                VARCHAR2(6)   DEFAULT  '남자' NOT NULL  CHECK (gender in('남자','여자')
),
	tel                   VARCHAR2(40)  NOT NULL ,
	regDate               DATE   DEFAULT  sysdate NULL ,
	conDate               DATE   DEFAULT  sysdate NULL ,
	photo                 VARCHAR2(300)   DEFAULT  '/upload/member/image.jpg'
 NULL ,
	status                VARCHAR2(6)   DEFAULT  '정상' NULL  CHECK (status in('정상','탈퇴','휴면','강퇴')),
	newMsgCnt             NUMBER(38)   DEFAULT  0 NULL ,
	sale_rate             NUMBER(6)   DEFAULT  0 NULL ,
	gradeNo               NUMBER(2)   DEFAULT  1 NULL ,
	shipNo                NUMBER(2)   DEFAULT  1 NULL ,
	ship_change_date      DATE  NULL ,
    payPassword           number(6),
 PRIMARY KEY (id),
 FOREIGN KEY (gradeNo) REFERENCES grade(gradeNo) ON DELETE SET NULL,
 FOREIGN KEY (shipNo) REFERENCES membership(shipNo) ON DELETE SET NULL
);



CREATE TABLE seller_hub
(
	merchant_delivery     NUMBER(38)  NULL ,
	Free_Ship_Limit       NUMBER(38)  NULL ,
	sell_no               NUMBER  NOT NULL ,
	id                    VARCHAR2(30)  NULL ,
    store_name            varchar2(100)  not null,
    IS_PENDING            varchar2(20) default '승인대기' CHECK (is_pending in('승인대기','승인','취소')),
 PRIMARY KEY (sell_no),
 FOREIGN KEY (id) REFERENCES member(id) ON DELETE CASCADE
);



CREATE TABLE goods
(
	goodsNo               NUMBER(13)  NOT NULL ,
	goodsName             VARCHAR2(300)  NOT NULL ,
	goodsMainImage        VARCHAR2(300)  NOT NULL ,
	goodsConImage         VARCHAR2(300)  NULL ,
	goodsContent          VARCHAR2(3000)  NULL ,
	goodsHit              NUMBER(8)   DEFAULT  0 NOT NULL ,
	goodsOriPrice         NUMBER(8)   DEFAULT  0 NOT NULL ,
	goodsDiscRate         NUMBER(3)   DEFAULT  0 NULL ,
	goodsDiscount         NUMBER(8)   DEFAULT  0 NOT NULL ,
	goodsPrice            NUMBER(8)   DEFAULT  0 NULL ,
	goodsSavings          NUMBER(8)   DEFAULT  0 NULL ,
	goodsSaveRate         NUMBER(3)   DEFAULT  0 NULL ,
	cateHighNo            NUMBER(1)  NULL ,
	cateMidNo             NUMBER(1)  NULL ,
	cateLowNo             NUMBER(1)  NULL ,
	goodsStatusNo         NUMBER(2)  NULL ,
	sell_no               NUMBER  NULL ,
 PRIMARY KEY (goodsNo),
 FOREIGN KEY (cateHighNo,cateMidNo,cateLowNo) REFERENCES category(cateHighNo,cateMidNo,cateLowNo) ON DELETE SET NULL,
 FOREIGN KEY (goodsStatusNo) REFERENCES goodsStatus(goodsStatusNo) ON DELETE SET NULL,
 FOREIGN KEY (sell_no) REFERENCES seller_hub(sell_no) ON DELETE SET NULL
);



CREATE TABLE goodsLike
(
	goodsLikeNo           NUMBER(13)  NOT NULL ,
	goodsNo               NUMBER(13)  NULL ,
	id                    VARCHAR2(30)  NULL ,
 PRIMARY KEY (goodsLikeNo),
 FOREIGN KEY (goodsNo) REFERENCES goods(goodsNo) ON DELETE SET NULL,
 FOREIGN KEY (id) REFERENCES member(id) ON DELETE SET NULL
);



CREATE TABLE beetPay
(
	beetPayNo             NUMBER  NOT NULL ,
	id                    VARCHAR2(30)  NOT NULL ,
	cardCompany           VARCHAR2(100)  NOT NULL ,
	cardBrand             VARCHAR2(60)  NULL ,
	cardType              VARCHAR2(60)  NOT NULL ,
	cardNumber            VARCHAR2(300)  NOT NULL ,
 PRIMARY KEY (beetPayNo),
 FOREIGN KEY (id) REFERENCES member(id) ON DELETE CASCADE
);



CREATE TABLE dlvyAddr
(
	dlvyAddrNo            NUMBER  NOT NULL ,
	dlvyName              VARCHAR2(30)  NOT NULL ,
	id                    VARCHAR2(30)  NOT NULL ,
	recipient             VARCHAR2(30)  NOT NULL ,
	tel                   VARCHAR2(20)  NOT NULL ,
	addr                  VARCHAR2(300)  NOT NULL ,
	addrDetail            VARCHAR2(300)  NOT NULL ,
	postNo                NUMBER  NOT NULL ,
	basic                 NUMBER(1)   DEFAULT  0 NULL ,
 PRIMARY KEY (dlvyAddrNo),
 FOREIGN KEY (id) REFERENCES member(id) ON DELETE CASCADE
);



CREATE TABLE basket
(
	basketNo              NUMBER  NOT NULL ,
	id                    VARCHAR2(30)  NOT NULL ,
	goodsNo               NUMBER(13)  NOT NULL ,
	writeDate             DATE   DEFAULT  sysdate NULL ,
 PRIMARY KEY (basketNo),
 FOREIGN KEY (id) REFERENCES member(id) ON DELETE CASCADE,
 FOREIGN KEY (goodsNo) REFERENCES goods(goodsNo) ON DELETE CASCADE
);



CREATE TABLE goodsOption
(
	goodsOptNo            NUMBER(13)  NOT NULL ,
	goodsOptName          VARCHAR2(300)  NULL ,
	goodsOptPrice         NUMBER(8)   DEFAULT  0 NULL ,
	goodsNo               NUMBER(13)  NULL ,
 PRIMARY KEY (goodsOptNo),
 FOREIGN KEY (goodsNo) REFERENCES goods(goodsNo) ON DELETE SET NULL
);



CREATE TABLE basketOpt
(
	basketOptNo           NUMBER  NOT NULL ,
	amount                NUMBER  NOT NULL ,
	basketNo              NUMBER  NULL ,
	goodsOptNo            NUMBER(13)  NULL ,
 PRIMARY KEY (basketOptNo),
 FOREIGN KEY (basketNo) REFERENCES basket(basketNo) ON DELETE CASCADE,
 FOREIGN KEY (goodsOptNo) REFERENCES goodsOption(goodsOptNo) ON DELETE SET CASCADE
);



CREATE TABLE pointShopGoodsInfo
(
	goodsId               NUMBER  NOT NULL ,
	category              VARCHAR2(300)  NOT NULL  CHECK (category in('쿠폰','음식','상품')),
	goodsName             VARCHAR2(300)  NOT NULL ,
	goodsImage            VARCHAR2(1200)  NOT NULL ,
	pointAmount           NUMBER  NOT NULL ,
	discountRate          NUMBER(3)  NULL ,
	stopSell              NUMBER(1)   DEFAULT  0 NOT NULL ,
	shipNo                NUMBER(2)  NULL ,
 PRIMARY KEY (goodsId),
 FOREIGN KEY (shipNo) REFERENCES membership(shipNo) ON DELETE SET NULL
);



CREATE TABLE pointShopStock
(
	stockNo               NUMBER  NOT NULL ,
	stockState            VARCHAR2(300)   DEFAULT  '판매중'
 NOT NULL  CHECK (stockState in('판매중','판매완료','사용완료')),
	goodsId               NUMBER  NULL ,
 PRIMARY KEY (stockNo),
 FOREIGN KEY (goodsId) REFERENCES pointShopGoodsInfo(goodsId) ON DELETE CASCADE
);



CREATE TABLE orders
(
	orderNo               NUMBER  NOT NULL ,
	id                    VARCHAR2(30)  NOT NULL ,
	orderDate             DATE   DEFAULT  sysdate NULL ,
	dlvyName              VARCHAR2(30)  NOT NULL ,
	recipient             VARCHAR2(30)  NOT NULL ,
	tel                   VARCHAR2(20)  NOT NULL ,
	addr                  VARCHAR2(300)  NOT NULL ,
	addrDetail            VARCHAR2(300)  NOT NULL ,
	postNo                NUMBER  NOT NULL ,
	dlvyMemo              VARCHAR2(300)  NULL ,
	goodsNo               NUMBER(13)  NOT NULL ,
	orderPrice            NUMBER  NOT NULL ,
	dlvyCharge            NUMBER  NOT NULL ,
	payWay                VARCHAR2(30)  NOT NULL ,
	payDetail             VARCHAR2(100)  NULL ,
	paymentKey            VARCHAR2(30)  NULL ,
	orderState            VARCHAR2(30)   DEFAULT  '결제완료' NOT NULL  CHECK (orderState in('결제완료','배송준비','배송중','배송완료','구매확정','취소요청','반품요청','요청처리')
),
	confirmDate           DATE  NULL ,
	reviewExist           NUMBER(1)   DEFAULT  0 NULL ,
	cancleReason          VARCHAR2(300)  NULL ,
	amount                NUMBER  NOT NULL ,
	stockNo               NUMBER  NULL ,
	goodsOptNo            NUMBER(13)  NULL ,
 PRIMARY KEY (orderNo),
 FOREIGN KEY (stockNo) REFERENCES pointShopStock(stockNo) ON DELETE SET NULL,
 FOREIGN KEY (id) REFERENCES member(id) ON DELETE CASCADE,
 FOREIGN KEY (goodsOptNo) REFERENCES goodsOption(goodsOptNo) ON DELETE SET NULL,
 FOREIGN KEY (goodsNo) REFERENCES goods(goodsNo)
);



CREATE TABLE review
(
	orderNo               NUMBER  NULL ,
	reviewContent         VARCHAR2(1000)  NOT NULL ,
	reviewNo              NUMBER  NOT NULL ,
	WriteDate             DATE   DEFAULT  sysdate NULL ,
	starscore             NUMBER  NOT NULL ,
	reviewImage           VARCHAR2(200)  NULL ,
 PRIMARY KEY (reviewNo),
 FOREIGN KEY (orderNo) REFERENCES orders(orderNo) ON DELETE SET NULL
);



CREATE TABLE review_Like
(
	id                    VARCHAR2(30)  NOT NULL ,
	reviewNo              NUMBER  NOT NULL ,
	reviewLike_No         NUMBER  NOT NULL ,
 PRIMARY KEY (reviewLike_No),
 FOREIGN KEY (reviewNo) REFERENCES review(reviewNo) ON DELETE SET NULL,
 FOREIGN KEY (id) REFERENCES member(id) ON DELETE SET NULL
);



CREATE TABLE goodsInfo
(
	goodsInfoNo           NUMBER(13)  NOT NULL ,
	goodsInfoName         VARCHAR2(300)  NULL ,
	goodsInfoCon          VARCHAR2(300)  NULL ,
	goodsNo               NUMBER(13)  NULL ,
 PRIMARY KEY (goodsInfoNo),
 FOREIGN KEY (goodsNo) REFERENCES goods(goodsNo) ON DELETE SET NULL
);



CREATE TABLE pointList
(
	pointList_no          NUMBER  NOT NULL ,
	point_entity          VARCHAR2(100)  NOT NULL ,
	point_delta           NUMBER  NOT NULL ,
	redeemed_date         DATE   DEFAULT  sysdate NOT NULL ,
	id                    VARCHAR2(30)  NOT NULL ,
 PRIMARY KEY (pointList_no),
 FOREIGN KEY (id) REFERENCES member(id) ON DELETE CASCADE
);



CREATE TABLE pointShopOrder
(
	pointShopOrder        NUMBER  NOT NULL ,
	stockNo               NUMBER  NOT NULL ,
	orderDate             DATE   DEFAULT  sysdate NULL ,
	orderPoint            NUMBER  NOT NULL ,
	id                    VARCHAR2(30)  NOT NULL ,
 PRIMARY KEY (pointShopOrder),
 FOREIGN KEY (stockNo) REFERENCES pointShopStock(stockNo) ON DELETE CASCADE,
 FOREIGN KEY (id) REFERENCES member(id) ON DELETE CASCADE
);



CREATE TABLE goodsImage
(
	goodsImageNo          NUMBER(13)  NOT NULL ,
	goodsImageName        VARCHAR2(300)  NULL ,
	goodsNo               NUMBER(13)  NULL ,
 PRIMARY KEY (goodsImageNo),
 FOREIGN KEY (goodsNo) REFERENCES goods(goodsNo) ON DELETE SET NULL
);



CREATE TABLE pointShopBasket
(
	pointShopBasketNo     NUMBER  NOT NULL ,
	goodsId               NUMBER  NULL ,
	amount                NUMBER   DEFAULT  1 NULL ,
	id                    VARCHAR2(30)  NOT NULL ,
	writeDate             DATE   DEFAULT  sysdate NULL ,
 PRIMARY KEY (pointShopBasketNo),
 FOREIGN KEY (goodsId) REFERENCES pointShopGoodsInfo(goodsId) ON DELETE CASCADE,
 FOREIGN KEY (id) REFERENCES member(id) ON DELETE CASCADE
);



CREATE TABLE notice
(
	noticeNo              NUMBER  NOT NULL ,
	title                 VARCHAR2(200)  NULL ,
	content               VARCHAR2(2000)  NULL ,
	startDate             DATE  NULL ,
	endDate               DATE   DEFAULT  '9999-12-30' NULL ,
	writeDate             VARCHAR2(20)   DEFAULT  sysdate NOT NULL ,
	updateDate            VARCHAR2(10)   DEFAULT  sysdate NULL ,
	status                VARCHAR2(10)   DEFAULT  '활성화'
 NULL  CHECK (status in('신청 중', '신청 거절')),
	pw                    VARCHAR2(10)  NULL ,
 PRIMARY KEY (noticeNo)
);



CREATE TABLE company
(
	image                 VARCHAR2(300)  NOT NULL ,
	company_name          VARCHAR2(100)  NOT NULL ,
	company_code          VARCHAR2(100)  NOT NULL ,
 PRIMARY KEY (company_code)
);



CREATE TABLE stock_hold
(
	stock_hold_no         NUMBER  NOT NULL ,
	order_date            DATE  NOT NULL ,
	price                 NUMBER  NOT NULL ,
	stock_hold_cnt        NUMBER(20)  NOT NULL ,
	id                    VARCHAR2(30)  NOT NULL ,
	company_code          VARCHAR2(100)  NULL ,
 PRIMARY KEY (stock_hold_no),
 FOREIGN KEY (company_code) REFERENCES company(company_code) ON DELETE SET NULL,
 FOREIGN KEY (id) REFERENCES member(id) ON DELETE SET NULL
);



CREATE TABLE token
(
	token_no              NUMBER  NOT NULL ,
	expried               DATE  NULL ,
	token_code            VARCHAR2(400)  NULL ,
 PRIMARY KEY (token_no)
);



CREATE TABLE chatroom
(
	roomno                NUMBER  NOT NULL ,
 PRIMARY KEY (roomno)
);



CREATE TABLE chatroom_user
(
	deleted               DATE    NULL ,
	roomno                NUMBER  NOT NULL ,
	user_id               VARCHAR2(30)  NOT NULL ,
 PRIMARY KEY (roomno,user_id),
 FOREIGN KEY (roomno) REFERENCES chatroom(roomno) ON DELETE SET NULL,
 FOREIGN KEY (roomno) REFERENCES chatroom(roomno),
 FOREIGN KEY (user_id) REFERENCES member(id)
);



CREATE TABLE stock_as_bi
(
	stock_as_bi_no        VARCHAR2(10)  NOT NULL ,
	askp1                 VARCHAR2(10)  NOT NULL ,
	askp2                 VARCHAR2(10)  NOT NULL ,
	askp3                 VARCHAR2(10)  NOT NULL ,
	askp4                 VARCHAR2(10)  NOT NULL ,
	askp5                 VARCHAR2(10)  NOT NULL ,
	bidp1                 VARCHAR2(10)  NOT NULL ,
	bidp2                 VARCHAR2(10)  NOT NULL ,
	bidp3                 VARCHAR2(10)  NOT NULL ,
	bidp4                 VARCHAR2(10)  NOT NULL ,
	bidp5                 VARCHAR2(10)  NOT NULL ,
	askp_rsqn1            VARCHAR2(12)  NOT NULL ,
	askp_rsqn2            VARCHAR2(12)  NOT NULL ,
	askp_rsqn3            VARCHAR2(12)  NOT NULL ,
	askp_rsqn4            VARCHAR2(12)  NOT NULL ,
	askp_rsqn5            VARCHAR2(12)  NOT NULL ,
	bidp_rsqn1            VARCHAR2(12)  NOT NULL ,
	bidp_rsqn2            VARCHAR2(12)  NOT NULL ,
	bidp_rsqn3            VARCHAR2(12)  NOT NULL ,
	bidp_rsqn4            VARCHAR2(12)  NOT NULL ,
	bidp_rsqn5            VARCHAR2(12)  NOT NULL ,
	total_askp_rsqn       VARCHAR2(20)  NOT NULL ,
	total_bidp_rsqn       VARCHAR2(20)  NOT NULL ,
	ckeckDate             DATE  NULL ,
	company_code          VARCHAR2(100)  NULL ,
 PRIMARY KEY (stock_as_bi_no),
 FOREIGN KEY (company_code) REFERENCES company(company_code) ON DELETE SET NULL
);



CREATE TABLE review_reply
(
	id                    VARCHAR2(30)  NOT NULL ,
	reviewNo              NUMBER  NOT NULL ,
	content               VARCHAR2(1000)  NOT NULL ,
	WriteDate             DATE   DEFAULT  sysdate NULL ,
 PRIMARY KEY (reviewNo),
 FOREIGN KEY (reviewNo) REFERENCES review(reviewNo),
 FOREIGN KEY (id) REFERENCES member(id) ON DELETE SET NULL
);



CREATE TABLE goods_qna
(
	goodsNo               NUMBER(13)  NULL ,
	id                    VARCHAR2(30)  NOT NULL ,
	answerDate            DATE  NULL ,
	goodsQNA              NUMBER  NOT NULL ,
	question              VARCHAR2(1000)  NOT NULL ,
	answer                VARCHAR2(1000)  NULL ,
	writeDate             DATE   DEFAULT  sysdate NOT NULL ,
	status                VARCHAR2(20)   DEFAULT  '답변대기중' NOT NULL ,
 PRIMARY KEY (goodsQNA),
 FOREIGN KEY (id) REFERENCES member(id) ON DELETE SET NULL,
 FOREIGN KEY (goodsNo) REFERENCES goods(goodsNo) ON DELETE SET NULL
);



CREATE TABLE stock_inf
(
	stock_info_no         NUMBER  NOT NULL ,
	acml_tr_pbmn          NUMBER  NOT NULL ,
	acml_vol              VARCHAR2(20)  NOT NULL ,
	prdy_ctrt             VARCHAR2(20)  NOT NULL ,
	prdy_vrss             VARCHAR2(20)  NOT NULL ,
	stck_prpr             VARCHAR2(20)  NOT NULL ,
	check_date            DATE  NOT NULL ,
	company_code          VARCHAR2(100)  NULL ,
	stck_oprc             NUMBER(20)  NOT NULL ,
	stck_hgpr             NUMBER(20)  NOT NULL ,
	stck_lwpr             NUMBER(20)  NOT NULL ,
	stck_mxpr             NUMBER(20)  NOT NULL ,
	stck_llam             NUMBER(20)  NOT NULL ,
	per                   NUMBER(20)  NOT NULL ,
	pbr                   NUMBER(20)  NOT NULL ,
	eps                   NUMBER(20)  NOT NULL ,
	bps                   NUMBER(20)  NOT NULL ,
 PRIMARY KEY (stock_info_no),
 FOREIGN KEY (company_code) REFERENCES company(company_code) ON DELETE CASCADE
);



CREATE TABLE event
(
	eventNo               NUMBER  NOT NULL ,
	title                 VARCHAR2(20)  NULL ,
	content               VARCHAR2(2000)  NULL ,
	startDate             DATE  NULL ,
	endDate               DATE  NULL ,
	showdownDate          DATE  NULL ,
	writeDate             DATE   DEFAULT  sysdate NULL ,
	updateDate            VARCHAR2(10)   DEFAULT  sysdate NULL ,
	id                    VARCHAR2(30)  NULL ,
	image                 VARCHAR2(300)  NULL ,
	pw                    VARCHAR2(10)  NULL ,
 PRIMARY KEY (eventNo),
 FOREIGN KEY (id) REFERENCES member(id) ON DELETE SET NULL
);



CREATE TABLE Subcirber
(
	subcirberNo           VARCHAR2(10)  NOT NULL ,
	id                    VARCHAR2(30)  NULL ,
	eventNo               NUMBER  NULL ,
 PRIMARY KEY (subcirberNo),
 FOREIGN KEY (eventNo) REFERENCES event(eventNo) ON DELETE SET NULL,
 FOREIGN KEY (id) REFERENCES member(id) ON DELETE SET NULL
);



CREATE TABLE stock_order
(
	stock_order_no        NUMBER  NOT NULL ,
	order_date            DATE  NOT NULL ,
	order_state           VARCHAR2(20)  NOT NULL ,
	order_type            VARCHAR2(20)  NOT NULL ,
	price                 NUMBER(20)  NOT NULL ,
	stock_count           NUMBER(10)  NOT NULL ,
	id                    VARCHAR2(30)  NOT NULL ,
	company_code          VARCHAR2(100)  NULL ,
 PRIMARY KEY (stock_order_no),
 FOREIGN KEY (company_code) REFERENCES company(company_code) ON DELETE SET NULL,
 FOREIGN KEY (id) REFERENCES member(id) ON DELETE SET NULL
);



CREATE TABLE cash
(
	cash_no               NUMBER  NOT NULL ,
	create_date           DATE  NOT NULL ,
	money                 NUMBER   DEFAULT  50000000 NOT NULL ,
	id                    VARCHAR2(30)  NULL ,
 PRIMARY KEY (cash_no),
 FOREIGN KEY (id) REFERENCES member(id) ON DELETE SET NULL
);



CREATE TABLE chatbot
(
	chatno                NUMBER  NOT NULL ,
	content               VARCHAR2(1800)  NOT NULL ,
	sender                VARCHAR2(30)  NOT NULL ,
	senddate              DATE   DEFAULT  sysdate NOT NULL ,
	accepter              VARCHAR2(30)  NOT NULL ,
	acceptdate            DATE  NULL ,
	roomno                NUMBER  NULL ,
 PRIMARY KEY (chatno),
 FOREIGN KEY (sender) REFERENCES member(id) ON DELETE SET NULL,
 FOREIGN KEY (accepter) REFERENCES member(id) ON DELETE SET NULL,
 FOREIGN KEY (roomno) REFERENCES chatroom(roomno) ON DELETE SET NULL
);



CREATE TABLE showdown
(
	showdownNo            NUMBER  NOT NULL ,
	title                 VARCHAR2(20)  NULL ,
	content               VARCHAR2(300)  NULL ,
	writeDate             DATE  NULL ,
	updateDate            DATE  NULL ,
	eventNo               NUMBER  NULL ,
	pw                    VARCHAR2(10)  NULL ,
 PRIMARY KEY (showdownNo),
 FOREIGN KEY (eventNo) REFERENCES event(eventNo) ON DELETE SET NULL
);


