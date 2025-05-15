CREATE SEQUENCE user_id_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE TABLE users (
    userid    NUMBER PRIMARY KEY,
    username  VARCHAR2(50) NOT NULL,
    password  VARCHAR2(50) NOT NULL,
    name      VARCHAR2(100),
    age       NUMBER,
    CONSTRAINT uq_username UNIQUE (username)
);

CREATE OR REPLACE TRIGGER trg_user_id
BEFORE INSERT ON users
FOR EACH ROW
BEGIN
    SELECT user_id_seq.NEXTVAL INTO :NEW.userid FROM dual;
END;
/

CREATE SEQUENCE seq_board_id
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE TABLE board (
    board_id   NUMBER PRIMARY KEY,
    title      VARCHAR2(200) NOT NULL,
    content    CLOB NOT NULL,
    writer_id  NUMBER NOT NULL,
    created_at DATE DEFAULT SYSDATE,
    CONSTRAINT fk_writer FOREIGN KEY (writer_id)
        REFERENCES users(userid)
);

CREATE OR REPLACE TRIGGER trg_board_id
BEFORE INSERT ON board
FOR EACH ROW
BEGIN
    :NEW.board_id := seq_board_id.NEXTVAL;
END;
/

CREATE TABLE comments (
    comment_id  NUMBER PRIMARY KEY,
    board_id    NUMBER NOT NULL,
    writer_id   NUMBER NOT NULL,
    content     VARCHAR2(1000),
    created_at  DATE DEFAULT SYSDATE,
    CONSTRAINT fk_comments_board FOREIGN KEY (board_id)
        REFERENCES board(board_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_comments_user FOREIGN KEY (writer_id)
        REFERENCES users(userid)
);

CREATE SEQUENCE comments_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

select * from users;