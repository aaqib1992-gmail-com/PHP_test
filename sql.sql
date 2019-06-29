DROP DATABASE IF EXISTS races;
CREATE DATABASE races;

USE races;

CREATE TABLE races (
    id int not null AUTO_INCREMENT,
    name VARCHAR(255),
    number int,
    start_date DATETIME,
    meeting_name VARCHAR(255),
    distance int,
    status_id INT,
    PRIMARY KEY (id)
);

CREATE TABLE runners (
    id int not null AUTO_INCREMENT,
    name VARCHAR(255),
    number int,
    race_id int,
    status_id INT,
    PRIMARY KEY (id)
);

CREATE TABLE race_status (
    id int not null AUTO_INCREMENT,
    name VARCHAR(255),
    PRIMARY KEY (id)
);

CREATE TABLE runner_status (
    id int not null AUTO_INCREMENT,
    name VARCHAR(255),
    PRIMARY KEY (id)
);

INSERT INTO race_status VALUES (1, 'open'), (2, 'closed'), (3, 'interim'), (4, 'paid');

INSERT INTO runner_status VALUES (1, 'not scratched'), (2, 'scratched'), (3, 'late scratching');

INSERT INTO races (name, number, start_date, meeting_name, distance, status_id) VALUES
('Win Network F&M Maiden Plate','1','2018-04-09 13:30:00','MOE','1000','1'),
('Collis Hair Design Maiden Plate','2','2018-04-09 14:00:00','MOE','1100','1'),
('Tycass Excavation 3YO Fillies Maiden Plate','3','2018-04-09 14:30:00','MOE','1200','1'),
('Nextra Moe Maiden Plate','4','2018-04-09 15:00:00','MOE','2050','1'),
('Butchers on George Rising Stars Race BM58 Handicap','5','2018-04-09 15:30:00','MOE','1600','1'),
('Crackerjack Communications BM58 Handicap','6','2018-04-09 16:00:00','MOE','1000','1'),
('Changing Seasons Class 1 Handicap','7','2018-04-09 16:30:00','MOE','2050','1'),
('Moe Optical BM58 Handicap','8','2018-04-09 17:00:00','MOE','1200','1');

INSERT INTO runners (name, number, race_id, status_id) VALUES
('CHAMPAGNE SCENT','1','1','2'),
('FLYING ENCOUNTER','2','1','1'),
('HOW ONE KNOWS','3','1','1'),
('SARCASTIC','4','1','1'),
('DOLLY ANN','5','1','1'),
('SFILZA','6','1','1'),
('CRESTA COSMIC','1','2','1'),
('DAZOLT','2','2','1'),
('NEED TO WIN','3','2','1'),
('ROCKYS ECHO','4','2','1'),
('SUTHEBYS','5','2','1'),
('TRAFFIC COP','6','2','1'),
('CALAIS VIEW','7','2','1'),
('FREDRIKKE','8','2','1'),
('DILETTANTE','9','2','1'),
('BELCHAMP','1','3','1'),
('DURGA SHREE','2','3','1'),
('FABRICATION','3','3','1'),
('FOOT FOOT','4','3','1'),
('INGENIUM','5','3','1'),
('NANITA','6','3','1'),
('NANITA','6','3','1'),
('PARK HUSSLER','7','3','1'),
('POPPY MAI','8','3','1'),
('SECRET RUBY','9','3','1'),
('FULL OF THEORIES','1','4','1'),
('INGENUE','10','4','1'),
('THATS ALL ZARIZ','2','4','1'),
('ANACHEEVA PRINCE','3','4','1'),
('JEPARIT','4','4','1'),
('MY SUPERSTAR','5','4','1'),
('OENOPHILE','6','4','1'),
('SLICK BACK','7','4','1'),
('CHICOLABEL','8','4','1'),
('GONDOLA','9','4','1'),
('FORTHEFUNOFIT','1','5','1'),
('HONOURABLE TYCOON','2','5','1'),
('BLUE BEAR','3','5','1'),
('FORAOISE','4','5','1'),
('ALL COME TRUE','5','5','1'),
('BIG ROY','6','5','1'),
('KARAKORAM','7','5','1'),
('MR CHARISMA','8','5','1'),
('BOLSHOI BELLE','9','5','1'),
('THUMBTACKS','1','6','1'),
('RAGTIME','10','6','1'),
('ATOMIC LOKADE','2','6','1'),
('PAMELA JOY','3','6','2'),
('UNSHACKLED','4','6','2'),
('MISS NITRO','5','6','1'),
('WRITTEN CONSENT','6','6','1'),
('VICTORIA HARBOUR','7','6','1'),
('YOUNG FARRELLY','8','6','1'),
('BEMARYDAN','9','6','1'),
('ALL HARD WOOD','1','7','1'),
('ALLYS REWARD','10','7','1'),
('ZATSO','11','7','2'),
('CHILEAN WONDER','12','7','1'),
('THEY CALL ME SVEN','13','7','2'),
('AGREEMENT','14','7','1'),
('MOSS N BOLT','2','7','1'),
('TAN CHECK','3','7','2'),
('LOUISVILLE LIP','4','7','1'),
('SO YOU LEICA','5','7','1'),
('UNDER OATH','6','7','2'),
('SMOKING BULLET','7','7','1'),
('BAUMGARTNER MISS','8','7','1'),
('STORNAWAY','9','7','1'),
('EXPLICITLY','1','8','1'),
('DAME VASSA','10','8','1'),
('BLACK MARY','11','8','1'),
('LOCHEND EMMAROSE','12','8','1'),
('THE TALE OF AVER','13','8','1'),
('MOSS AND ME','14','8','1'),
('STANBOROUGH','2','8','1'),
('ALUF','3','8','1'),
('CHANNING','4','8','2'),
('LONGNECK LARRY','5','8','1'),
('BOOKBUILD','6','8','1'),
('SKIP TOWN MIKE','7','8','1'),
('CRISIS POINT','8','8','1'),
('KURGAN','9','8','1');
